import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geo_monitor/library/bloc/isolate_handler.dart';
import 'package:geo_monitor/library/functions.dart';
import 'package:geo_monitor/library/generic_functions.dart';
import 'package:geo_monitor/realm_data/data/realm_sync_api.dart';
import 'package:realm/realm.dart' as rm;

import '../../initializer.dart';
import '../../library/api/data_api_og.dart';
import '../../library/data/organization.dart' as old;
import '../../library/data/country.dart' as old;
import '../../library/data/city.dart' as old;

import '../../library/emojis.dart';
import 'schemas.dart' as mrm;

class RealmSkunk extends StatefulWidget {
  const RealmSkunk({Key? key}) : super(key: key);

  @override
  RealmSkunkState createState() => RealmSkunkState();
}

class RealmSkunkState extends State<RealmSkunk> {
  final mm = '🎲🎲🎲🎲 RealmSkunk';
  bool busy = false;
  var organizations = <old.Organization>[];

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    setState(() {
      busy = true;
    });
    await initializer.initializeGioServices();
    _getOrgs();

    setState(() {
      busy = false;
    });
  }

  Future migrateCountriesAndCities() async {
    setState(() {
      busy = true;
    });
    try {
      pp('$mm migrateCountriesAndCities starting ............ 🍎🍎🍎🍎🍎🍎🍎');
      // var res = await dataHandler.migrateCountries();
      //var res3 = await dataHandler.migrateOrganizations();
      // organizations = await dataApiDog.getOrganizations();
      for (var org in organizations) {
        await dataHandler.migrateOneOrganization(
            organizationId: org.organizationId!, name: org.name!);
      }
    } catch (e) {
      pp('$mm ERROR: 🍎🍎🍎🍎🍎🍎🍎 $e');
      showSnackBar(
          padding: 16,
          backgroundColor: Theme.of(context).primaryColor,
          textStyle: myTextStyleMediumWithColor(context, Colors.white),
          duration: const Duration(seconds: 10),
          message: 'Realm pissed off again!!\n$e',
          context: context);
    }
    setState(() {
      busy = false;
    });
  }
  Future migrateOrg(old.Organization organization) async {
    setState(() {
      busy = true;
    });
    try {
      pp('$mm migrateCountriesAndCitiesForOrg starting ............ 🍎🍎🍎🍎🍎🍎🍎');
      await dataHandler.migrateOneOrganization(
          organizationId: organization.organizationId!, name: organization.name!);
    } catch (e) {
      pp('$mm ERROR: 🍎🍎🍎🍎🍎🍎🍎 $e');
      showSnackBar(
          padding: 16,
          backgroundColor: Theme.of(context).primaryColor,
          textStyle: myTextStyleMediumWithColor(context, Colors.white),
          duration: const Duration(seconds: 10),
          message: 'Realm pissed off again!!\n$e',
          context: context);
    }
    setState(() {
      busy = false;
    });
  }

  Future _getOrgs() async {
    setState(() {
      busy = true;
    });
    organizations = await dataApiDog.getOrganizations();
    organizations.sort((a,b) => a.name!.compareTo(b.name!));

    setState(() {
      busy = false;
    });
  }

  bool deleted = false;

  void _showDialog(old.Organization organization) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(
          "Migration Confirmation",
          style: myTextStyleLarge(ctx),
        ),
        content: SizedBox(
          height: 120,
          child: Column(
            children: [
              Text(
                'Do you want to migrate all cities?}',
                style: myTextStyleMedium(ctx),
              ),
              const SizedBox(
                height: 24,
              ),
              Text('${organization.name}', style: myTextStyleMediumBoldWithColor(
                  context, Colors.blue),)
            ],
          ),
        ),
        shape: getRoundedBorder(radius: 16),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              pp('$mm Navigator popping for the last time, Sucker! 🔵🔵🔵');
              Navigator.of(ctx).pop();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              migrateOrg(organization);
              Navigator.of(ctx).pop();
            },
            child: const Text("Migrate Organization"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          'Skunkworks Place',
          style: myTextStyleMediumBoldPrimaryColor(context),
        ),
        actions: [
          IconButton(
              onPressed: () {
                migrateCountriesAndCities();
              },
              icon: const Icon(
                Icons.upload,
                color: Colors.deepOrange,
              )),
          IconButton(
              onPressed: () {
                _init();
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.teal,
              ))
        ],
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      const Text('Number of Organizations: '),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        '${organizations.length}',
                        style:
                            myTextStyleMediumWithColor(context, Colors.yellow),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            )),
      ),
      backgroundColor: Colors.brown[50],
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: getRoundedBorder(radius: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                      itemCount: organizations.length,
                      itemBuilder: (_, index) {
                        var org = organizations.elementAt(index);
                        return GestureDetector(
                          onTap: () {
                            pp('$mm ${org.name} - ${org.organizationId}');
                            _showDialog(org);
                          },
                          child: Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${org.name}',
                                style: myTextStyleMedium(context),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
          ),
          busy
              ? Positioned(
                  top: 100,
                  bottom: 100,
                  left: 100,
                  right: 100,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Card(
                        elevation: 4,
                        shape: getRoundedBorder(radius: 16),
                        child: const SizedBox(
                          height: 28,
                          width: 28,
                          child: CircularProgressIndicator(
                            strokeWidth: 6,
                            backgroundColor: Colors.pink,
                          ),
                        ),
                      ),
                    ),
                  ))
              : const SizedBox()
        ],
      ),
    ));
  }
}

