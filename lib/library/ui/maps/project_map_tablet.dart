import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:animations/animations.dart';
import 'package:badges/badges.dart' as bd;
import 'package:flutter/material.dart';
import 'package:geo_monitor/library/api/prefs_og.dart';
import 'package:geo_monitor/library/bloc/fcm_bloc.dart';
import 'package:geo_monitor/library/bloc/old_to_realm.dart';
import 'package:geo_monitor/library/bloc/organization_bloc.dart';
import 'package:geo_monitor/library/bloc/project_bloc.dart';
import 'package:geo_monitor/realm_data/data/realm_sync_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:realm/realm.dart';

import '../../../device_location/device_location_bloc.dart';
import '../../../l10n/translation_handler.dart';
import '../../api/data_api_og.dart';
import '../../cache_manager.dart';
import '../../data/city.dart';
import '../../data/photo.dart';
import '../../data/position.dart' as local;
import '../../data/project.dart';
import '../../data/project_polygon.dart';
import '../../data/project_position.dart';
import '../../data/user.dart';
import '../../emojis.dart';
import '../../functions.dart';
import 'package:geo_monitor/realm_data/data/schemas.dart' as mrm;
import 'package:geo_monitor/realm_data/data/schemas.dart' as mrm;

class ProjectMapTablet extends StatefulWidget {
  final mrm.Project project;
  final mrm.Photo? photo;

  const ProjectMapTablet({
    super.key,
    required this.project,
    this.photo,
  });

  @override
  ProjectMapTabletState createState() => ProjectMapTabletState();
}

