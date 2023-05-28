import 'package:json_annotation/json_annotation.dart';
import 'package:realm/realm.dart';

part 'schemas.g.dart';

@RealmModel()
@JsonSerializable(explicitToJson: true)
class _City {
  @PrimaryKey()
  late ObjectId? id;
  late String? cityId;
  late String? countryId, province, country, created, name;
  late _Position? cityLocation;
}

extension CityJ on City {
  static City fromJson(Map<String, dynamic> json) {
    var mCity = City(json['id'],
        name: json['name'],
        cityId: json['cityId'],
        countryId: json['countryId'],
        country: json['country'],
        province: json['province'],
        cityLocation: json['cityLocation'] == null
            ? null
            : PositionJ.fromJson(json['cityLocation']!),
        created: json['created']);
    return mCity;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['cityId'] = cityId;
    map['countryId'] = countryId;
    map['country'] = country;
    map['province'] = province;
    map['name'] = name;
    map['created'] = created;
    if (cityLocation != null) {
      map['cityLocation'] = cityLocation!.toJson();
    }
    return map;
  }
}

@RealmModel(ObjectType.embeddedObject)
class _Position {
  late String? type = 'Point';
  late List<double> coordinates = [];
}

///extension to provide toJson fromJson for Position
extension PositionJ on Position {
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['type'] = type;
    map['coordinates'] = coordinates;
    return map;
  }

  static Position fromJson(Map<String, dynamic> json) {
    var position = Position(
      type: json['type'],
      coordinates: json['coordinates'],
    );
    return position;
  }
}

@RealmModel()
class _Audio {
  @PrimaryKey()
  late ObjectId id;
  late String? audioId;
  late int? durationInSeconds = 0;
  late String? created;
  late String? url;
  late String? projectPositionId;
  late String? userId;
  late String? userName;
  late String? organizationId;
  late _Position? projectPosition;
  late double? distanceFromProjectPosition;
  late String? projectId;
  late String? projectName;
  late String? projectPolygonId;
  late String? userUrl;
  late String? translatedMessage;
  late String? translatedTitle;
  late String? caption;
}

extension AudioJ on Audio {
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'url': url,
      'userUrl': userUrl,
      'projectPositionId': projectPositionId,
      'projectPolygonId': projectPolygonId,
      'caption': caption,
      'created': created,
      'translatedMessage': translatedMessage,
      'translatedTitle': translatedTitle,
      'durationInSeconds': durationInSeconds,
      'userId': userId,
      'audioId': audioId,
      'organizationId': organizationId,
      'userName': userName,
      'distanceFromProjectPosition': distanceFromProjectPosition,
      'projectId': projectId,
      'projectName': projectName,
      'projectPosition':
          projectPosition == null ? null : projectPosition!.toJson()
    };
    return map;
  }

  static Audio fromJson(Map<String, dynamic> data) {
    Position? pos;
    if (data['projectPosition']) {
      pos = Position(
          type: 'Point', coordinates: data['projectPosition']['coordinates']);
    }
    var audio = Audio(data['id'],
        url: data['url'],
        userUrl: data['userUrl'],
        projectPositionId: data['projectPositionId'],
        projectPolygonId: data['projectPolygonId'],
        translatedMessage: data['translatedMessage'],
        translatedTitle: data['translatedTitle'],
        caption: data['caption'],
        durationInSeconds: data['durationInSeconds'],
        created: data['created'],
        userId: data['userId'],
        organizationId: data['organizationId'],
        audioId: data['audioId'],
        userName: data['userName'],
        distanceFromProjectPosition: data['distanceFromProjectPosition'],
        projectId: data['projectId'],
        projectName: data['projectName'],
        projectPosition: pos);

    return audio;
  }
}

@RealmModel()
class _Photo {
  @PrimaryKey()
  late ObjectId id;

  late String? photoId;
  late String? created;
  late String? url;
  late String? thumbnailUrl;
  late int? landscape;
  late String? projectPositionId;
  late String? userId;
  late String? userName;
  late String? organizationId;
  late _Position? projectPosition;
  late double? distanceFromProjectPosition;
  late String? projectId;
  late String? projectName;
  late String? projectPolygonId;
  late String? userUrl;
  late String? translatedMessage;
  late String? translatedTitle;
  late String? caption;
}

