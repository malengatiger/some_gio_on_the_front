
import 'package:realm/realm.dart';

part 'schemas.g.dart';

@RealmModel()
//@MapTo('cities')
class _City {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  late String? cityId;
  late String? countryId;
  late String? name;
  late _Position? position;
  late String? stateId;
  late String? stateName;
  late String? countryName;
}


@RealmModel()
//@MapTo('states')
class _State {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  late String? countryId,  name;
  late _Position? position;
  late String? stateId;
  late String? countryName;
}

//
@RealmModel(ObjectType.embeddedObject)
class _Position {
  late String? type = 'Point';
  late double? latitude;
  late double? longitude;
  late List<double> coordinates = [];
}

@RealmModel()
//@MapTo('audios')
class _Audio {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  late String? audioId;
  late int? durationInSeconds = 0;
  late String? created;
  late String? url;
  late String? projectPositionId;
  @Indexed()
  late String? userId;
  late String? userName;
  @Indexed()
  late String? organizationId;
  late _Position? projectPosition;
  late double? distanceFromProjectPosition;
  @Indexed()
  late String? projectId;
  late String? projectName;
  late String? projectPolygonId;
  late String? userUrl;
  late String? translatedMessage;
  late String? translatedTitle;
  late String? caption;
}

@RealmModel()
//@MapTo('photos')
class _Photo {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  late String? photoId;
  late String? created;
  late String? url;
  late String? thumbnailUrl;
  late int? landscape;
  late String? projectPositionId;
  @Indexed()
  late String? userId;
  late String? userName;
  @Indexed()
  late String? organizationId;
  late _Position? projectPosition;
  late double? distanceFromProjectPosition;
  @Indexed()
  late String? projectId;
  late String? projectName;
  late String? projectPolygonId;
  late String? userUrl;
  late String? translatedMessage;
  late String? translatedTitle;
  late String? caption;
}

@RealmModel()
//@MapTo('videos')
class _Video {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

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


@RealmModel()
//@MapTo('organizations')
class _Organization {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

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
//@MapTo('paymentRequests')
class _GioPaymentRequest {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  late int? quantity;
  late String? currency;
  late String? organizationId;
  late String? payerReference;
  late String? externalReference;
  late String? beneficiaryName;
  late String? beneficiaryBankId;
  late String? beneficiaryAccountNumber;
  late String? merchant;
  late String? paymentRequestId;
  late String? subscriptionId;
  late String? beneficiaryReference;
  late String? date;
}


@RealmModel()
//@MapTo('projects')
class _Project {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

  late String? projectId;
  late String? name;
  late String? created;
  late List<String> nearestCities = [];
  @Indexed()
  late String? organizationId;
  late String? organizationName;
  late String? description;
  late String? translatedMessage;
  late String? translatedTitle;
  late int? monitorMaxDistanceInMetres;
}


@RealmModel()
//@MapTo('projectPositions')
class _ProjectPosition {
  late String? projectName;
  @Indexed()
  late String? projectId;
  late String? caption;
  late String? created;
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  late String? projectPositionId;
  @Indexed()
  late String? organizationId;
  late String? organizationName;
  late _Position? position;
  late List<String> nearestCities = [];
  late String? name;
  late String? userId;
  late String? userName;
  late String? userUrl;
  late String? possibleAddress;
  late String? translatedMessage;
  late String? translatedTitle;
}


@RealmModel()
//@MapTo('projectPolygons')
class _ProjectPolygon {
  late String? projectName;
  late String? projectId;
  late String? created;
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  late String? projectPolygonId;
  @Indexed()
  late String? organizationId;
  late String? organizationName;
  late List<_Position> positions = [];
  late List<String> nearestCities = [];
  late String? userId;
  late String? userName;
  late String? userUrl;

  late String? translatedMessage;
  late String? translatedTitle;
}

@RealmModel()
//@MapTo('ratings')
class _Rating {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

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

@RealmModel()
//@MapTo('settings')
class _SettingsModel {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
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
  late int? refreshRateInMinutes;
}


@RealmModel()
//@MapTo('dataCounts')
class _DataCounts {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
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
//@MapTo('geofenceEvents')
class _GeofenceEvent {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  late String? status;
  late String? geofenceEventId;
  late String? date;
  late String? projectPositionId;
  late String? projectName;

  late String? userId;
  late String? userName;
  late String? userUrl;

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
// @MapTo('users')
class _User {
  late String? name;
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

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
//@MapTo('subscriptions')
class _GioSubscription {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  late String? subscriptionId;
  late String? date;
  late String? user;
  @Indexed()
  late String? organizationId;
  late String? organizationName, updated;
  late int? intDate, intUpdated, subscriptionType, active;
}

@RealmModel()
//@MapTo('pricing')
class _Pricing {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  late String? countryId;
  late String? date;
  late String? countryName;
  late double? monthlyPrice, annualPrice;
}


@RealmModel()
//@MapTo('orgMessages')
class _OrgMessage {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
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
//@MapTo('locationRequests')
class _LocationRequest {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
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
//@MapTo('locationResponses')

class _LocationResponse {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
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
//@MapTo('activities')
class _ActivityModel {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

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
  late String? photo;
  late String? video;
  late String? audio;
  late String? user;
  late String? project;
  late String? projectPosition;
  late String? projectPolygon;
  late String? orgMessage;
  late String? geofenceEvent;
  late String? locationRequest;
  late String? locationResponse;
  late String? userThumbnailUrl;
  late String? userType;
  late String? translatedUserType;
  late String? settingsModel;
  late int? intDate = 0;
}


@RealmModel(ObjectType.embeddedObject)
class _Timezone {
  late String? zoneName;
  late int? gmtOffset;
  late String? gmtOffsetName;
  late String? abbreviation;
  late String? tzName;
}



@RealmModel()
//@MapTo('countries')

class _Country {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
  @Indexed()
  late String? name;
  late String? countryId;
  late int? population = 0;
  late _Position? position;
  late String? capital;
  late String? iso2;
  late String? iso3;
  late String? currency;
  late String? currencyName;
  late String? currencySymbol;
  late String? region;
  late String? subregion;
  late double? latitude;
  late double? longitude;
  late String? emoji;
  // late List<_Timezone> timezones = [];
}


@RealmModel()
//@MapTo('fieldMonitorSchedules')

class _FieldMonitorSchedule {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;

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
//@MapTo('appErrors')

class _AppError {
  @PrimaryKey()
  @MapTo('_id')
  late ObjectId id;
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


const dice = '🎲🎲🎲 Schemas 🎲🎲🎲🎲 ';