class ProjectMapTabletState extends State<ProjectMapTablet>
    with SingleTickerProviderStateMixin {
  final mm = '🔷🔷🔷ProjectMapTablet: ';
  late AnimationController _animationController;
  final Completer<GoogleMapController> _mapController = Completer();

  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  var random = Random(DateTime.now().millisecondsSinceEpoch);
  final _key = GlobalKey<ScaffoldState>();
  bool _showNewPositionUI = false;
  bool busy = false;
  mrm.User? user;
  CameraPosition? _kGooglePlex;
  final Set<Polygon> _polygons = HashSet<Polygon>();
  final Set<Circle> circles = HashSet<Circle>();
  var projectPolygons = <mrm.ProjectPolygon>[];
  var projectPositions = <mrm.ProjectPosition>[];
  late StreamSubscription<ProjectPosition> _positionStreamSubscription;
  late StreamSubscription<ProjectPolygon> _polygonStreamSubscription;
  GoogleMapController? googleMapController;
  double _longPressLat = 0.0, _longPressLng = 0.0;
  String? address, projectLocationsAreas, locations, location;

  late mrm.SettingsModel sett;
  @override
  void initState() {
    _animationController = AnimationController(
        value: 0.0,
        duration: const Duration(milliseconds: 2000),
        reverseDuration: const Duration(milliseconds: 1500),
        vsync: this);
    super.initState();
    _setTexts();
    _getUser();
    _setMarkerIcon();
    _listen();
  }

  void _listen() async {
    _positionStreamSubscription =
        fcmBloc.projectPositionStream.listen((event) async {
      await _refreshData(false);
      if (mounted) {
        _addMarkers();
        _buildCircles();
        _buildProjectPolygons();

        if (projectPositions.isNotEmpty) {
          var p = projectPolygons.first.positions.first;
          var lat = p.coordinates[1];
          var lng = p.coordinates[0];
          _animateCamera(latitude: lat, longitude: lng, zoom: 10.0);
        }
        // _animateCamera(latitude: 0.0, longitude: 0.0, zoom: 2.0);
        setState(() {});
      }
    });
    _polygonStreamSubscription =
        fcmBloc.projectPolygonStream.listen((event) async {
      await _refreshData(false);

      if (mounted) {
        _addMarkers();
        _buildCircles();
        _buildProjectPolygons();
        if (projectPolygons.isNotEmpty) {
          var p = projectPolygons.first.positions.first;
          var lat = p.coordinates[1];
          var lng = p.coordinates[0];
          _animateCamera(latitude: lat, longitude: lng, zoom: 10.0);
        }
        // _animateCamera(latitude: 0.0, longitude: 0.0, zoom: 2.0);
        setState(() {});
      }
    });
  }

  void _buildCircles() {
    double dist = sett.distanceFromProject!.toDouble();
    pp('$mm drawing circles for project positions: ${projectPositions.length}, monitorMaxDistanceInMetres: $dist == null? 100 : $dist');
    for (var pos in projectPositions) {
      circles.add(Circle(
          center: LatLng(
              pos.position!.coordinates[1], pos.position!.coordinates[0]),
          radius: dist ?? 300,
          fillColor: Colors.black26,
          strokeWidth: 4,
          strokeColor: Colors.pink,
          circleId: CircleId(
              '${pos.projectId!}_${DateTime.now().microsecondsSinceEpoch}')));
    }
  }

  void _setMarkerIcon() async {
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(4.0, 4.0)),
      "assets/avatar.png",
    ).then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  double? currentLat, currentLng;

  void _getUser() async {
    var p = await prefsOGx.getUser();
    user = OldToRealm.getUser(p!);
    var loc = await locationBloc.getLocation();
    currentLat = loc.latitude;
    currentLng = loc.longitude;
    _kGooglePlex =
        CameraPosition(target: LatLng(currentLat!, currentLng!), zoom: 12.6);

    setState(() {});
  }
  void _setTexts() async {
    var p = await prefsOGx.getSettings();
    sett = OldToRealm.getSettings(p);
    projectLocationsAreas = await translator.translate('projectLocationsAreas', sett!.locale!);
    var loc = await translator.translate('location', sett!.locale!);
    location = loc.replaceAll('\$count', '');
    locations = await translator.translate('locations', sett!.locale!);

  }

  Future _refreshData(bool forceRefresh) async {
    setState(() {
      busy = true;
    });
    try {
      var map = await getStartEndDates();
      final startDate = map['startDate'];
      final endDate = map['endDate'];
      projectPolygons = realmSyncApi.getProjectPolygons(projectId: widget.project.projectId!);
      projectPositions = realmSyncApi.getProjectPositions(projectId: widget.project.projectId!);
    } catch (e) {
      pp(e);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('$e')));
      }
    }
    setState(() {
      busy = false;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _polygonStreamSubscription.cancel();
    _positionStreamSubscription.cancel();
    super.dispose();
  }

  Future<void> _addMarkers() async {
    pp('$mm _addMarkers: ....... 🍎 ${projectPositions.length}');
    if (projectPositions.isEmpty) {
      pp('There are no positions found ${E.redDot}');
      return;
    }
    markers.clear();
    var latLongs = <LatLng>[];
    var cnt = 0;
    for (var projectPosition in projectPositions) {
      var latLng = LatLng(projectPosition.position!.coordinates[1],
          projectPosition.position!.coordinates[0]);
      latLongs.add(latLng);
      cnt++;
      final MarkerId markerId =
          MarkerId('${projectPosition.projectId}_${random.nextInt(9999988)}');
      final Marker marker = Marker(
        markerId: markerId,
        icon: markerIcon,
        position: LatLng(
          projectPosition.position!.coordinates.elementAt(1),
          projectPosition.position!.coordinates.elementAt(0),
        ),
        infoWindow: InfoWindow(
            title: projectPosition.projectName,
            snippet: location == null?
                'Location #$cnt' :
        '$location $cnt'),
        onTap: () {
          _onMarkerTapped(projectPosition);
        },
      );
      markers[markerId] = marker;
    }
    googleMapController = await _mapController.future;
    if (projectPositions.isNotEmpty) {
      var lat = projectPositions.first.position!.coordinates[1];
      var lng = projectPositions.first.position!.coordinates[0];
      _animateCamera(latitude: lat, longitude: lng, zoom: 14.0);
    }
  }

  void _buildProjectPolygons() {
    pp('$mm _buildProjectPolygons happening ... projectPolygons: ${projectPolygons.length}');
    _polygons.clear();
    for (var polygon in projectPolygons) {
      var points = <LatLng>[];
      for (var position in polygon.positions) {
        points.add(LatLng(position.coordinates[1], position.coordinates[0]));
      }
      _polygons.add(Polygon(
        polygonId: PolygonId(polygon.projectPolygonId!),
        points: points,
        fillColor: Colors.black26,
        strokeColor: Colors.pink,
        geodesic: true,
        strokeWidth: 4,
      ));
    }

    pp('$mm _buildProjectPolygons: 🍏project polygons created.: '
        '🔵 ${_polygons.length} points in polygon ...');
    if (projectPolygons.isNotEmpty) {
      var p = projectPolygons.first.positions.first;
      var lat = p.coordinates[1];
      var lng = p.coordinates[0];
      _animateCamera(latitude: lat, longitude: lng, zoom: 10.0);
    }
    setState(() {});
  }

  void _onMarkerTapped(mrm.ProjectPosition projectPosition) {
    pp('💜 💜 💜 💜 💜 💜 ProjectMapTablet: _onMarkerTapped ....... ${projectPosition.projectName}');
  }

  void _onLongPress(LatLng argument) {
    pp('\n$mm Map detected a long press! at $argument');
    if (user!.userType == UserType.fieldMonitor) {
      pp('$mm Field Monitor not allowed to create new project position; 🔶 quitting!');
      return;
    }
    _longPressLat = argument.latitude;
    _longPressLng = argument.longitude;

    pp('\n$mm ... before setting state; _longPressLat: $_longPressLat _longPressLng: $_longPressLng');

    setState(() {
      _showNewPositionUI = true;
    });
    _animationController.forward();
  }

  Future<bool> _isLocationWithinProjectMonitorDistance(
      {required double latitude, required double longitude}) async {
    var map = <double, mrm.ProjectPosition>{};
    for (var i = 0; i < projectPositions.length; i++) {
      var projPos = projectPositions.elementAt(i);
      var dist = locationBloc.getDistance(
          latitude: projPos.position!.coordinates.elementAt(1),
          longitude: projPos.position!.coordinates.elementAt(0),
          toLatitude: latitude,
          toLongitude: longitude);

      map[dist] = projPos;
      pp('$mm Distance: 🌶 $dist metres 🌶 projectId: ${projPos.projectId} 🐊 projectPositionId: ${projPos.projectPositionId}');
    }
    if (map.isEmpty) {
      return false;
    }

    var list = map.keys.toList();
    list.sort();

    pp('$mm Distances in list, length: : ${list.length} $list');
    var sett = await prefsOGx.getSettings();
    if (list.elementAt(0) <=
        sett.distanceFromProject!) {
      return true;
    } else {
      return false;
    }
  }

  bool isWithin = false;
  final _nameController = TextEditingController();

  Future<void> _submitNewPosition() async {
    setState(() {
      busy = true;
    });
    try {
      var isWithinRange = await _isLocationWithinProjectMonitorDistance(
          latitude: _longPressLat, longitude: _longPressLng);
      if (isWithinRange) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              padding: const EdgeInsets.all(0.0),
              duration: const Duration(seconds: 10),
              content: Card(
                  elevation: 8,
                  color: Theme.of(context).primaryColor,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        'There is a project monitoring location nearby. This new one is not needed'),
                  ))));
        }
        _animationController.reverse().then((value) {
          setState(() {
            busy = false;
            _showNewPositionUI = false;
          });
        });
        return;
      }

      final sett = await cacheManager.getSettings();
      final projectPositionAdded = await translator.translate('projectPositionAdded', sett.locale!);
      final messageFromGeo = await translator.translate('messageFromGeo', sett.locale!);


      var pos = mrm.ProjectPosition(ObjectId(),
          projectName: widget.project.name,
          userId: user!.userId,
          userName: user!.name,
          caption: 'tbd',
          translatedMessage: projectPositionAdded,
          translatedTitle: messageFromGeo,
          projectPositionId: Uuid.v4().toString(),
          created: DateTime.now().toUtc().toIso8601String(),
          position: mrm.Position(
              coordinates: [_longPressLng, _longPressLat], type: 'Point', longitude: _longPressLng, latitude: _longPressLat),
          nearestCities: [],
          organizationId: widget.project.organizationId,
          projectId: widget.project.projectId);

      realmSyncApi.addProjectPositions([pos]);

      _addMarkers();
      _buildCircles();
      setState(() {});
    } catch (e) {
      pp(e);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(seconds: 10), content: Text('$e')));
      }
    }
    _animationController.reverse().then((value) {
      setState(() {
        busy = false;
        _showNewPositionUI = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key,
        appBar: AppBar(
          title: Text(projectLocationsAreas == null?
            'Project Locations & Areas': projectLocationsAreas!,
            style: myTextStyleLarge(context),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  _refreshData(true);
                },
                icon: Icon(
                  Icons.refresh_rounded,
                  size: 18,
                  color: Theme.of(context).primaryColor,
                ))
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      width: 12,
                    ),
                    Flexible(
                      child: Text(
                        widget.project.name!,
                        style: myTextStyleLargePrimaryColor(context),
                      ),
                    ),
                    const SizedBox(
                      width: 28,
                    ),
                    locations == null? const SizedBox(): ProjectPositionChooser(
                        location: location!,
                        locations: locations!,
                        projectPositions: projectPositions,
                        projectPolygons: projectPolygons,
                        onSelected: _onSelected),
                    const SizedBox(
                      width: 12,
                    ),
                    busy
                        ? const SizedBox(
                            width: 48,
                          )
                        : const SizedBox(),
                    busy
                        ? const SizedBox(
                            width: 12,
                            height: 12,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              backgroundColor: Colors.pink,
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
                const SizedBox(
                  height: 16,
                )
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            GestureDetector(
              onTap: () async {
                var loc = await locationBloc.getLocation();
                if (loc != null) {
                  _animateCamera(
                      latitude: loc.latitude!,
                      longitude: loc.longitude!,
                      zoom: 12.0);
                }
              },
              child: bd.Badge(
                badgeStyle: bd.BadgeStyle(
                  badgeColor: Theme.of(context).primaryColor,
                  elevation: 8,
                  padding: const EdgeInsets.all(8),
                ),
                badgeContent:
                    Text('${projectPositions.length + projectPolygons.length}'),
                position: bd.BadgePosition.topEnd(top: 8, end: 8),
                child: _kGooglePlex == null
                    ? const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 4,
                            backgroundColor: Colors.pink,
                          ),
                        ),
                      )
                    : GoogleMap(
                        mapType: MapType.hybrid,
                        mapToolbarEnabled: true,
                        initialCameraPosition: _kGooglePlex!,
                        onMapCreated: (GoogleMapController controller) async {
                          pp('\n\\$mm 🍎🍎🍎........... GoogleMap onMapCreated ... ready to rumble!\n\n');
                          _mapController.complete(controller);
                          googleMapController = controller;
                          await _refreshData(false);
                          _addMarkers();
                          _buildProjectPolygons();
                          _buildCircles();
                          _animateCamera(
                              latitude: currentLat!,
                              longitude: currentLng!,
                              zoom: 12.6);
                          setState(() {});
                        },
                        // myLocationEnabled: true,
                        markers: Set<Marker>.of(markers.values),
                        compassEnabled: true,
                        buildingsEnabled: true,
                        zoomControlsEnabled: true,
                        onLongPress: _onLongPress,
                        polygons: _polygons,
                        circles: circles,
                      ),
              ),
            ),
            widget.photo != null
                ? Positioned(
                    left: 12,
                    top: 12,
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (BuildContext context, Widget? child) {
                        return FadeScaleTransition(
                          animation: _animationController,
                          child: child,
                        );
                      },
                      child: Card(
                        elevation: 8,
                        color: Colors.black26,
                        child: SizedBox(
                          height: 180,
                          width: 160,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 12,
                              ),
                              Image.network(
                                widget.photo!.thumbnailUrl!,
                                width: 140,
                                height: 140,
                                fit: BoxFit.fill,
                              ),
                              Text(
                                getFormattedDateShortestWithTime(
                                    widget.photo!.created!, context),
                                style: Styles.whiteTiny,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Container(),
            _showNewPositionUI
                ? Positioned(
                    right: 8,
                    top: 16,
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (BuildContext context, Widget? child) {
                        return FadeScaleTransition(
                          animation: _animationController,
                          child: child,
                        );
                      },
                      child: Card(
                        elevation: 8,
                        shape: getRoundedBorder(radius: 16),
                        color: Colors.black38,
                        child: Center(
                            child: SizedBox(
                          height: 240,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Project Location',
                                      style: myTextStyleLarge(context),
                                    ),
                                    const SizedBox(
                                      width: 60,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          _animationController
                                              .reverse()
                                              .then((value) {
                                            setState(() {
                                              _showNewPositionUI = false;
                                            });
                                          });
                                        },
                                        icon: const Icon(Icons.close)),
                                  ],
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 80,
                                        child: Text('Latitude:',
                                            style: myTextStyleSmall(context)),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(_longPressLat.toStringAsFixed(5),
                                          style: myNumberStyleSmall(context)),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 80,
                                        child: Text('Longitude:',
                                            style: myTextStyleSmall(context)),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        _longPressLng.toStringAsFixed(5),
                                        style: myNumberStyleSmall(context),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                // TextFormField(
                                //   controller: _nameController,
                                //   keyboardType: TextInputType.name,
                                //   decoration: const InputDecoration(
                                //     label: Text('Name of Location'),
                                //     hintText:
                                //         'Optional, enter name of location',
                                //   ),
                                // ),
                                // const SizedBox(
                                //   height: 12,
                                // ),
                                address == null
                                    ? const SizedBox()
                                    : Text('$address'),
                                const SizedBox(
                                  height: 12,
                                ),
                                busy
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 4,
                                          backgroundColor: Colors.pink,
                                        ),
                                      )
                                    : ElevatedButton(
                                        onPressed: _submitNewPosition,
                                        child: Text(
                                          'Save Project Location',
                                          style: myTextStyleMedium(context),
                                        )),
                              ],
                            ),
                          ),
                        )),
                      ),
                    ))
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  void _animateCamera(
      {required double latitude,
      required double longitude,
      required double zoom}) {
    final CameraPosition cameraPosition = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: zoom,
    );
    googleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  _onSelected(mrm.Position p1) {
    _animateCamera(
        latitude: p1.coordinates[1], longitude: p1.coordinates[0], zoom: 14.6);
  }
}

