import 'package:realm/realm.dart';

part 'schemas.g.dart';

@RealmModel()
class _City {
  late ObjectId? id;
  late String? cityId, countryId, province, country, created;
  late String? name;
  late _Position? cityLocation;
}

@RealmModel(ObjectType.embeddedObject)
class _Position {
  late String? type = 'Point';
  late List<double> coordinates = [];
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

@RealmModel()
class _Audio {
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

@RealmModel()
class _Photo {
  late String photoId;
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

@RealmModel()
class _Video {
  late String videoId;
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

@RealmModel()
class _Organization {
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

@RealmModel()
class _Project {
  late String? projectId;
  late String? name;
  late List<_City> nearestCities = [];
  late String? organizationId;
  late String? organizationName;
  late String? description;
  late String? translatedMessage;
  late String? translatedTitle;
}

@RealmModel()
class _ProjectPosition {
  late String? projectName;
  late String? projectId;
  late String? caption;
  late String? created;
  late String? projectPositionId;
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

@RealmModel()
class _ProjectPolygon {
  late String? projectName;
  late String? projectId;
  late String? caption;
  late String? created;
  late String? projectPolygonId;
  late String? organizationId;
  late String? organizationName;
  late List<_Position> positions = [];
  late List<_City> nearestCities = [];
  late String? name;
  late String? userId;
  late String? userName;
  late String? possibleAddress;
  late String? translatedMessage;
  late String? translatedTitle;
}

@RealmModel()
class _Rating {
  late String? remarks;
  late String? created;
  late String? audioId;
  late String? photoId;
  late String? userId;
  late String? userName;
  late String? organizationId;
  late int? ratingCode;
  late String? projectId;
  late String? projectName;
  late String? videoId;
  late String? ratingId;
  late _Position? position;
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
  late String? projectId;
  late int? projects;
  late int? users;
  late String? created;
  late String? photos;
  late String? userId;
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
  late String? geofenceEventId;
  late String? date;
  late String? projectPositionId;
  late String? projectName;
  late _User? user;
  late String? organizationId;
  late _Position? position;
  late String? projectId;
  late String? locale = "en";
  late String? translatedMessage;
  late String? translatedTitle;
}

@RealmModel()
class _User {
  late String? name;
  late String? userId;
  late String? email;
  late String? gender;
  late String? cellphone;
  late String? created;
  late String? userType;
  late String? organizationName;
  late String? fcmRegistration;
  late String? countryId;
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
  late String? subscriptionId, date;
  late _User? user;
  late String? organizationId;
  late String? organizationName, updated;
  late int? intDate, intUpdated, subscriptionType, active;
}

@RealmModel()
class _Pricing {
  late String? countryId, date;
  late String? countryName;
  late double? monthlyPrice, annualPrice;
}

@RealmModel()
class _OrgMessage {
  late String? name;
  late String? userId;
  late String? message;
  late String? created;
  late String? organizationId;
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
  late String? activityModelId;
  late String? activityType;
  late String? date;
  late String? userId;
  late String? userName;
  late String? projectId;
  late String? projectName;
  late String? organizationName;
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
  late String? name;
  late String? countryId;
  late String? countryCode;
  late int? population = 0;
  late _Position? position;
}

@RealmModel()
class _FieldMonitorSchedule {
  late String? fieldMonitorScheduleId;
  late String? fieldMonitorId;
  late String? adminId;
  late String? organizationId;
  late String? projectId;
  late String? projectName;
  late String? date;
  late String? organizationName;
  late int? perDay;
  late int? perWeek;
  late int? perMonth;
  late String? userId;
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