extension PhotoJ on Photo {
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'url': url,
      'userUrl': userUrl,
      'thumbnailUrl': thumbnailUrl,
      'projectPositionId': projectPositionId,
      'projectPolygonId': projectPolygonId,
      'caption': caption,
      'created': created,
      'translatedMessage': translatedMessage,
      'translatedTitle': translatedTitle,
      'userId': userId,
      'photoId': photoId,
      'organizationId': organizationId,
      'userName': userName,
      'distanceFromProjectPosition': distanceFromProjectPosition,
      'projectId': projectId,
      'projectName': projectName,
      'projectPosition':
      projectPosition == null ? null : projectPosition!.toJson()
    };
    return map;
  }

  static Photo fromJson(Map<String, dynamic> data) {
    Position? pos;
    if (data['projectPosition']) {
      pos = Position(
          type: 'Point', coordinates: data['projectPosition']['coordinates']);
    }
    var photo = Photo(data['id'],
        url: data['url'],
        userUrl: data['userUrl'],
        projectPositionId: data['projectPositionId'],
        projectPolygonId: data['projectPolygonId'],
        translatedMessage: data['translatedMessage'],
        translatedTitle: data['translatedTitle'],
        caption: data['caption'],
        created: data['created'],
        userId: data['userId'],
        organizationId: data['organizationId'],
        photoId: data['photoId'],
        userName: data['userName'],
        distanceFromProjectPosition: data['distanceFromProjectPosition'],
        projectId: data['projectId'],
        projectName: data['projectName'],
        projectPosition: pos);

    return photo;
  }
}


@RealmModel()
class _Video {
  @PrimaryKey()
  late ObjectId objectId;
  late String? videoId;
  late String? created;
  late String? url;
  late String? thumbnailUrl;
  late int? landscape;
  late String? projectPositionId;
  late String? userId;
  late String? userName;
  late String? organizationId;
  late _Position? projectPosition;
  late double? distanceFromProjectPosition;
  late String? projectId;
  late String? projectName;
  late String? projectPolygonId;
  late String? userUrl;
  late String? translatedMessage;
  late String? translatedTitle;
  late String? caption;
  late int? durationInSeconds = 0;
}
extension VideoJ on Video {
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'url': url,
      'userUrl': userUrl,
      'projectPositionId': projectPositionId,
      'projectPolygonId': projectPolygonId,
      'caption': caption,
      'created': created,
      'translatedMessage': translatedMessage,
      'translatedTitle': translatedTitle,
      'durationInSeconds': durationInSeconds,
      'userId': userId,
      'videoId': videoId,
      'organizationId': organizationId,
      'userName': userName,
      'distanceFromProjectPosition': distanceFromProjectPosition,
      'projectId': projectId,
      'projectName': projectName,
      'projectPosition':
      projectPosition == null ? null : projectPosition!.toJson()
    };
    return map;
  }

  static Video fromJson(Map<String, dynamic> data) {
    Position? pos;
    if (data['projectPosition']) {
      pos = Position(
          type: 'Point', coordinates: data['projectPosition']['coordinates']);
    }
    var video = Video(data['id'],
        url: data['url'],
        userUrl: data['userUrl'],
        projectPositionId: data['projectPositionId'],
        projectPolygonId: data['projectPolygonId'],
        translatedMessage: data['translatedMessage'],
        translatedTitle: data['translatedTitle'],
        caption: data['caption'],
        durationInSeconds: data['durationInSeconds'],
        created: data['created'],
        userId: data['userId'],
        organizationId: data['organizationId'],
        videoId: data['videoId'],
        userName: data['userName'],
        distanceFromProjectPosition: data['distanceFromProjectPosition'],
        projectId: data['projectId'],
        projectName: data['projectName'],
        projectPosition: pos);

    return video;
  }
}


@RealmModel()
class _Organization {
  @PrimaryKey()
  late String? organizationId;
  late String? name;
  late String? admin;
  late String? countryId;
  late String? countryName;
  late String? created;
  late String? email;
  late String? translatedMessage;
  late String? translatedTitle;
}
extension OrganizationJ on Organization {
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name': name,
      'admin': admin,
      'countryId': countryId,
      'countryName': countryName,
      'email': email,
      'created': created,
      'translatedMessage': translatedMessage,
      'translatedTitle': translatedTitle,
      'organizationId': organizationId,
    };
    return map;
  }

  static Organization fromJson(Map<String, dynamic> data) {

    var org = Organization(data['id'],
        name: data['name'],
        admin: data['admin'],
        countryId: data['countryId'],
        countryName: data['countryName'],
        translatedMessage: data['translatedMessage'],
        translatedTitle: data['translatedTitle'],
        email: data['email'],
        created: data['created']);

    return org;
  }
}