///
class CitySkunk extends StatefulWidget {
  const CitySkunk({Key? key}) : super(key: key);

  @override
  State<CitySkunk> createState() => CitySkunkState();
}

class CitySkunkState extends State<CitySkunk> {
  final mm = '🥬 🥬 🥬 🥬 CitySkunk: ';
  late rm.Realm realmRemote;

  static const
      email = 'aubrey@aftarobot.com',
      password = 'kkTiger3#',
      id = '6478402d6358d2b0e1ba6abe';
  var countries = <old.Country>[];

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    setState(() {
      busy = true;
    });
    await initializer.initializeGioServices();
    await initializeForCities();
    countries = await dataApiDog.getCountries();
    setState(() {
      busy = false;
    });
  }

  Future<bool> initializeForCities() async {
    pp('\n\n$mm ........ initialize Realm with Device Sync ....');
    app = rm.App(rm.AppConfiguration(realmAppId));
    realmUser = app.currentUser ?? await app.logIn(rm.Credentials.anonymous());
    final config = rm.Configuration.flexibleSync(realmUser, schemas,
        syncErrorHandler: (rm.SyncError err) {
      pp('\n\n\n$mm ${E.redDot}${E.redDot}${E.redDot}${E.redDot} '
          'Some kind of Realm SyncError; \n🍎codeValue: ${err.codeValue} '
          '\n🍎message: ${err.message}  \n🍎category: ${err.category.name} \n');
      //todo - handle this error condition!!!!
      switch (err.codeValue) {
        case 226:
          break;
      }
    });

    try {
      rm.Realm.logger.level = rm.RealmLogLevel.debug;
      //todo - use real creds when in prod
      //todo - save realm user in prefs and avoid unnecessary login
      if (await checkDeviceOnline()) {
        // If the device is online, download changes and then open the realm.
        realmRemote = await rm.Realm.open(config, onProgressCallback: (cb) {
          pp('$mm transferableBytes: ${cb.transferableBytes} transferredBytes: ${cb.transferredBytes}');
        });
      } else {
        // If the device is offline, open the realm immediately
        // and automatically sync changes in the background when the device is online.
        realmRemote = rm.Realm(config);
      }
      //realmRemote = rm.Realm(config);

      pp('\n\n$mm RealmApp configured  🥬 🥬 🥬 🥬; realmUser : '
          '\n🌎🌎state: ${realmUser.state.name} '
          '\n🌎🌎accessToken: ${realmUser.accessToken} '
          '\n🌎🌎id:${realmUser.id} \n🌎🌎name:${realmUser.profile.name}');

      for (var schema in realmRemote.schema) {
        pp('$mm RealmApp configured; schema : 🍎🍎${schema.name}');
      }
      pp('\n$mm RealmApp configured OK  🥬 🥬 🥬 🥬: 🔵 ${realmRemote.schema.length} Realm schemas \n\n');

      return true;
    } catch (e) {
      pp('$mm ${E.redDot}${E.redDot}${E.redDot}${E.redDot} Problem initializing Realm: $e');
    }
    return false;
  }

  Future setSubscriptionsForCities({required String? countryId}) async {
    try {
      final countryCitiesQuery =
          realmRemote.query<mrm.City>("countryId == \$0", [countryId]);
      //
      realmRemote.subscriptions
          .update((rm.MutableSubscriptionSet mutableSubscriptions) {
        mutableSubscriptions.add(countryCitiesQuery,
            name: 'country_cities', update: true);
      });

      // Sync all subscriptions
      await realmRemote.subscriptions.waitForSynchronization();
      for (var sub in realmRemote.subscriptions) {
        pp('$mm 😡 😡 😡 Realm Subscription: ${sub.name} - ${sub.objectClassName}');
      }
      pp('\n$mm RealmApp waitForSynchronization completed OK  🥬 🥬 🥬 🥬: 🔵\n');
    } catch (e) {
      pp('$mm ${E.redDot}${E.redDot}${E.redDot}${E.redDot} Problem setting up subscriptions to Realm: $e');
    }
  }

  Future migrateCities() async {
    var countries = await dataApiDog.getCountries();

    pp('\n\n$mm migrating ${countries.length} countries\'s cities .....');
    for (var country in countries) {
      await setSubscriptionsForCities(countryId: country.countryId);
      var cities = await dataApiDog.getCitiesByCountry(country.countryId!);
      var countryCities = <mrm.City>[];
      for (var c in cities) {
        final k = _getCity(c);
        countryCities.add(k);
      }
      realmRemote.write(() {
        realmRemote.addAll(countryCities);
      });
      pp('$mm added ${countryCities.length} cities for country: ${country.name} \n');
    }
  }

  Future<bool> checkDeviceOnline() async {
    return true;
  }

  mrm.City _getCity(old.City x) {
    final k = mrm.City(
      rm.ObjectId(),
      countryName: x.countryName,
      countryId: x.countryId,
      name: x.name,
      cityId: x.cityId,
      stateId: x.stateId,
      stateName: x.stateName,
      position: mrm.Position(
        type: x.position!.type,
        coordinates: x.position!.coordinates,
        longitude: x.position!.coordinates.first,
        latitude: x.position!.coordinates.last,
      ),
    );
    return k;
  }

  void _showDialog(old.Country country) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(
          "Migration Confirmation",
          style: myTextStyleLarge(ctx),
        ),
        content: SizedBox(
          height: 120,
          child: Column(
            children: [
              Text(
                'Do you want to migrate all cities?}',
                style: myTextStyleMedium(ctx),
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
        shape: getRoundedBorder(radius: 16),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              pp('$mm Navigator popping for the last time, Sucker! 🔵🔵🔵');
              Navigator.of(ctx).pop();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              migrateCities();
              Navigator.of(ctx).pop();
            },
            child: const Text("Migrate Country Cities"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          'Skunkworks Place',
          style: myTextStyleMediumBoldPrimaryColor(context),
        ),
        actions: [
          IconButton(
              onPressed: () {
                migrateCities();
              },
              icon: const Icon(
                Icons.upload,
                color: Colors.teal,
              )),
        ],
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      const Text('Number of Countries: '),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        '${countries.length}',
                        style:
                            myTextStyleMediumWithColor(context, Colors.yellow),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            )),
      ),
      backgroundColor: Colors.brown[50],
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                shape: getRoundedBorder(radius: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                      itemCount: countries.length,
                      itemBuilder: (_, index) {
                        var country = countries.elementAt(index);
                        return GestureDetector(
                          onTap: () {
                            pp('$mm ${country.name} ');
                            _showDialog(country);
                          },
                          child: Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${country.name}',
                                style: myTextStyleMedium(context),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
          ),
          busy
              ? Positioned(
                  top: 100,
                  bottom: 100,
                  left: 100,
                  right: 100,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Card(
                        elevation: 4,
                        shape: getRoundedBorder(radius: 16),
                        child: const SizedBox(
                          height: 28,
                          width: 28,
                          child: CircularProgressIndicator(
                            strokeWidth: 6,
                            backgroundColor: Colors.pink,
                          ),
                        ),
                      ),
                    ),
                  ))
              : const SizedBox()
        ],
      ),
    ));
  }
}