class ProjectPositionChooser extends StatelessWidget {
  const ProjectPositionChooser(
      {Key? key,
      required this.projectPositions,
      required this.projectPolygons,
      required this.onSelected, required this.location, required this.locations})
      : super(key: key);
  final List<mrm.ProjectPosition> projectPositions;
  final List<mrm.ProjectPolygon> projectPolygons;
  final Function(mrm.Position) onSelected;
  final String location, locations;
  @override
  Widget build(BuildContext context) {
    var list = <mrm.Position>[];
    // projectPositions.sort((a,b) => a.created!.compareTo(b.created!));
    for (var value in projectPositions) {
      list.add(value.position!);
    }
    for (var value in projectPolygons) {
      list.add(value.positions.first);
      // for (var element in value.positions) {
      //
      // }
    }
    var cnt = 0;
    var menuItems = <DropdownMenuItem>[];
    for (var pos in list) {
      cnt++;
      menuItems.add(
        DropdownMenuItem<mrm.Position>(
          value: pos,
          child: Row(
            children: [
              Text(location,
                style: myTextStyleSmall(context),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                '$cnt',
                style: myNumberStyleSmall(context),
              ),
            ],
          ),
        ),
      );
    }
    return DropdownButton(
        hint: Text(locations,
          style: myTextStyleSmall(context),
        ),
        items: menuItems,
        onChanged: (value) {
          onSelected(value);
        });
  }
}