@RealmModel()
class _Project {
  @PrimaryKey()
  late ObjectId? id;

  late String? projectId;
  late String? name;
  late String? created;
  late List<_City> nearestCities = [];
  @Indexed()
  late String? organizationId;
  late String? organizationName;
  late String? description;
  late String? translatedMessage;
  late String? translatedTitle;
}

extension ProjectJ on Project {
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'name': name,
      'projectId': projectId,
      'organizationName': organizationName,
      'description': description,
      'id': id,
      'created': created,
      'translatedMessage': translatedMessage,
      'translatedTitle': translatedTitle,
      'organizationId': organizationId,
    };
    return map;
  }

  static Project fromJson(Map<String, dynamic> data) {

    var org = Project(data['id'],
        name: data['name'],
        projectId: data['projectId'],
        organizationId: data['organizationId'],
        description: data['description'],
        translatedMessage: data['translatedMessage'],
        translatedTitle: data['translatedTitle'],
        created: data['created']);

    return org;
  }
}


@RealmModel()
class _ProjectPosition {
  late String? projectName;
  @Indexed()
  late String? projectId;
  late String? caption;
  late String? created;
  @PrimaryKey()
  late String? id;
  late String? projectPositionId;
  @Indexed()
  late String? organizationId;
  late _Position? position;
  late _PlaceMark? placemark;
  late List<_City> nearestCities = [];
  late String? name;
  late String? userId;
  late String? userName;
  late String? possibleAddress;
  late String? translatedMessage;
  late String? translatedTitle;
}
extension ProjectPositionJ on ProjectPosition {
  Map<String, dynamic> toJson() {
    var citiesJsonList = [];
    for (var value in nearestCities) {
      var json = value.toJson();
      citiesJsonList.add(json);
    }
    Map<String, dynamic> map = {
      'caption': caption,
      'projectId': projectId,
      'projectPositionId': projectPositionId,
      'name': name,
      'id': id,
      'userId': userId,
      'possibleAddress': possibleAddress,
      'created': created,
      'translatedMessage': translatedMessage,
      'translatedTitle': translatedTitle,
      'organizationId': organizationId,
      'nearestCities': citiesJsonList,
      'position': {
        'type': position?.type,
        'coordinates': position?.coordinates.toList()
      }
    };
    return map;
  }

  static ProjectPosition fromJson(Map<String, dynamic> data) {

    var nearestCities = <City>[];
    List cities = data['nearestCities'];
    for (var value in cities) {
      Position? pos = Position(type: value['cityLocation']['type'],
        coordinates: value['cityLocation']['coordinates'], );

      var city = City(value['id'],
        province: value['province'],
        cityId: value['cityId'],
        countryId: value['countryId'],
        created: value('created'),
        country: value['country'],
        name: value['name'],
        cityLocation: pos,
      );

      nearestCities.add(city);
    }

    PlaceMark? placeMark;
    if (data['placeMark'] != null) {
      placeMark = PlaceMark(
        name: data['placeMark']['name'],
        country: data['placeMark']['country'],
        administrativeArea: data['placeMark']['administrativeArea'],
        isoCountryCode: data['placeMark']['isoCountryCode'],
        locality: data['placeMark']['locality'],
        postalCode: data['placeMark']['postalCode'],
        street: data['placeMark']['street'],
        subAdministrativeArea: data['placeMark']['subAdministrativeArea'],
        subLocality: data['placeMark']['subLocality'],
        subThoroughfare: data['placeMark']['subThoroughfare'],
        thoroughfare: data['placeMark']['thoroughfare'],
      );
    }
    var projectPosition = ProjectPosition(data['id'],
        name: data['name'],
        projectId: data['projectId'],
        organizationId: data['organizationId'],
        caption: data['caption'],
        projectName: data['projectName'],
        userId: data['userId'],
        possibleAddress: data['possibleAddress'],
        projectPositionId: data['projectPositionId'],
        translatedMessage: data['translatedMessage'],
        translatedTitle: data['translatedTitle'],
        placemark: placeMark,
        nearestCities: nearestCities,
        position: Position(type: data['position']['type'],
          coordinates: data['position']['coordinates'], ),
        created: data['created']);

    return projectPosition;
  }
}


@RealmModel()
class _PlaceMark {
  late String? administrativeArea;
  late String? subAdministrativeArea;
  late String? locality;
  late String? subLocality;
  late String? thoroughfare;
  late String? subThoroughfare;
  late String? name;
  late String? street;
  late String? country;
  late String? isoCountryCode;
  late String? postalCode;
}
extension PlaceMarkJ on PlaceMark {
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'administrativeArea': administrativeArea,
      'subAdministrativeArea': subAdministrativeArea,
      'locality': locality,
      'subLocality': subLocality,
      'thoroughfare': thoroughfare,
      'subThoroughfare': subThoroughfare,
      'name': name,
      'street': street,
      'country': country,
      'isoCountryCode': isoCountryCode,
      'postalCode': postalCode,
    };
    return map;
  }
  static PlaceMark fromJson(Map<String, dynamic> data) {
    var mark = PlaceMark(
        administrativeArea: data['administrativeArea'],
        subAdministrativeArea: data['subAdministrativeArea'],
        locality: data['locality'],
        subLocality: data['subLocality'],
        subThoroughfare: data['subThoroughfare'],
        thoroughfare: data['thoroughfare'],
        name: data['name'],
        street: data['street'],
        country: data['country'],
        isoCountryCode: data['isoCountryCode'],
        postalCode: data['postalCode'],
    );


    return mark;
  }
}


@RealmModel()
class _ProjectPolygon {
  late String? projectName;
  late String? projectId;
  late String? created;
  @PrimaryKey()
  late String? id;
  late String? projectPolygonId;
  @Indexed()
  late String? organizationId;
  late String? organizationName;
  late List<_Position> positions = [];
  late List<_City> nearestCities = [];
  late String? userId;
  late String? userName;
  late String? translatedMessage;
  late String? translatedTitle;
}

extension ProjectPolygonJ on ProjectPolygon {
  Map<String, dynamic> toJson() {
    var citiesJsonList = [];
    for (var value in nearestCities) {
      var json = value.toJson();
      citiesJsonList.add(json);
    }
    var posJsonList = [];
    for (var value in positions) {
      var json = value.toJson();
      posJsonList.add(json);
    }
    Map<String, dynamic> map = {
      'projectId': projectId,
      'projectPolygonId': projectPolygonId,
      'projectName': projectName,
      'id': id,
      'userId': userId,
      'organizationId': organizationId,
      'created': created,
      'translatedMessage': translatedMessage,
      'translatedTitle': translatedTitle,
      'userName': userName,
      'nearestCities': citiesJsonList,
      'positions': posJsonList,
    };
    return map;
  }

  static ProjectPolygon fromJson(Map<String, dynamic> data) {

    var nearestCities = <City>[];
    List cities = data['nearestCities'];
    for (var value in cities) {
      Position? pos = Position(type: value['cityLocation']['type'],
        coordinates: value['cityLocation']['coordinates'], );

      var city = City(value['id'],
        province: value['province'],
        cityId: value['cityId'],
        countryId: value['countryId'],
        created: value('created'),
        country: value['country'],
        name: value['name'],
        cityLocation: pos,
      );

      nearestCities.add(city);
    }
    var positions = <Position>[];
    List mJsonList = data['positions'];
    for (var value in mJsonList) {
      Position? pos = Position(type: value['type'],
        coordinates: value['coordinates'], );

      positions.add(pos);
    }

    var projectPosition = ProjectPolygon(data['id'],
        userName: data['userName'],
        projectId: data['projectId'],
        organizationId: data['organizationId'],
        projectName: data['projectName'],
        userId: data['userId'],
        projectPolygonId: data['projectPolygonId'],
        translatedMessage: data['translatedMessage'],
        translatedTitle: data['translatedTitle'],
        nearestCities: nearestCities,
        positions: positions);

    return projectPosition;
  }
}

@RealmModel()
class _Rating {
  late String? remarks;
  late String? created;
  late String? audioId;
  late String? photoId;
  late String? userId;
  late String? userName;
  @Indexed()
  late String? organizationId;
  late int? ratingCode;
  @Indexed()
  late String? projectId;
  late String? projectName;
  late String? videoId;
  late String? ratingId;
  late _Position? position;
}
extension RatingJ on Rating {

}

@RealmModel()
class _SettingsModel {
  late int? distanceFromProject;
  late int? photoSize;
  late int? maxVideoLengthInSeconds;
  late int? maxAudioLengthInMinutes;
  late int? themeIndex;
  late String? settingsId;
  late String? created;
  late String? organizationId;
  late String? organizationName;
  late String? projectId;
  late int? activityStreamHours;
  late int? numberOfDays;
  late String? locale = "en";
  late String? translatedMessage;
  late String? translatedTitle;
}

@RealmModel()
class _DataCounts {
  @Indexed()
  late String? projectId;
  late int? projects;
  late int? users;
  late String? created;
  late String? photos;
  late String? userId;
  @Indexed()
  late String? organizationId;
  late int? videos;
  late int? audios;
  late int? projectPositions;
  late int? projectPolygons;
  late int? fieldMonitorSchedules;
  late int? activities;
}

@RealmModel()
class _GeofenceEvent {
  late String? status;
  @PrimaryKey()
  late String? geofenceEventId;
  late String? date;
  late String? projectPositionId;
  late String? projectName;
  late _User? user;
  @Indexed()
  late String? organizationId;
  late _Position? position;
  @Indexed()
  late String? projectId;
  late String? locale = "en";
  late String? translatedMessage;
  late String? translatedTitle;
}

@RealmModel()
class _User {
  late String? name;
  @PrimaryKey()
  late String? userId;
  late String? email;
  late String? gender;
  late String? cellphone;
  late String? created;
  late String? userType;
  late String? organizationName;
  late String? fcmRegistration;
  late String? countryId;
  @Indexed()
  late String? organizationId;
  late _Position? position;
  late String? password;
  late String? updated;
  late int? active = 0;
  late String? imageUrl;
  late String? thumbnailUrl;
  late String? locale = "en";
  late String? translatedMessage;
  late String? translatedTitle;
}

@RealmModel()
class _GioSubscription {
  @PrimaryKey()
  late String? subscriptionId;
  late String? date;
  late _User? user;
  @Indexed()
  late String? organizationId;
  late String? organizationName, updated;
  late int? intDate, intUpdated, subscriptionType, active;
}

@RealmModel()
class _Pricing {
  late String? countryId;
  late String date;
  late String? countryName;
  late double? monthlyPrice, annualPrice;
}

@RealmModel()
class _OrgMessage {
  late String? name;
  late String? userId;
  late String? message;
  late String? created;
  @Indexed()
  late String? organizationId;
  @Indexed()
  late String? projectId;
  late String? projectName;
  late String? adminId;
  late String? adminName;
  late String? frequency;
  late String? result;
  late String? orgMessageId;
}

@RealmModel()
class _LocationRequest {
  @Indexed()
  late String? organizationId;
  late String? requesterId;
  late String? created;
  late String? requesterName;
  late String? userId;
  late String? userName;
  late String? organizationName;
  late String? translatedMessage;
  late String? translatedTitle;
}

@RealmModel()
class _LocationResponse {
  late String? date;
  late String? userId;
  @Indexed()
  late String? organizationId;
  late String? userName;
  late String? locationResponseId;
  late String? organizationName;
  late _Position? position;
  late String? requesterId;
  late String? requesterName;
  late String? translatedMessage;
  late String? translatedTitle;
}

@RealmModel()
class _ActivityModel {
  @PrimaryKey()
  late String? activityModelId;
  late String? activityType;
  late String? date;
  late String? userId;
  late String? userName;
  @Indexed()
  late String? projectId;
  late String? projectName;
  late String? organizationName;
  @Indexed()
  late String? organizationId;
  late _Photo? photo;
  late _Video? video;
  late _Audio? audio;
  late _User? user;
  late _Project? project;
  late _ProjectPosition? projectPosition;
  late _ProjectPolygon? projectPolygon;
  late _OrgMessage? orgMessage;
  late _GeofenceEvent? geofenceEvent;
  late _LocationRequest? locationRequest;
  late _LocationResponse? locationResponse;
  late String? userThumbnailUrl;
  late String? userType;
  late String? translatedUserType;
  late _SettingsModel? settingsModel;
  late int intDate = 0;
}

@RealmModel()
class _Country {
  @Indexed()
  late String? name;
  late String? countryId;
  late String? countryCode;
  late int? population = 0;
  late _Position? position;
}

@RealmModel()
class _FieldMonitorSchedule {
  @PrimaryKey()
  late String? fieldMonitorScheduleId;
  late String? fieldMonitorId;
  late String? adminId;
  @Indexed()
  late String? organizationId;
  @Indexed()
  late String? projectId;
  late String? projectName;
  late String? date;
  late String? organizationName;
  late int? perDay;
  late int? perWeek;
  late int? perMonth;
  late String? userId;
}

@RealmModel()
class _AppError {
  late ObjectId? id;
  late String? errorMessage;
  late String? manufacturer;
  late String? model;
  late String? created;
  late String? brand;
  late String? userId;
  late String? organizationId;
  late String? userName;
  late _Position? errorPosition;
  late String? iosName;
  late String? versionCodeName;
  late String? baseOS;
  late String? deviceType;
  late String? iosSystemName;
  late String? userUrl;
  late String? uploadedDate;
}

extension AppErrorJ on AppError {
  static AppError fromJson(Map<String, dynamic> data) {
    Position? pos;
    if (data['errorPosition'] != null) {
      pos = Position(
        type: data['errorPosition']['type'],
        coordinates: data['errorPosition']['coordinates'],
      );
    }

    var err = AppError(
      userUrl: data['userUrl'],
      errorMessage: data['errorMessage'],
      manufacturer: data['manufacturer'],
      model: data['model'],
      baseOS: data['baseOS'],
      deviceType: data['deviceType'],
      created: data['created'],
      organizationId: data['organizationId'],
      iosSystemName: data['iosSystemName'],
      uploadedDate: data['uploadedDate'],
      userId: data['userId'],
      brand: data['brand'],
      userName: data['userName'],
      iosName: data['iosName'],
      versionCodeName: data['versionCodeName'],
      errorPosition: pos,
    );
    return err;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'errorMessage': errorMessage,
      'userUrl': userUrl,
      'iosSystemName': iosSystemName,
      'model': model,
      'created': created,
      'deviceType': deviceType,
      'baseOS': baseOS,
      'userId': userId,
      'organizationId': organizationId,
      'brand': brand,
      'uploadedDate': uploadedDate,
      'userName': userName,
      'iosName': iosName,
      'versionCodeName': versionCodeName,
      'manufacturer': manufacturer,
      'errorPosition': errorPosition == null ? null : errorPosition!.toJson()
    };
    return map;
  }
}

enum ActivityType {
  projectAdded,
  photoAdded,
  videoAdded,
  audioAdded,
  messageAdded,
  userAddedOrModified,
  positionAdded,
  polygonAdded,
  settingsChanged,
  geofenceEventAdded,
  conditionAdded,
  locationRequest,
  locationResponse,
  kill,
}

ActivityType getActivityType(String type) {
  switch (type) {
    case "locationRequest":
      return ActivityType.locationRequest;
      break;
    case "locationResponse":
      return ActivityType.locationResponse;
      break;
    case "geofenceEventAdded":
      return ActivityType.geofenceEventAdded;
      break;
    case "userAddedOrModified":
      return ActivityType.userAddedOrModified;
      break;
    case "polygonAdded":
      return ActivityType.polygonAdded;
      break;
    case "positionAdded":
      return ActivityType.positionAdded;
      break;
    case "audioAdded":
      return ActivityType.audioAdded;
      break;
    case "videoAdded":
      return ActivityType.videoAdded;
      break;
    case "photoAdded":
      return ActivityType.photoAdded;
      break;
    case "projectAdded":
      return ActivityType.projectAdded;
      break;
    case "kill":
      return ActivityType.kill;
      break;
    case "conditionAdded":
      return ActivityType.conditionAdded;
      break;
    case "messageAdded":
      return ActivityType.messageAdded;
      break;
    case "settingsChanged":
      return ActivityType.settingsChanged;
      break;
  }
  throw Exception('Invalid activity type enum');
}

extension ParseToString on ActivityType {
  String toShortString() {
    return toString().split('.').last;
  }
}
