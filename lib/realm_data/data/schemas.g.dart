// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schemas.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class City extends _City with RealmEntity, RealmObjectBase, RealmObject {
  City({
    ObjectId? id,
    String? cityId,
    String? countryId,
    String? province,
    String? country,
    String? created,
    String? name,
    Position? cityLocation,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'cityId', cityId);
    RealmObjectBase.set(this, 'countryId', countryId);
    RealmObjectBase.set(this, 'province', province);
    RealmObjectBase.set(this, 'country', country);
    RealmObjectBase.set(this, 'created', created);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'cityLocation', cityLocation);
  }

  City._();

  @override
  ObjectId? get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId?;
  @override
  set id(ObjectId? value) => RealmObjectBase.set(this, 'id', value);

  @override
  String? get cityId => RealmObjectBase.get<String>(this, 'cityId') as String?;
  @override
  set cityId(String? value) => RealmObjectBase.set(this, 'cityId', value);

  @override
  String? get countryId =>
      RealmObjectBase.get<String>(this, 'countryId') as String?;
  @override
  set countryId(String? value) => RealmObjectBase.set(this, 'countryId', value);

  @override
  String? get province =>
      RealmObjectBase.get<String>(this, 'province') as String?;
  @override
  set province(String? value) => RealmObjectBase.set(this, 'province', value);

  @override
  String? get country =>
      RealmObjectBase.get<String>(this, 'country') as String?;
  @override
  set country(String? value) => RealmObjectBase.set(this, 'country', value);

  @override
  String? get created =>
      RealmObjectBase.get<String>(this, 'created') as String?;
  @override
  set created(String? value) => RealmObjectBase.set(this, 'created', value);

  @override
  String? get name => RealmObjectBase.get<String>(this, 'name') as String?;
  @override
  set name(String? value) => RealmObjectBase.set(this, 'name', value);

  @override
  Position? get cityLocation =>
      RealmObjectBase.get<Position>(this, 'cityLocation') as Position?;
  @override
  set cityLocation(covariant Position? value) =>
      RealmObjectBase.set(this, 'cityLocation', value);

  @override
  Stream<RealmObjectChanges<City>> get changes =>
      RealmObjectBase.getChanges<City>(this);

  @override
  City freeze() => RealmObjectBase.freezeObject<City>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(City._);
    return const SchemaObject(ObjectType.realmObject, City, 'City', [
      SchemaProperty('id', RealmPropertyType.objectid, optional: true),
      SchemaProperty('cityId', RealmPropertyType.string, optional: true),
      SchemaProperty('countryId', RealmPropertyType.string, optional: true),
      SchemaProperty('province', RealmPropertyType.string, optional: true),
      SchemaProperty('country', RealmPropertyType.string, optional: true),
      SchemaProperty('created', RealmPropertyType.string, optional: true),
      SchemaProperty('name', RealmPropertyType.string, optional: true),
      SchemaProperty('cityLocation', RealmPropertyType.object,
          optional: true, linkTarget: 'Position'),
    ]);
  }
}

class Position extends _Position
    with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  Position({
    String? type = 'Point',
    Iterable<double> coordinates = const [],
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<Position>({
        'type': 'Point',
      });
    }
    RealmObjectBase.set(this, 'type', type);
    RealmObjectBase.set<RealmList<double>>(
        this, 'coordinates', RealmList<double>(coordinates));
  }

  Position._();

  @override
  String? get type => RealmObjectBase.get<String>(this, 'type') as String?;
  @override
  set type(String? value) => RealmObjectBase.set(this, 'type', value);

  @override
  RealmList<double> get coordinates =>
      RealmObjectBase.get<double>(this, 'coordinates') as RealmList<double>;
  @override
  set coordinates(covariant RealmList<double> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Position>> get changes =>
      RealmObjectBase.getChanges<Position>(this);

  @override
  Position freeze() => RealmObjectBase.freezeObject<Position>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Position._);
    return const SchemaObject(ObjectType.realmObject, Position, 'Position', [
      SchemaProperty('type', RealmPropertyType.string, optional: true),
      SchemaProperty('coordinates', RealmPropertyType.double,
          collectionType: RealmCollectionType.list),
    ]);
  }
}

class AppError extends _AppError
    with RealmEntity, RealmObjectBase, RealmObject {
  AppError({
    ObjectId? id,
    String? errorMessage,
    String? manufacturer,
    String? model,
    String? created,
    String? brand,
    String? userId,
    String? organizationId,
    String? userName,
    Position? errorPosition,
    String? iosName,
    String? versionCodeName,
    String? baseOS,
    String? deviceType,
    String? iosSystemName,
    String? userUrl,
    String? uploadedDate,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'errorMessage', errorMessage);
    RealmObjectBase.set(this, 'manufacturer', manufacturer);
    RealmObjectBase.set(this, 'model', model);
    RealmObjectBase.set(this, 'created', created);
    RealmObjectBase.set(this, 'brand', brand);
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'organizationId', organizationId);
    RealmObjectBase.set(this, 'userName', userName);
    RealmObjectBase.set(this, 'errorPosition', errorPosition);
    RealmObjectBase.set(this, 'iosName', iosName);
    RealmObjectBase.set(this, 'versionCodeName', versionCodeName);
    RealmObjectBase.set(this, 'baseOS', baseOS);
    RealmObjectBase.set(this, 'deviceType', deviceType);
    RealmObjectBase.set(this, 'iosSystemName', iosSystemName);
    RealmObjectBase.set(this, 'userUrl', userUrl);
    RealmObjectBase.set(this, 'uploadedDate', uploadedDate);
  }

  AppError._();

  @override
  ObjectId? get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId?;
  @override
  set id(ObjectId? value) => RealmObjectBase.set(this, 'id', value);

  @override
  String? get errorMessage =>
      RealmObjectBase.get<String>(this, 'errorMessage') as String?;
  @override
  set errorMessage(String? value) =>
      RealmObjectBase.set(this, 'errorMessage', value);

  @override
  String? get manufacturer =>
      RealmObjectBase.get<String>(this, 'manufacturer') as String?;
  @override
  set manufacturer(String? value) =>
      RealmObjectBase.set(this, 'manufacturer', value);

  @override
  String? get model => RealmObjectBase.get<String>(this, 'model') as String?;
  @override
  set model(String? value) => RealmObjectBase.set(this, 'model', value);

  @override
  String? get created =>
      RealmObjectBase.get<String>(this, 'created') as String?;
  @override
  set created(String? value) => RealmObjectBase.set(this, 'created', value);

  @override
  String? get brand => RealmObjectBase.get<String>(this, 'brand') as String?;
  @override
  set brand(String? value) => RealmObjectBase.set(this, 'brand', value);

  @override
  String? get userId => RealmObjectBase.get<String>(this, 'userId') as String?;
  @override
  set userId(String? value) => RealmObjectBase.set(this, 'userId', value);

  @override
  String? get organizationId =>
      RealmObjectBase.get<String>(this, 'organizationId') as String?;
  @override
  set organizationId(String? value) =>
      RealmObjectBase.set(this, 'organizationId', value);

  @override
  String? get userName =>
      RealmObjectBase.get<String>(this, 'userName') as String?;
  @override
  set userName(String? value) => RealmObjectBase.set(this, 'userName', value);

  @override
  Position? get errorPosition =>
      RealmObjectBase.get<Position>(this, 'errorPosition') as Position?;
  @override
  set errorPosition(covariant Position? value) =>
      RealmObjectBase.set(this, 'errorPosition', value);

  @override
  String? get iosName =>
      RealmObjectBase.get<String>(this, 'iosName') as String?;
  @override
  set iosName(String? value) => RealmObjectBase.set(this, 'iosName', value);

  @override
  String? get versionCodeName =>
      RealmObjectBase.get<String>(this, 'versionCodeName') as String?;
  @override
  set versionCodeName(String? value) =>
      RealmObjectBase.set(this, 'versionCodeName', value);

  @override
  String? get baseOS => RealmObjectBase.get<String>(this, 'baseOS') as String?;
  @override
  set baseOS(String? value) => RealmObjectBase.set(this, 'baseOS', value);

  @override
  String? get deviceType =>
      RealmObjectBase.get<String>(this, 'deviceType') as String?;
  @override
  set deviceType(String? value) =>
      RealmObjectBase.set(this, 'deviceType', value);

  @override
  String? get iosSystemName =>
      RealmObjectBase.get<String>(this, 'iosSystemName') as String?;
  @override
  set iosSystemName(String? value) =>
      RealmObjectBase.set(this, 'iosSystemName', value);

  @override
  String? get userUrl =>
      RealmObjectBase.get<String>(this, 'userUrl') as String?;
  @override
  set userUrl(String? value) => RealmObjectBase.set(this, 'userUrl', value);

  @override
  String? get uploadedDate =>
      RealmObjectBase.get<String>(this, 'uploadedDate') as String?;
  @override
  set uploadedDate(String? value) =>
      RealmObjectBase.set(this, 'uploadedDate', value);

  @override
  Stream<RealmObjectChanges<AppError>> get changes =>
      RealmObjectBase.getChanges<AppError>(this);

  @override
  AppError freeze() => RealmObjectBase.freezeObject<AppError>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(AppError._);
    return const SchemaObject(ObjectType.realmObject, AppError, 'AppError', [
      SchemaProperty('id', RealmPropertyType.objectid, optional: true),
      SchemaProperty('errorMessage', RealmPropertyType.string, optional: true),
      SchemaProperty('manufacturer', RealmPropertyType.string, optional: true),
      SchemaProperty('model', RealmPropertyType.string, optional: true),
      SchemaProperty('created', RealmPropertyType.string, optional: true),
      SchemaProperty('brand', RealmPropertyType.string, optional: true),
      SchemaProperty('userId', RealmPropertyType.string, optional: true),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('userName', RealmPropertyType.string, optional: true),
      SchemaProperty('errorPosition', RealmPropertyType.object,
          optional: true, linkTarget: 'Position'),
      SchemaProperty('iosName', RealmPropertyType.string, optional: true),
      SchemaProperty('versionCodeName', RealmPropertyType.string,
          optional: true),
      SchemaProperty('baseOS', RealmPropertyType.string, optional: true),
      SchemaProperty('deviceType', RealmPropertyType.string, optional: true),
      SchemaProperty('iosSystemName', RealmPropertyType.string, optional: true),
      SchemaProperty('userUrl', RealmPropertyType.string, optional: true),
      SchemaProperty('uploadedDate', RealmPropertyType.string, optional: true),
    ]);
  }
}

class Audio extends _Audio with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  Audio({
    String? audioId,
    int? durationInSeconds = 0,
    String? created,
    String? url,
    String? projectPositionId,
    String? userId,
    String? userName,
    String? organizationId,
    Position? projectPosition,
    double? distanceFromProjectPosition,
    String? projectId,
    String? projectName,
    String? projectPolygonId,
    String? userUrl,
    String? translatedMessage,
    String? translatedTitle,
    String? caption,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<Audio>({
        'durationInSeconds': 0,
      });
    }
    RealmObjectBase.set(this, 'audioId', audioId);
    RealmObjectBase.set(this, 'durationInSeconds', durationInSeconds);
    RealmObjectBase.set(this, 'created', created);
    RealmObjectBase.set(this, 'url', url);
    RealmObjectBase.set(this, 'projectPositionId', projectPositionId);
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'userName', userName);
    RealmObjectBase.set(this, 'organizationId', organizationId);
    RealmObjectBase.set(this, 'projectPosition', projectPosition);
    RealmObjectBase.set(
        this, 'distanceFromProjectPosition', distanceFromProjectPosition);
    RealmObjectBase.set(this, 'projectId', projectId);
    RealmObjectBase.set(this, 'projectName', projectName);
    RealmObjectBase.set(this, 'projectPolygonId', projectPolygonId);
    RealmObjectBase.set(this, 'userUrl', userUrl);
    RealmObjectBase.set(this, 'translatedMessage', translatedMessage);
    RealmObjectBase.set(this, 'translatedTitle', translatedTitle);
    RealmObjectBase.set(this, 'caption', caption);
  }

  Audio._();

  @override
  String? get audioId =>
      RealmObjectBase.get<String>(this, 'audioId') as String?;
  @override
  set audioId(String? value) => RealmObjectBase.set(this, 'audioId', value);

  @override
  int? get durationInSeconds =>
      RealmObjectBase.get<int>(this, 'durationInSeconds') as int?;
  @override
  set durationInSeconds(int? value) =>
      RealmObjectBase.set(this, 'durationInSeconds', value);

  @override
  String? get created =>
      RealmObjectBase.get<String>(this, 'created') as String?;
  @override
  set created(String? value) => RealmObjectBase.set(this, 'created', value);

  @override
  String? get url => RealmObjectBase.get<String>(this, 'url') as String?;
  @override
  set url(String? value) => RealmObjectBase.set(this, 'url', value);

  @override
  String? get projectPositionId =>
      RealmObjectBase.get<String>(this, 'projectPositionId') as String?;
  @override
  set projectPositionId(String? value) =>
      RealmObjectBase.set(this, 'projectPositionId', value);

  @override
  String? get userId => RealmObjectBase.get<String>(this, 'userId') as String?;
  @override
  set userId(String? value) => RealmObjectBase.set(this, 'userId', value);

  @override
  String? get userName =>
      RealmObjectBase.get<String>(this, 'userName') as String?;
  @override
  set userName(String? value) => RealmObjectBase.set(this, 'userName', value);

  @override
  String? get organizationId =>
      RealmObjectBase.get<String>(this, 'organizationId') as String?;
  @override
  set organizationId(String? value) =>
      RealmObjectBase.set(this, 'organizationId', value);

  @override
  Position? get projectPosition =>
      RealmObjectBase.get<Position>(this, 'projectPosition') as Position?;
  @override
  set projectPosition(covariant Position? value) =>
      RealmObjectBase.set(this, 'projectPosition', value);

  @override
  double? get distanceFromProjectPosition =>
      RealmObjectBase.get<double>(this, 'distanceFromProjectPosition')
          as double?;
  @override
  set distanceFromProjectPosition(double? value) =>
      RealmObjectBase.set(this, 'distanceFromProjectPosition', value);

  @override
  String? get projectId =>
      RealmObjectBase.get<String>(this, 'projectId') as String?;
  @override
  set projectId(String? value) => RealmObjectBase.set(this, 'projectId', value);

  @override
  String? get projectName =>
      RealmObjectBase.get<String>(this, 'projectName') as String?;
  @override
  set projectName(String? value) =>
      RealmObjectBase.set(this, 'projectName', value);

  @override
  String? get projectPolygonId =>
      RealmObjectBase.get<String>(this, 'projectPolygonId') as String?;
  @override
  set projectPolygonId(String? value) =>
      RealmObjectBase.set(this, 'projectPolygonId', value);

  @override
  String? get userUrl =>
      RealmObjectBase.get<String>(this, 'userUrl') as String?;
  @override
  set userUrl(String? value) => RealmObjectBase.set(this, 'userUrl', value);

  @override
  String? get translatedMessage =>
      RealmObjectBase.get<String>(this, 'translatedMessage') as String?;
  @override
  set translatedMessage(String? value) =>
      RealmObjectBase.set(this, 'translatedMessage', value);

  @override
  String? get translatedTitle =>
      RealmObjectBase.get<String>(this, 'translatedTitle') as String?;
  @override
  set translatedTitle(String? value) =>
      RealmObjectBase.set(this, 'translatedTitle', value);

  @override
  String? get caption =>
      RealmObjectBase.get<String>(this, 'caption') as String?;
  @override
  set caption(String? value) => RealmObjectBase.set(this, 'caption', value);

  @override
  Stream<RealmObjectChanges<Audio>> get changes =>
      RealmObjectBase.getChanges<Audio>(this);

  @override
  Audio freeze() => RealmObjectBase.freezeObject<Audio>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Audio._);
    return const SchemaObject(ObjectType.realmObject, Audio, 'Audio', [
      SchemaProperty('audioId', RealmPropertyType.string, optional: true),
      SchemaProperty('durationInSeconds', RealmPropertyType.int,
          optional: true),
      SchemaProperty('created', RealmPropertyType.string, optional: true),
      SchemaProperty('url', RealmPropertyType.string, optional: true),
      SchemaProperty('projectPositionId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('userId', RealmPropertyType.string, optional: true),
      SchemaProperty('userName', RealmPropertyType.string, optional: true),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('projectPosition', RealmPropertyType.object,
          optional: true, linkTarget: 'Position'),
      SchemaProperty('distanceFromProjectPosition', RealmPropertyType.double,
          optional: true),
      SchemaProperty('projectId', RealmPropertyType.string, optional: true),
      SchemaProperty('projectName', RealmPropertyType.string, optional: true),
      SchemaProperty('projectPolygonId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('userUrl', RealmPropertyType.string, optional: true),
      SchemaProperty('translatedMessage', RealmPropertyType.string,
          optional: true),
      SchemaProperty('translatedTitle', RealmPropertyType.string,
          optional: true),
      SchemaProperty('caption', RealmPropertyType.string, optional: true),
    ]);
  }
}

class Photo extends _Photo with RealmEntity, RealmObjectBase, RealmObject {
  Photo(
    String photoId, {
    String? created,
    String? url,
    String? thumbnailUrl,
    int? landscape,
    String? projectPositionId,
    String? userId,
    String? userName,
    String? organizationId,
    Position? projectPosition,
    double? distanceFromProjectPosition,
    String? projectId,
    String? projectName,
    String? projectPolygonId,
    String? userUrl,
    String? translatedMessage,
    String? translatedTitle,
    String? caption,
  }) {
    RealmObjectBase.set(this, 'photoId', photoId);
    RealmObjectBase.set(this, 'created', created);
    RealmObjectBase.set(this, 'url', url);
    RealmObjectBase.set(this, 'thumbnailUrl', thumbnailUrl);
    RealmObjectBase.set(this, 'landscape', landscape);
    RealmObjectBase.set(this, 'projectPositionId', projectPositionId);
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'userName', userName);
    RealmObjectBase.set(this, 'organizationId', organizationId);
    RealmObjectBase.set(this, 'projectPosition', projectPosition);
    RealmObjectBase.set(
        this, 'distanceFromProjectPosition', distanceFromProjectPosition);
    RealmObjectBase.set(this, 'projectId', projectId);
    RealmObjectBase.set(this, 'projectName', projectName);
    RealmObjectBase.set(this, 'projectPolygonId', projectPolygonId);
    RealmObjectBase.set(this, 'userUrl', userUrl);
    RealmObjectBase.set(this, 'translatedMessage', translatedMessage);
    RealmObjectBase.set(this, 'translatedTitle', translatedTitle);
    RealmObjectBase.set(this, 'caption', caption);
  }

  Photo._();

  @override
  String get photoId => RealmObjectBase.get<String>(this, 'photoId') as String;
  @override
  set photoId(String value) => RealmObjectBase.set(this, 'photoId', value);

  @override
  String? get created =>
      RealmObjectBase.get<String>(this, 'created') as String?;
  @override
  set created(String? value) => RealmObjectBase.set(this, 'created', value);

  @override
  String? get url => RealmObjectBase.get<String>(this, 'url') as String?;
  @override
  set url(String? value) => RealmObjectBase.set(this, 'url', value);

  @override
  String? get thumbnailUrl =>
      RealmObjectBase.get<String>(this, 'thumbnailUrl') as String?;
  @override
  set thumbnailUrl(String? value) =>
      RealmObjectBase.set(this, 'thumbnailUrl', value);

  @override
  int? get landscape => RealmObjectBase.get<int>(this, 'landscape') as int?;
  @override
  set landscape(int? value) => RealmObjectBase.set(this, 'landscape', value);

  @override
  String? get projectPositionId =>
      RealmObjectBase.get<String>(this, 'projectPositionId') as String?;
  @override
  set projectPositionId(String? value) =>
      RealmObjectBase.set(this, 'projectPositionId', value);

  @override
  String? get userId => RealmObjectBase.get<String>(this, 'userId') as String?;
  @override
  set userId(String? value) => RealmObjectBase.set(this, 'userId', value);

  @override
  String? get userName =>
      RealmObjectBase.get<String>(this, 'userName') as String?;
  @override
  set userName(String? value) => RealmObjectBase.set(this, 'userName', value);

  @override
  String? get organizationId =>
      RealmObjectBase.get<String>(this, 'organizationId') as String?;
  @override
  set organizationId(String? value) =>
      RealmObjectBase.set(this, 'organizationId', value);

  @override
  Position? get projectPosition =>
      RealmObjectBase.get<Position>(this, 'projectPosition') as Position?;
  @override
  set projectPosition(covariant Position? value) =>
      RealmObjectBase.set(this, 'projectPosition', value);

  @override
  double? get distanceFromProjectPosition =>
      RealmObjectBase.get<double>(this, 'distanceFromProjectPosition')
          as double?;
  @override
  set distanceFromProjectPosition(double? value) =>
      RealmObjectBase.set(this, 'distanceFromProjectPosition', value);

  @override
  String? get projectId =>
      RealmObjectBase.get<String>(this, 'projectId') as String?;
  @override
  set projectId(String? value) => RealmObjectBase.set(this, 'projectId', value);

  @override
  String? get projectName =>
      RealmObjectBase.get<String>(this, 'projectName') as String?;
  @override
  set projectName(String? value) =>
      RealmObjectBase.set(this, 'projectName', value);

  @override
  String? get projectPolygonId =>
      RealmObjectBase.get<String>(this, 'projectPolygonId') as String?;
  @override
  set projectPolygonId(String? value) =>
      RealmObjectBase.set(this, 'projectPolygonId', value);

  @override
  String? get userUrl =>
      RealmObjectBase.get<String>(this, 'userUrl') as String?;
  @override
  set userUrl(String? value) => RealmObjectBase.set(this, 'userUrl', value);

  @override
  String? get translatedMessage =>
      RealmObjectBase.get<String>(this, 'translatedMessage') as String?;
  @override
  set translatedMessage(String? value) =>
      RealmObjectBase.set(this, 'translatedMessage', value);

  @override
  String? get translatedTitle =>
      RealmObjectBase.get<String>(this, 'translatedTitle') as String?;
  @override
  set translatedTitle(String? value) =>
      RealmObjectBase.set(this, 'translatedTitle', value);

  @override
  String? get caption =>
      RealmObjectBase.get<String>(this, 'caption') as String?;
  @override
  set caption(String? value) => RealmObjectBase.set(this, 'caption', value);

  @override
  Stream<RealmObjectChanges<Photo>> get changes =>
      RealmObjectBase.getChanges<Photo>(this);

  @override
  Photo freeze() => RealmObjectBase.freezeObject<Photo>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Photo._);
    return const SchemaObject(ObjectType.realmObject, Photo, 'Photo', [
      SchemaProperty('photoId', RealmPropertyType.string),
      SchemaProperty('created', RealmPropertyType.string, optional: true),
      SchemaProperty('url', RealmPropertyType.string, optional: true),
      SchemaProperty('thumbnailUrl', RealmPropertyType.string, optional: true),
      SchemaProperty('landscape', RealmPropertyType.int, optional: true),
      SchemaProperty('projectPositionId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('userId', RealmPropertyType.string, optional: true),
      SchemaProperty('userName', RealmPropertyType.string, optional: true),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('projectPosition', RealmPropertyType.object,
          optional: true, linkTarget: 'Position'),
      SchemaProperty('distanceFromProjectPosition', RealmPropertyType.double,
          optional: true),
      SchemaProperty('projectId', RealmPropertyType.string, optional: true),
      SchemaProperty('projectName', RealmPropertyType.string, optional: true),
      SchemaProperty('projectPolygonId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('userUrl', RealmPropertyType.string, optional: true),
      SchemaProperty('translatedMessage', RealmPropertyType.string,
          optional: true),
      SchemaProperty('translatedTitle', RealmPropertyType.string,
          optional: true),
      SchemaProperty('caption', RealmPropertyType.string, optional: true),
    ]);
  }
}

class Video extends _Video with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  Video(
    String videoId, {
    String? created,
    String? url,
    String? thumbnailUrl,
    int? landscape,
    String? projectPositionId,
    String? userId,
    String? userName,
    String? organizationId,
    Position? projectPosition,
    double? distanceFromProjectPosition,
    String? projectId,
    String? projectName,
    String? projectPolygonId,
    String? userUrl,
    String? translatedMessage,
    String? translatedTitle,
    String? caption,
    int? durationInSeconds = 0,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<Video>({
        'durationInSeconds': 0,
      });
    }
    RealmObjectBase.set(this, 'videoId', videoId);
    RealmObjectBase.set(this, 'created', created);
    RealmObjectBase.set(this, 'url', url);
    RealmObjectBase.set(this, 'thumbnailUrl', thumbnailUrl);
    RealmObjectBase.set(this, 'landscape', landscape);
    RealmObjectBase.set(this, 'projectPositionId', projectPositionId);
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'userName', userName);
    RealmObjectBase.set(this, 'organizationId', organizationId);
    RealmObjectBase.set(this, 'projectPosition', projectPosition);
    RealmObjectBase.set(
        this, 'distanceFromProjectPosition', distanceFromProjectPosition);
    RealmObjectBase.set(this, 'projectId', projectId);
    RealmObjectBase.set(this, 'projectName', projectName);
    RealmObjectBase.set(this, 'projectPolygonId', projectPolygonId);
    RealmObjectBase.set(this, 'userUrl', userUrl);
    RealmObjectBase.set(this, 'translatedMessage', translatedMessage);
    RealmObjectBase.set(this, 'translatedTitle', translatedTitle);
    RealmObjectBase.set(this, 'caption', caption);
    RealmObjectBase.set(this, 'durationInSeconds', durationInSeconds);
  }

  Video._();

  @override
  String get videoId => RealmObjectBase.get<String>(this, 'videoId') as String;
  @override
  set videoId(String value) => RealmObjectBase.set(this, 'videoId', value);

  @override
  String? get created =>
      RealmObjectBase.get<String>(this, 'created') as String?;
  @override
  set created(String? value) => RealmObjectBase.set(this, 'created', value);

  @override
  String? get url => RealmObjectBase.get<String>(this, 'url') as String?;
  @override
  set url(String? value) => RealmObjectBase.set(this, 'url', value);

  @override
  String? get thumbnailUrl =>
      RealmObjectBase.get<String>(this, 'thumbnailUrl') as String?;
  @override
  set thumbnailUrl(String? value) =>
      RealmObjectBase.set(this, 'thumbnailUrl', value);

  @override
  int? get landscape => RealmObjectBase.get<int>(this, 'landscape') as int?;
  @override
  set landscape(int? value) => RealmObjectBase.set(this, 'landscape', value);

  @override
  String? get projectPositionId =>
      RealmObjectBase.get<String>(this, 'projectPositionId') as String?;
  @override
  set projectPositionId(String? value) =>
      RealmObjectBase.set(this, 'projectPositionId', value);

  @override
  String? get userId => RealmObjectBase.get<String>(this, 'userId') as String?;
  @override
  set userId(String? value) => RealmObjectBase.set(this, 'userId', value);

  @override
  String? get userName =>
      RealmObjectBase.get<String>(this, 'userName') as String?;
  @override
  set userName(String? value) => RealmObjectBase.set(this, 'userName', value);

  @override
  String? get organizationId =>
      RealmObjectBase.get<String>(this, 'organizationId') as String?;
  @override
  set organizationId(String? value) =>
      RealmObjectBase.set(this, 'organizationId', value);

  @override
  Position? get projectPosition =>
      RealmObjectBase.get<Position>(this, 'projectPosition') as Position?;
  @override
  set projectPosition(covariant Position? value) =>
      RealmObjectBase.set(this, 'projectPosition', value);

  @override
  double? get distanceFromProjectPosition =>
      RealmObjectBase.get<double>(this, 'distanceFromProjectPosition')
          as double?;
  @override
  set distanceFromProjectPosition(double? value) =>
      RealmObjectBase.set(this, 'distanceFromProjectPosition', value);

  @override
  String? get projectId =>
      RealmObjectBase.get<String>(this, 'projectId') as String?;
  @override
  set projectId(String? value) => RealmObjectBase.set(this, 'projectId', value);

  @override
  String? get projectName =>
      RealmObjectBase.get<String>(this, 'projectName') as String?;
  @override
  set projectName(String? value) =>
      RealmObjectBase.set(this, 'projectName', value);

  @override
  String? get projectPolygonId =>
      RealmObjectBase.get<String>(this, 'projectPolygonId') as String?;
  @override
  set projectPolygonId(String? value) =>
      RealmObjectBase.set(this, 'projectPolygonId', value);

  @override
  String? get userUrl =>
      RealmObjectBase.get<String>(this, 'userUrl') as String?;
  @override
  set userUrl(String? value) => RealmObjectBase.set(this, 'userUrl', value);

  @override
  String? get translatedMessage =>
      RealmObjectBase.get<String>(this, 'translatedMessage') as String?;
  @override
  set translatedMessage(String? value) =>
      RealmObjectBase.set(this, 'translatedMessage', value);

  @override
  String? get translatedTitle =>
      RealmObjectBase.get<String>(this, 'translatedTitle') as String?;
  @override
  set translatedTitle(String? value) =>
      RealmObjectBase.set(this, 'translatedTitle', value);

  @override
  String? get caption =>
      RealmObjectBase.get<String>(this, 'caption') as String?;
  @override
  set caption(String? value) => RealmObjectBase.set(this, 'caption', value);

  @override
  int? get durationInSeconds =>
      RealmObjectBase.get<int>(this, 'durationInSeconds') as int?;
  @override
  set durationInSeconds(int? value) =>
      RealmObjectBase.set(this, 'durationInSeconds', value);

  @override
  Stream<RealmObjectChanges<Video>> get changes =>
      RealmObjectBase.getChanges<Video>(this);

  @override
  Video freeze() => RealmObjectBase.freezeObject<Video>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Video._);
    return const SchemaObject(ObjectType.realmObject, Video, 'Video', [
      SchemaProperty('videoId', RealmPropertyType.string),
      SchemaProperty('created', RealmPropertyType.string, optional: true),
      SchemaProperty('url', RealmPropertyType.string, optional: true),
      SchemaProperty('thumbnailUrl', RealmPropertyType.string, optional: true),
      SchemaProperty('landscape', RealmPropertyType.int, optional: true),
      SchemaProperty('projectPositionId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('userId', RealmPropertyType.string, optional: true),
      SchemaProperty('userName', RealmPropertyType.string, optional: true),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('projectPosition', RealmPropertyType.object,
          optional: true, linkTarget: 'Position'),
      SchemaProperty('distanceFromProjectPosition', RealmPropertyType.double,
          optional: true),
      SchemaProperty('projectId', RealmPropertyType.string, optional: true),
      SchemaProperty('projectName', RealmPropertyType.string, optional: true),
      SchemaProperty('projectPolygonId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('userUrl', RealmPropertyType.string, optional: true),
      SchemaProperty('translatedMessage', RealmPropertyType.string,
          optional: true),
      SchemaProperty('translatedTitle', RealmPropertyType.string,
          optional: true),
      SchemaProperty('caption', RealmPropertyType.string, optional: true),
      SchemaProperty('durationInSeconds', RealmPropertyType.int,
          optional: true),
    ]);
  }
}

class Organization extends _Organization
    with RealmEntity, RealmObjectBase, RealmObject {
  Organization({
    String? organizationId,
    String? name,
    String? admin,
    String? countryId,
    String? countryName,
    String? created,
    String? email,
    String? translatedMessage,
    String? translatedTitle,
  }) {
    RealmObjectBase.set(this, 'organizationId', organizationId);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'admin', admin);
    RealmObjectBase.set(this, 'countryId', countryId);
    RealmObjectBase.set(this, 'countryName', countryName);
    RealmObjectBase.set(this, 'created', created);
    RealmObjectBase.set(this, 'email', email);
    RealmObjectBase.set(this, 'translatedMessage', translatedMessage);
    RealmObjectBase.set(this, 'translatedTitle', translatedTitle);
  }

  Organization._();

  @override
  String? get organizationId =>
      RealmObjectBase.get<String>(this, 'organizationId') as String?;
  @override
  set organizationId(String? value) =>
      RealmObjectBase.set(this, 'organizationId', value);

  @override
  String? get name => RealmObjectBase.get<String>(this, 'name') as String?;
  @override
  set name(String? value) => RealmObjectBase.set(this, 'name', value);

  @override
  String? get admin => RealmObjectBase.get<String>(this, 'admin') as String?;
  @override
  set admin(String? value) => RealmObjectBase.set(this, 'admin', value);

  @override
  String? get countryId =>
      RealmObjectBase.get<String>(this, 'countryId') as String?;
  @override
  set countryId(String? value) => RealmObjectBase.set(this, 'countryId', value);

  @override
  String? get countryName =>
      RealmObjectBase.get<String>(this, 'countryName') as String?;
  @override
  set countryName(String? value) =>
      RealmObjectBase.set(this, 'countryName', value);

  @override
  String? get created =>
      RealmObjectBase.get<String>(this, 'created') as String?;
  @override
  set created(String? value) => RealmObjectBase.set(this, 'created', value);

  @override
  String? get email => RealmObjectBase.get<String>(this, 'email') as String?;
  @override
  set email(String? value) => RealmObjectBase.set(this, 'email', value);

  @override
  String? get translatedMessage =>
      RealmObjectBase.get<String>(this, 'translatedMessage') as String?;
  @override
  set translatedMessage(String? value) =>
      RealmObjectBase.set(this, 'translatedMessage', value);

  @override
  String? get translatedTitle =>
      RealmObjectBase.get<String>(this, 'translatedTitle') as String?;
  @override
  set translatedTitle(String? value) =>
      RealmObjectBase.set(this, 'translatedTitle', value);

  @override
  Stream<RealmObjectChanges<Organization>> get changes =>
      RealmObjectBase.getChanges<Organization>(this);

  @override
  Organization freeze() => RealmObjectBase.freezeObject<Organization>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Organization._);
    return const SchemaObject(
        ObjectType.realmObject, Organization, 'Organization', [
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('name', RealmPropertyType.string, optional: true),
      SchemaProperty('admin', RealmPropertyType.string, optional: true),
      SchemaProperty('countryId', RealmPropertyType.string, optional: true),
      SchemaProperty('countryName', RealmPropertyType.string, optional: true),
      SchemaProperty('created', RealmPropertyType.string, optional: true),
      SchemaProperty('email', RealmPropertyType.string, optional: true),
      SchemaProperty('translatedMessage', RealmPropertyType.string,
          optional: true),
      SchemaProperty('translatedTitle', RealmPropertyType.string,
          optional: true),
    ]);
  }
}

class Project extends _Project with RealmEntity, RealmObjectBase, RealmObject {
  Project({
    String? projectId,
    String? name,
    String? organizationId,
    String? organizationName,
    String? description,
    String? translatedMessage,
    String? translatedTitle,
    Iterable<City> nearestCities = const [],
  }) {
    RealmObjectBase.set(this, 'projectId', projectId);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'organizationId', organizationId);
    RealmObjectBase.set(this, 'organizationName', organizationName);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'translatedMessage', translatedMessage);
    RealmObjectBase.set(this, 'translatedTitle', translatedTitle);
    RealmObjectBase.set<RealmList<City>>(
        this, 'nearestCities', RealmList<City>(nearestCities));
  }

  Project._();

  @override
  String? get projectId =>
      RealmObjectBase.get<String>(this, 'projectId') as String?;
  @override
  set projectId(String? value) => RealmObjectBase.set(this, 'projectId', value);

  @override
  String? get name => RealmObjectBase.get<String>(this, 'name') as String?;
  @override
  set name(String? value) => RealmObjectBase.set(this, 'name', value);

  @override
  RealmList<City> get nearestCities =>
      RealmObjectBase.get<City>(this, 'nearestCities') as RealmList<City>;
  @override
  set nearestCities(covariant RealmList<City> value) =>
      throw RealmUnsupportedSetError();

  @override
  String? get organizationId =>
      RealmObjectBase.get<String>(this, 'organizationId') as String?;
  @override
  set organizationId(String? value) =>
      RealmObjectBase.set(this, 'organizationId', value);

  @override
  String? get organizationName =>
      RealmObjectBase.get<String>(this, 'organizationName') as String?;
  @override
  set organizationName(String? value) =>
      RealmObjectBase.set(this, 'organizationName', value);

  @override
  String? get description =>
      RealmObjectBase.get<String>(this, 'description') as String?;
  @override
  set description(String? value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  String? get translatedMessage =>
      RealmObjectBase.get<String>(this, 'translatedMessage') as String?;
  @override
  set translatedMessage(String? value) =>
      RealmObjectBase.set(this, 'translatedMessage', value);

  @override
  String? get translatedTitle =>
      RealmObjectBase.get<String>(this, 'translatedTitle') as String?;
  @override
  set translatedTitle(String? value) =>
      RealmObjectBase.set(this, 'translatedTitle', value);

  @override
  Stream<RealmObjectChanges<Project>> get changes =>
      RealmObjectBase.getChanges<Project>(this);

  @override
  Project freeze() => RealmObjectBase.freezeObject<Project>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Project._);
    return const SchemaObject(ObjectType.realmObject, Project, 'Project', [
      SchemaProperty('projectId', RealmPropertyType.string, optional: true),
      SchemaProperty('name', RealmPropertyType.string, optional: true),
      SchemaProperty('nearestCities', RealmPropertyType.object,
          linkTarget: 'City', collectionType: RealmCollectionType.list),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('organizationName', RealmPropertyType.string,
          optional: true),
      SchemaProperty('description', RealmPropertyType.string, optional: true),
      SchemaProperty('translatedMessage', RealmPropertyType.string,
          optional: true),
      SchemaProperty('translatedTitle', RealmPropertyType.string,
          optional: true),
    ]);
  }
}

class ProjectPosition extends _ProjectPosition
    with RealmEntity, RealmObjectBase, RealmObject {
  ProjectPosition({
    String? projectName,
    String? projectId,
    String? caption,
    String? created,
    String? projectPositionId,
    String? organizationId,
    Position? position,
    PlaceMark? placemark,
    String? name,
    String? userId,
    String? userName,
    String? possibleAddress,
    String? translatedMessage,
    String? translatedTitle,
    Iterable<City> nearestCities = const [],
  }) {
    RealmObjectBase.set(this, 'projectName', projectName);
    RealmObjectBase.set(this, 'projectId', projectId);
    RealmObjectBase.set(this, 'caption', caption);
    RealmObjectBase.set(this, 'created', created);
    RealmObjectBase.set(this, 'projectPositionId', projectPositionId);
    RealmObjectBase.set(this, 'organizationId', organizationId);
    RealmObjectBase.set(this, 'position', position);
    RealmObjectBase.set(this, 'placemark', placemark);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'userName', userName);
    RealmObjectBase.set(this, 'possibleAddress', possibleAddress);
    RealmObjectBase.set(this, 'translatedMessage', translatedMessage);
    RealmObjectBase.set(this, 'translatedTitle', translatedTitle);
    RealmObjectBase.set<RealmList<City>>(
        this, 'nearestCities', RealmList<City>(nearestCities));
  }

  ProjectPosition._();

  @override
  String? get projectName =>
      RealmObjectBase.get<String>(this, 'projectName') as String?;
  @override
  set projectName(String? value) =>
      RealmObjectBase.set(this, 'projectName', value);

  @override
  String? get projectId =>
      RealmObjectBase.get<String>(this, 'projectId') as String?;
  @override
  set projectId(String? value) => RealmObjectBase.set(this, 'projectId', value);

  @override
  String? get caption =>
      RealmObjectBase.get<String>(this, 'caption') as String?;
  @override
  set caption(String? value) => RealmObjectBase.set(this, 'caption', value);

  @override
  String? get created =>
      RealmObjectBase.get<String>(this, 'created') as String?;
  @override
  set created(String? value) => RealmObjectBase.set(this, 'created', value);

  @override
  String? get projectPositionId =>
      RealmObjectBase.get<String>(this, 'projectPositionId') as String?;
  @override
  set projectPositionId(String? value) =>
      RealmObjectBase.set(this, 'projectPositionId', value);

  @override
  String? get organizationId =>
      RealmObjectBase.get<String>(this, 'organizationId') as String?;
  @override
  set organizationId(String? value) =>
      RealmObjectBase.set(this, 'organizationId', value);

  @override
  Position? get position =>
      RealmObjectBase.get<Position>(this, 'position') as Position?;
  @override
  set position(covariant Position? value) =>
      RealmObjectBase.set(this, 'position', value);

  @override
  PlaceMark? get placemark =>
      RealmObjectBase.get<PlaceMark>(this, 'placemark') as PlaceMark?;
  @override
  set placemark(covariant PlaceMark? value) =>
      RealmObjectBase.set(this, 'placemark', value);

  @override
  RealmList<City> get nearestCities =>
      RealmObjectBase.get<City>(this, 'nearestCities') as RealmList<City>;
  @override
  set nearestCities(covariant RealmList<City> value) =>
      throw RealmUnsupportedSetError();

  @override
  String? get name => RealmObjectBase.get<String>(this, 'name') as String?;
  @override
  set name(String? value) => RealmObjectBase.set(this, 'name', value);

  @override
  String? get userId => RealmObjectBase.get<String>(this, 'userId') as String?;
  @override
  set userId(String? value) => RealmObjectBase.set(this, 'userId', value);

  @override
  String? get userName =>
      RealmObjectBase.get<String>(this, 'userName') as String?;
  @override
  set userName(String? value) => RealmObjectBase.set(this, 'userName', value);

  @override
  String? get possibleAddress =>
      RealmObjectBase.get<String>(this, 'possibleAddress') as String?;
  @override
  set possibleAddress(String? value) =>
      RealmObjectBase.set(this, 'possibleAddress', value);

  @override
  String? get translatedMessage =>
      RealmObjectBase.get<String>(this, 'translatedMessage') as String?;
  @override
  set translatedMessage(String? value) =>
      RealmObjectBase.set(this, 'translatedMessage', value);

  @override
  String? get translatedTitle =>
      RealmObjectBase.get<String>(this, 'translatedTitle') as String?;
  @override
  set translatedTitle(String? value) =>
      RealmObjectBase.set(this, 'translatedTitle', value);

  @override
  Stream<RealmObjectChanges<ProjectPosition>> get changes =>
      RealmObjectBase.getChanges<ProjectPosition>(this);

  @override
  ProjectPosition freeze() =>
      RealmObjectBase.freezeObject<ProjectPosition>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ProjectPosition._);
    return const SchemaObject(
        ObjectType.realmObject, ProjectPosition, 'ProjectPosition', [
      SchemaProperty('projectName', RealmPropertyType.string, optional: true),
      SchemaProperty('projectId', RealmPropertyType.string, optional: true),
      SchemaProperty('caption', RealmPropertyType.string, optional: true),
      SchemaProperty('created', RealmPropertyType.string, optional: true),
      SchemaProperty('projectPositionId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('position', RealmPropertyType.object,
          optional: true, linkTarget: 'Position'),
      SchemaProperty('placemark', RealmPropertyType.object,
          optional: true, linkTarget: 'PlaceMark'),
      SchemaProperty('nearestCities', RealmPropertyType.object,
          linkTarget: 'City', collectionType: RealmCollectionType.list),
      SchemaProperty('name', RealmPropertyType.string, optional: true),
      SchemaProperty('userId', RealmPropertyType.string, optional: true),
      SchemaProperty('userName', RealmPropertyType.string, optional: true),
      SchemaProperty('possibleAddress', RealmPropertyType.string,
          optional: true),
      SchemaProperty('translatedMessage', RealmPropertyType.string,
          optional: true),
      SchemaProperty('translatedTitle', RealmPropertyType.string,
          optional: true),
    ]);
  }
}

class PlaceMark extends _PlaceMark
    with RealmEntity, RealmObjectBase, RealmObject {
  PlaceMark({
    String? administrativeArea,
    String? subAdministrativeArea,
    String? locality,
    String? subLocality,
    String? thoroughfare,
    String? subThoroughfare,
    String? name,
    String? street,
    String? country,
    String? isoCountryCode,
    String? postalCode,
  }) {
    RealmObjectBase.set(this, 'administrativeArea', administrativeArea);
    RealmObjectBase.set(this, 'subAdministrativeArea', subAdministrativeArea);
    RealmObjectBase.set(this, 'locality', locality);
    RealmObjectBase.set(this, 'subLocality', subLocality);
    RealmObjectBase.set(this, 'thoroughfare', thoroughfare);
    RealmObjectBase.set(this, 'subThoroughfare', subThoroughfare);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'street', street);
    RealmObjectBase.set(this, 'country', country);
    RealmObjectBase.set(this, 'isoCountryCode', isoCountryCode);
    RealmObjectBase.set(this, 'postalCode', postalCode);
  }

  PlaceMark._();

  @override
  String? get administrativeArea =>
      RealmObjectBase.get<String>(this, 'administrativeArea') as String?;
  @override
  set administrativeArea(String? value) =>
      RealmObjectBase.set(this, 'administrativeArea', value);

  @override
  String? get subAdministrativeArea =>
      RealmObjectBase.get<String>(this, 'subAdministrativeArea') as String?;
  @override
  set subAdministrativeArea(String? value) =>
      RealmObjectBase.set(this, 'subAdministrativeArea', value);

  @override
  String? get locality =>
      RealmObjectBase.get<String>(this, 'locality') as String?;
  @override
  set locality(String? value) => RealmObjectBase.set(this, 'locality', value);

  @override
  String? get subLocality =>
      RealmObjectBase.get<String>(this, 'subLocality') as String?;
  @override
  set subLocality(String? value) =>
      RealmObjectBase.set(this, 'subLocality', value);

  @override
  String? get thoroughfare =>
      RealmObjectBase.get<String>(this, 'thoroughfare') as String?;
  @override
  set thoroughfare(String? value) =>
      RealmObjectBase.set(this, 'thoroughfare', value);

  @override
  String? get subThoroughfare =>
      RealmObjectBase.get<String>(this, 'subThoroughfare') as String?;
  @override
  set subThoroughfare(String? value) =>
      RealmObjectBase.set(this, 'subThoroughfare', value);

  @override
  String? get name => RealmObjectBase.get<String>(this, 'name') as String?;
  @override
  set name(String? value) => RealmObjectBase.set(this, 'name', value);

  @override
  String? get street => RealmObjectBase.get<String>(this, 'street') as String?;
  @override
  set street(String? value) => RealmObjectBase.set(this, 'street', value);

  @override
  String? get country =>
      RealmObjectBase.get<String>(this, 'country') as String?;
  @override
  set country(String? value) => RealmObjectBase.set(this, 'country', value);

  @override
  String? get isoCountryCode =>
      RealmObjectBase.get<String>(this, 'isoCountryCode') as String?;
  @override
  set isoCountryCode(String? value) =>
      RealmObjectBase.set(this, 'isoCountryCode', value);

  @override
  String? get postalCode =>
      RealmObjectBase.get<String>(this, 'postalCode') as String?;
  @override
  set postalCode(String? value) =>
      RealmObjectBase.set(this, 'postalCode', value);

  @override
  Stream<RealmObjectChanges<PlaceMark>> get changes =>
      RealmObjectBase.getChanges<PlaceMark>(this);

  @override
  PlaceMark freeze() => RealmObjectBase.freezeObject<PlaceMark>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(PlaceMark._);
    return const SchemaObject(ObjectType.realmObject, PlaceMark, 'PlaceMark', [
      SchemaProperty('administrativeArea', RealmPropertyType.string,
          optional: true),
      SchemaProperty('subAdministrativeArea', RealmPropertyType.string,
          optional: true),
      SchemaProperty('locality', RealmPropertyType.string, optional: true),
      SchemaProperty('subLocality', RealmPropertyType.string, optional: true),
      SchemaProperty('thoroughfare', RealmPropertyType.string, optional: true),
      SchemaProperty('subThoroughfare', RealmPropertyType.string,
          optional: true),
      SchemaProperty('name', RealmPropertyType.string, optional: true),
      SchemaProperty('street', RealmPropertyType.string, optional: true),
      SchemaProperty('country', RealmPropertyType.string, optional: true),
      SchemaProperty('isoCountryCode', RealmPropertyType.string,
          optional: true),
      SchemaProperty('postalCode', RealmPropertyType.string, optional: true),
    ]);
  }
}

class ProjectPolygon extends _ProjectPolygon
    with RealmEntity, RealmObjectBase, RealmObject {
  ProjectPolygon({
    String? projectName,
    String? projectId,
    String? caption,
    String? created,
    String? projectPolygonId,
    String? organizationId,
    String? organizationName,
    String? name,
    String? userId,
    String? userName,
    String? possibleAddress,
    String? translatedMessage,
    String? translatedTitle,
    Iterable<Position> positions = const [],
    Iterable<City> nearestCities = const [],
  }) {
    RealmObjectBase.set(this, 'projectName', projectName);
    RealmObjectBase.set(this, 'projectId', projectId);
    RealmObjectBase.set(this, 'caption', caption);
    RealmObjectBase.set(this, 'created', created);
    RealmObjectBase.set(this, 'projectPolygonId', projectPolygonId);
    RealmObjectBase.set(this, 'organizationId', organizationId);
    RealmObjectBase.set(this, 'organizationName', organizationName);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'userName', userName);
    RealmObjectBase.set(this, 'possibleAddress', possibleAddress);
    RealmObjectBase.set(this, 'translatedMessage', translatedMessage);
    RealmObjectBase.set(this, 'translatedTitle', translatedTitle);
    RealmObjectBase.set<RealmList<Position>>(
        this, 'positions', RealmList<Position>(positions));
    RealmObjectBase.set<RealmList<City>>(
        this, 'nearestCities', RealmList<City>(nearestCities));
  }

  ProjectPolygon._();

  @override
  String? get projectName =>
      RealmObjectBase.get<String>(this, 'projectName') as String?;
  @override
  set projectName(String? value) =>
      RealmObjectBase.set(this, 'projectName', value);

  @override
  String? get projectId =>
      RealmObjectBase.get<String>(this, 'projectId') as String?;
  @override
  set projectId(String? value) => RealmObjectBase.set(this, 'projectId', value);

  @override
  String? get caption =>
      RealmObjectBase.get<String>(this, 'caption') as String?;
  @override
  set caption(String? value) => RealmObjectBase.set(this, 'caption', value);

  @override
  String? get created =>
      RealmObjectBase.get<String>(this, 'created') as String?;
  @override
  set created(String? value) => RealmObjectBase.set(this, 'created', value);

  @override
  String? get projectPolygonId =>
      RealmObjectBase.get<String>(this, 'projectPolygonId') as String?;
  @override
  set projectPolygonId(String? value) =>
      RealmObjectBase.set(this, 'projectPolygonId', value);

  @override
  String? get organizationId =>
      RealmObjectBase.get<String>(this, 'organizationId') as String?;
  @override
  set organizationId(String? value) =>
      RealmObjectBase.set(this, 'organizationId', value);

  @override
  String? get organizationName =>
      RealmObjectBase.get<String>(this, 'organizationName') as String?;
  @override
  set organizationName(String? value) =>
      RealmObjectBase.set(this, 'organizationName', value);

  @override
  RealmList<Position> get positions =>
      RealmObjectBase.get<Position>(this, 'positions') as RealmList<Position>;
  @override
  set positions(covariant RealmList<Position> value) =>
      throw RealmUnsupportedSetError();

  @override
  RealmList<City> get nearestCities =>
      RealmObjectBase.get<City>(this, 'nearestCities') as RealmList<City>;
  @override
  set nearestCities(covariant RealmList<City> value) =>
      throw RealmUnsupportedSetError();

  @override
  String? get name => RealmObjectBase.get<String>(this, 'name') as String?;
  @override
  set name(String? value) => RealmObjectBase.set(this, 'name', value);

  @override
  String? get userId => RealmObjectBase.get<String>(this, 'userId') as String?;
  @override
  set userId(String? value) => RealmObjectBase.set(this, 'userId', value);

  @override
  String? get userName =>
      RealmObjectBase.get<String>(this, 'userName') as String?;
  @override
  set userName(String? value) => RealmObjectBase.set(this, 'userName', value);

  @override
  String? get possibleAddress =>
      RealmObjectBase.get<String>(this, 'possibleAddress') as String?;
  @override
  set possibleAddress(String? value) =>
      RealmObjectBase.set(this, 'possibleAddress', value);

  @override
  String? get translatedMessage =>
      RealmObjectBase.get<String>(this, 'translatedMessage') as String?;
  @override
  set translatedMessage(String? value) =>
      RealmObjectBase.set(this, 'translatedMessage', value);

  @override
  String? get translatedTitle =>
      RealmObjectBase.get<String>(this, 'translatedTitle') as String?;
  @override
  set translatedTitle(String? value) =>
      RealmObjectBase.set(this, 'translatedTitle', value);

  @override
  Stream<RealmObjectChanges<ProjectPolygon>> get changes =>
      RealmObjectBase.getChanges<ProjectPolygon>(this);

  @override
  ProjectPolygon freeze() => RealmObjectBase.freezeObject<ProjectPolygon>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ProjectPolygon._);
    return const SchemaObject(
        ObjectType.realmObject, ProjectPolygon, 'ProjectPolygon', [
      SchemaProperty('projectName', RealmPropertyType.string, optional: true),
      SchemaProperty('projectId', RealmPropertyType.string, optional: true),
      SchemaProperty('caption', RealmPropertyType.string, optional: true),
      SchemaProperty('created', RealmPropertyType.string, optional: true),
      SchemaProperty('projectPolygonId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('organizationName', RealmPropertyType.string,
          optional: true),
      SchemaProperty('positions', RealmPropertyType.object,
          linkTarget: 'Position', collectionType: RealmCollectionType.list),
      SchemaProperty('nearestCities', RealmPropertyType.object,
          linkTarget: 'City', collectionType: RealmCollectionType.list),
      SchemaProperty('name', RealmPropertyType.string, optional: true),
      SchemaProperty('userId', RealmPropertyType.string, optional: true),
      SchemaProperty('userName', RealmPropertyType.string, optional: true),
      SchemaProperty('possibleAddress', RealmPropertyType.string,
          optional: true),
      SchemaProperty('translatedMessage', RealmPropertyType.string,
          optional: true),
      SchemaProperty('translatedTitle', RealmPropertyType.string,
          optional: true),
    ]);
  }
}

class Rating extends _Rating with RealmEntity, RealmObjectBase, RealmObject {
  Rating({
    String? remarks,
    String? created,
    String? audioId,
    String? photoId,
    String? userId,
    String? userName,
    String? organizationId,
    int? ratingCode,
    String? projectId,
    String? projectName,
    String? videoId,
    String? ratingId,
    Position? position,
  }) {
    RealmObjectBase.set(this, 'remarks', remarks);
    RealmObjectBase.set(this, 'created', created);
    RealmObjectBase.set(this, 'audioId', audioId);
    RealmObjectBase.set(this, 'photoId', photoId);
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'userName', userName);
    RealmObjectBase.set(this, 'organizationId', organizationId);
    RealmObjectBase.set(this, 'ratingCode', ratingCode);
    RealmObjectBase.set(this, 'projectId', projectId);
    RealmObjectBase.set(this, 'projectName', projectName);
    RealmObjectBase.set(this, 'videoId', videoId);
    RealmObjectBase.set(this, 'ratingId', ratingId);
    RealmObjectBase.set(this, 'position', position);
  }

  Rating._();

  @override
  String? get remarks =>
      RealmObjectBase.get<String>(this, 'remarks') as String?;
  @override
  set remarks(String? value) => RealmObjectBase.set(this, 'remarks', value);

  @override
  String? get created =>
      RealmObjectBase.get<String>(this, 'created') as String?;
  @override
  set created(String? value) => RealmObjectBase.set(this, 'created', value);

  @override
  String? get audioId =>
      RealmObjectBase.get<String>(this, 'audioId') as String?;
  @override
  set audioId(String? value) => RealmObjectBase.set(this, 'audioId', value);

  @override
  String? get photoId =>
      RealmObjectBase.get<String>(this, 'photoId') as String?;
  @override
  set photoId(String? value) => RealmObjectBase.set(this, 'photoId', value);

  @override
  String? get userId => RealmObjectBase.get<String>(this, 'userId') as String?;
  @override
  set userId(String? value) => RealmObjectBase.set(this, 'userId', value);

  @override
  String? get userName =>
      RealmObjectBase.get<String>(this, 'userName') as String?;
  @override
  set userName(String? value) => RealmObjectBase.set(this, 'userName', value);

  @override
  String? get organizationId =>
      RealmObjectBase.get<String>(this, 'organizationId') as String?;
  @override
  set organizationId(String? value) =>
      RealmObjectBase.set(this, 'organizationId', value);

  @override
  int? get ratingCode => RealmObjectBase.get<int>(this, 'ratingCode') as int?;
  @override
  set ratingCode(int? value) => RealmObjectBase.set(this, 'ratingCode', value);

  @override
  String? get projectId =>
      RealmObjectBase.get<String>(this, 'projectId') as String?;
  @override
  set projectId(String? value) => RealmObjectBase.set(this, 'projectId', value);

  @override
  String? get projectName =>
      RealmObjectBase.get<String>(this, 'projectName') as String?;
  @override
  set projectName(String? value) =>
      RealmObjectBase.set(this, 'projectName', value);

  @override
  String? get videoId =>
      RealmObjectBase.get<String>(this, 'videoId') as String?;
  @override
  set videoId(String? value) => RealmObjectBase.set(this, 'videoId', value);

  @override
  String? get ratingId =>
      RealmObjectBase.get<String>(this, 'ratingId') as String?;
  @override
  set ratingId(String? value) => RealmObjectBase.set(this, 'ratingId', value);

  @override
  Position? get position =>
      RealmObjectBase.get<Position>(this, 'position') as Position?;
  @override
  set position(covariant Position? value) =>
      RealmObjectBase.set(this, 'position', value);

  @override
  Stream<RealmObjectChanges<Rating>> get changes =>
      RealmObjectBase.getChanges<Rating>(this);

  @override
  Rating freeze() => RealmObjectBase.freezeObject<Rating>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Rating._);
    return const SchemaObject(ObjectType.realmObject, Rating, 'Rating', [
      SchemaProperty('remarks', RealmPropertyType.string, optional: true),
      SchemaProperty('created', RealmPropertyType.string, optional: true),
      SchemaProperty('audioId', RealmPropertyType.string, optional: true),
      SchemaProperty('photoId', RealmPropertyType.string, optional: true),
      SchemaProperty('userId', RealmPropertyType.string, optional: true),
      SchemaProperty('userName', RealmPropertyType.string, optional: true),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('ratingCode', RealmPropertyType.int, optional: true),
      SchemaProperty('projectId', RealmPropertyType.string, optional: true),
      SchemaProperty('projectName', RealmPropertyType.string, optional: true),
      SchemaProperty('videoId', RealmPropertyType.string, optional: true),
      SchemaProperty('ratingId', RealmPropertyType.string, optional: true),
      SchemaProperty('position', RealmPropertyType.object,
          optional: true, linkTarget: 'Position'),
    ]);
  }
}

class SettingsModel extends _SettingsModel
    with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  SettingsModel({
    int? distanceFromProject,
    int? photoSize,
    int? maxVideoLengthInSeconds,
    int? maxAudioLengthInMinutes,
    int? themeIndex,
    String? settingsId,
    String? created,
    String? organizationId,
    String? organizationName,
    String? projectId,
    int? activityStreamHours,
    int? numberOfDays,
    String? locale = "en",
    String? translatedMessage,
    String? translatedTitle,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<SettingsModel>({
        'locale': "en",
      });
    }
    RealmObjectBase.set(this, 'distanceFromProject', distanceFromProject);
    RealmObjectBase.set(this, 'photoSize', photoSize);
    RealmObjectBase.set(
        this, 'maxVideoLengthInSeconds', maxVideoLengthInSeconds);
    RealmObjectBase.set(
        this, 'maxAudioLengthInMinutes', maxAudioLengthInMinutes);
    RealmObjectBase.set(this, 'themeIndex', themeIndex);
    RealmObjectBase.set(this, 'settingsId', settingsId);
    RealmObjectBase.set(this, 'created', created);
    RealmObjectBase.set(this, 'organizationId', organizationId);
    RealmObjectBase.set(this, 'organizationName', organizationName);
    RealmObjectBase.set(this, 'projectId', projectId);
    RealmObjectBase.set(this, 'activityStreamHours', activityStreamHours);
    RealmObjectBase.set(this, 'numberOfDays', numberOfDays);
    RealmObjectBase.set(this, 'locale', locale);
    RealmObjectBase.set(this, 'translatedMessage', translatedMessage);
    RealmObjectBase.set(this, 'translatedTitle', translatedTitle);
  }

  SettingsModel._();

  @override
  int? get distanceFromProject =>
      RealmObjectBase.get<int>(this, 'distanceFromProject') as int?;
  @override
  set distanceFromProject(int? value) =>
      RealmObjectBase.set(this, 'distanceFromProject', value);

  @override
  int? get photoSize => RealmObjectBase.get<int>(this, 'photoSize') as int?;
  @override
  set photoSize(int? value) => RealmObjectBase.set(this, 'photoSize', value);

  @override
  int? get maxVideoLengthInSeconds =>
      RealmObjectBase.get<int>(this, 'maxVideoLengthInSeconds') as int?;
  @override
  set maxVideoLengthInSeconds(int? value) =>
      RealmObjectBase.set(this, 'maxVideoLengthInSeconds', value);

  @override
  int? get maxAudioLengthInMinutes =>
      RealmObjectBase.get<int>(this, 'maxAudioLengthInMinutes') as int?;
  @override
  set maxAudioLengthInMinutes(int? value) =>
      RealmObjectBase.set(this, 'maxAudioLengthInMinutes', value);

  @override
  int? get themeIndex => RealmObjectBase.get<int>(this, 'themeIndex') as int?;
  @override
  set themeIndex(int? value) => RealmObjectBase.set(this, 'themeIndex', value);

  @override
  String? get settingsId =>
      RealmObjectBase.get<String>(this, 'settingsId') as String?;
  @override
  set settingsId(String? value) =>
      RealmObjectBase.set(this, 'settingsId', value);

  @override
  String? get created =>
      RealmObjectBase.get<String>(this, 'created') as String?;
  @override
  set created(String? value) => RealmObjectBase.set(this, 'created', value);

  @override
  String? get organizationId =>
      RealmObjectBase.get<String>(this, 'organizationId') as String?;
  @override
  set organizationId(String? value) =>
      RealmObjectBase.set(this, 'organizationId', value);

  @override
  String? get organizationName =>
      RealmObjectBase.get<String>(this, 'organizationName') as String?;
  @override
  set organizationName(String? value) =>
      RealmObjectBase.set(this, 'organizationName', value);

  @override
  String? get projectId =>
      RealmObjectBase.get<String>(this, 'projectId') as String?;
  @override
  set projectId(String? value) => RealmObjectBase.set(this, 'projectId', value);

  @override
  int? get activityStreamHours =>
      RealmObjectBase.get<int>(this, 'activityStreamHours') as int?;
  @override
  set activityStreamHours(int? value) =>
      RealmObjectBase.set(this, 'activityStreamHours', value);

  @override
  int? get numberOfDays =>
      RealmObjectBase.get<int>(this, 'numberOfDays') as int?;
  @override
  set numberOfDays(int? value) =>
      RealmObjectBase.set(this, 'numberOfDays', value);

  @override
  String? get locale => RealmObjectBase.get<String>(this, 'locale') as String?;
  @override
  set locale(String? value) => RealmObjectBase.set(this, 'locale', value);

  @override
  String? get translatedMessage =>
      RealmObjectBase.get<String>(this, 'translatedMessage') as String?;
  @override
  set translatedMessage(String? value) =>
      RealmObjectBase.set(this, 'translatedMessage', value);

  @override
  String? get translatedTitle =>
      RealmObjectBase.get<String>(this, 'translatedTitle') as String?;
  @override
  set translatedTitle(String? value) =>
      RealmObjectBase.set(this, 'translatedTitle', value);

  @override
  Stream<RealmObjectChanges<SettingsModel>> get changes =>
      RealmObjectBase.getChanges<SettingsModel>(this);

  @override
  SettingsModel freeze() => RealmObjectBase.freezeObject<SettingsModel>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(SettingsModel._);
    return const SchemaObject(
        ObjectType.realmObject, SettingsModel, 'SettingsModel', [
      SchemaProperty('distanceFromProject', RealmPropertyType.int,
          optional: true),
      SchemaProperty('photoSize', RealmPropertyType.int, optional: true),
      SchemaProperty('maxVideoLengthInSeconds', RealmPropertyType.int,
          optional: true),
      SchemaProperty('maxAudioLengthInMinutes', RealmPropertyType.int,
          optional: true),
      SchemaProperty('themeIndex', RealmPropertyType.int, optional: true),
      SchemaProperty('settingsId', RealmPropertyType.string, optional: true),
      SchemaProperty('created', RealmPropertyType.string, optional: true),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('organizationName', RealmPropertyType.string,
          optional: true),
      SchemaProperty('projectId', RealmPropertyType.string, optional: true),
      SchemaProperty('activityStreamHours', RealmPropertyType.int,
          optional: true),
      SchemaProperty('numberOfDays', RealmPropertyType.int, optional: true),
      SchemaProperty('locale', RealmPropertyType.string, optional: true),
      SchemaProperty('translatedMessage', RealmPropertyType.string,
          optional: true),
      SchemaProperty('translatedTitle', RealmPropertyType.string,
          optional: true),
    ]);
  }
}

class DataCounts extends _DataCounts
    with RealmEntity, RealmObjectBase, RealmObject {
  DataCounts({
    String? projectId,
    int? projects,
    int? users,
    String? created,
    String? photos,
    String? userId,
    String? organizationId,
    int? videos,
    int? audios,
    int? projectPositions,
    int? projectPolygons,
    int? fieldMonitorSchedules,
    int? activities,
  }) {
    RealmObjectBase.set(this, 'projectId', projectId);
    RealmObjectBase.set(this, 'projects', projects);
    RealmObjectBase.set(this, 'users', users);
    RealmObjectBase.set(this, 'created', created);
    RealmObjectBase.set(this, 'photos', photos);
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'organizationId', organizationId);
    RealmObjectBase.set(this, 'videos', videos);
    RealmObjectBase.set(this, 'audios', audios);
    RealmObjectBase.set(this, 'projectPositions', projectPositions);
    RealmObjectBase.set(this, 'projectPolygons', projectPolygons);
    RealmObjectBase.set(this, 'fieldMonitorSchedules', fieldMonitorSchedules);
    RealmObjectBase.set(this, 'activities', activities);
  }

  DataCounts._();

  @override
  String? get projectId =>
      RealmObjectBase.get<String>(this, 'projectId') as String?;
  @override
  set projectId(String? value) => RealmObjectBase.set(this, 'projectId', value);

  @override
  int? get projects => RealmObjectBase.get<int>(this, 'projects') as int?;
  @override
  set projects(int? value) => RealmObjectBase.set(this, 'projects', value);

  @override
  int? get users => RealmObjectBase.get<int>(this, 'users') as int?;
  @override
  set users(int? value) => RealmObjectBase.set(this, 'users', value);

  @override
  String? get created =>
      RealmObjectBase.get<String>(this, 'created') as String?;
  @override
  set created(String? value) => RealmObjectBase.set(this, 'created', value);

  @override
  String? get photos => RealmObjectBase.get<String>(this, 'photos') as String?;
  @override
  set photos(String? value) => RealmObjectBase.set(this, 'photos', value);

  @override
  String? get userId => RealmObjectBase.get<String>(this, 'userId') as String?;
  @override
  set userId(String? value) => RealmObjectBase.set(this, 'userId', value);

  @override
  String? get organizationId =>
      RealmObjectBase.get<String>(this, 'organizationId') as String?;
  @override
  set organizationId(String? value) =>
      RealmObjectBase.set(this, 'organizationId', value);

  @override
  int? get videos => RealmObjectBase.get<int>(this, 'videos') as int?;
  @override
  set videos(int? value) => RealmObjectBase.set(this, 'videos', value);

  @override
  int? get audios => RealmObjectBase.get<int>(this, 'audios') as int?;
  @override
  set audios(int? value) => RealmObjectBase.set(this, 'audios', value);

  @override
  int? get projectPositions =>
      RealmObjectBase.get<int>(this, 'projectPositions') as int?;
  @override
  set projectPositions(int? value) =>
      RealmObjectBase.set(this, 'projectPositions', value);

  @override
  int? get projectPolygons =>
      RealmObjectBase.get<int>(this, 'projectPolygons') as int?;
  @override
  set projectPolygons(int? value) =>
      RealmObjectBase.set(this, 'projectPolygons', value);

  @override
  int? get fieldMonitorSchedules =>
      RealmObjectBase.get<int>(this, 'fieldMonitorSchedules') as int?;
  @override
  set fieldMonitorSchedules(int? value) =>
      RealmObjectBase.set(this, 'fieldMonitorSchedules', value);

  @override
  int? get activities => RealmObjectBase.get<int>(this, 'activities') as int?;
  @override
  set activities(int? value) => RealmObjectBase.set(this, 'activities', value);

  @override
  Stream<RealmObjectChanges<DataCounts>> get changes =>
      RealmObjectBase.getChanges<DataCounts>(this);

  @override
  DataCounts freeze() => RealmObjectBase.freezeObject<DataCounts>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(DataCounts._);
    return const SchemaObject(
        ObjectType.realmObject, DataCounts, 'DataCounts', [
      SchemaProperty('projectId', RealmPropertyType.string, optional: true),
      SchemaProperty('projects', RealmPropertyType.int, optional: true),
      SchemaProperty('users', RealmPropertyType.int, optional: true),
      SchemaProperty('created', RealmPropertyType.string, optional: true),
      SchemaProperty('photos', RealmPropertyType.string, optional: true),
      SchemaProperty('userId', RealmPropertyType.string, optional: true),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('videos', RealmPropertyType.int, optional: true),
      SchemaProperty('audios', RealmPropertyType.int, optional: true),
      SchemaProperty('projectPositions', RealmPropertyType.int, optional: true),
      SchemaProperty('projectPolygons', RealmPropertyType.int, optional: true),
      SchemaProperty('fieldMonitorSchedules', RealmPropertyType.int,
          optional: true),
      SchemaProperty('activities', RealmPropertyType.int, optional: true),
    ]);
  }
}

class GeofenceEvent extends _GeofenceEvent
    with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  GeofenceEvent({
    String? status,
    String? geofenceEventId,
    String? date,
    String? projectPositionId,
    String? projectName,
    User? user,
    String? organizationId,
    Position? position,
    String? projectId,
    String? locale = "en",
    String? translatedMessage,
    String? translatedTitle,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<GeofenceEvent>({
        'locale': "en",
      });
    }
    RealmObjectBase.set(this, 'status', status);
    RealmObjectBase.set(this, 'geofenceEventId', geofenceEventId);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'projectPositionId', projectPositionId);
    RealmObjectBase.set(this, 'projectName', projectName);
    RealmObjectBase.set(this, 'user', user);
    RealmObjectBase.set(this, 'organizationId', organizationId);
    RealmObjectBase.set(this, 'position', position);
    RealmObjectBase.set(this, 'projectId', projectId);
    RealmObjectBase.set(this, 'locale', locale);
    RealmObjectBase.set(this, 'translatedMessage', translatedMessage);
    RealmObjectBase.set(this, 'translatedTitle', translatedTitle);
  }

  GeofenceEvent._();

  @override
  String? get status => RealmObjectBase.get<String>(this, 'status') as String?;
  @override
  set status(String? value) => RealmObjectBase.set(this, 'status', value);

  @override
  String? get geofenceEventId =>
      RealmObjectBase.get<String>(this, 'geofenceEventId') as String?;
  @override
  set geofenceEventId(String? value) =>
      RealmObjectBase.set(this, 'geofenceEventId', value);

  @override
  String? get date => RealmObjectBase.get<String>(this, 'date') as String?;
  @override
  set date(String? value) => RealmObjectBase.set(this, 'date', value);

  @override
  String? get projectPositionId =>
      RealmObjectBase.get<String>(this, 'projectPositionId') as String?;
  @override
  set projectPositionId(String? value) =>
      RealmObjectBase.set(this, 'projectPositionId', value);

  @override
  String? get projectName =>
      RealmObjectBase.get<String>(this, 'projectName') as String?;
  @override
  set projectName(String? value) =>
      RealmObjectBase.set(this, 'projectName', value);

  @override
  User? get user => RealmObjectBase.get<User>(this, 'user') as User?;
  @override
  set user(covariant User? value) => RealmObjectBase.set(this, 'user', value);

  @override
  String? get organizationId =>
      RealmObjectBase.get<String>(this, 'organizationId') as String?;
  @override
  set organizationId(String? value) =>
      RealmObjectBase.set(this, 'organizationId', value);

  @override
  Position? get position =>
      RealmObjectBase.get<Position>(this, 'position') as Position?;
  @override
  set position(covariant Position? value) =>
      RealmObjectBase.set(this, 'position', value);

  @override
  String? get projectId =>
      RealmObjectBase.get<String>(this, 'projectId') as String?;
  @override
  set projectId(String? value) => RealmObjectBase.set(this, 'projectId', value);

  @override
  String? get locale => RealmObjectBase.get<String>(this, 'locale') as String?;
  @override
  set locale(String? value) => RealmObjectBase.set(this, 'locale', value);

  @override
  String? get translatedMessage =>
      RealmObjectBase.get<String>(this, 'translatedMessage') as String?;
  @override
  set translatedMessage(String? value) =>
      RealmObjectBase.set(this, 'translatedMessage', value);

  @override
  String? get translatedTitle =>
      RealmObjectBase.get<String>(this, 'translatedTitle') as String?;
  @override
  set translatedTitle(String? value) =>
      RealmObjectBase.set(this, 'translatedTitle', value);

  @override
  Stream<RealmObjectChanges<GeofenceEvent>> get changes =>
      RealmObjectBase.getChanges<GeofenceEvent>(this);

  @override
  GeofenceEvent freeze() => RealmObjectBase.freezeObject<GeofenceEvent>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(GeofenceEvent._);
    return const SchemaObject(
        ObjectType.realmObject, GeofenceEvent, 'GeofenceEvent', [
      SchemaProperty('status', RealmPropertyType.string, optional: true),
      SchemaProperty('geofenceEventId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('date', RealmPropertyType.string, optional: true),
      SchemaProperty('projectPositionId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('projectName', RealmPropertyType.string, optional: true),
      SchemaProperty('user', RealmPropertyType.object,
          optional: true, linkTarget: 'User'),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('position', RealmPropertyType.object,
          optional: true, linkTarget: 'Position'),
      SchemaProperty('projectId', RealmPropertyType.string, optional: true),
      SchemaProperty('locale', RealmPropertyType.string, optional: true),
      SchemaProperty('translatedMessage', RealmPropertyType.string,
          optional: true),
      SchemaProperty('translatedTitle', RealmPropertyType.string,
          optional: true),
    ]);
  }
}

class User extends _User with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  User({
    String? name,
    String? userId,
    String? email,
    String? gender,
    String? cellphone,
    String? created,
    String? userType,
    String? organizationName,
    String? fcmRegistration,
    String? countryId,
    String? organizationId,
    Position? position,
    String? password,
    String? updated,
    int? active = 0,
    String? imageUrl,
    String? thumbnailUrl,
    String? locale = "en",
    String? translatedMessage,
    String? translatedTitle,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<User>({
        'active': 0,
        'locale': "en",
      });
    }
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'email', email);
    RealmObjectBase.set(this, 'gender', gender);
    RealmObjectBase.set(this, 'cellphone', cellphone);
    RealmObjectBase.set(this, 'created', created);
    RealmObjectBase.set(this, 'userType', userType);
    RealmObjectBase.set(this, 'organizationName', organizationName);
    RealmObjectBase.set(this, 'fcmRegistration', fcmRegistration);
    RealmObjectBase.set(this, 'countryId', countryId);
    RealmObjectBase.set(this, 'organizationId', organizationId);
    RealmObjectBase.set(this, 'position', position);
    RealmObjectBase.set(this, 'password', password);
    RealmObjectBase.set(this, 'updated', updated);
    RealmObjectBase.set(this, 'active', active);
    RealmObjectBase.set(this, 'imageUrl', imageUrl);
    RealmObjectBase.set(this, 'thumbnailUrl', thumbnailUrl);
    RealmObjectBase.set(this, 'locale', locale);
    RealmObjectBase.set(this, 'translatedMessage', translatedMessage);
    RealmObjectBase.set(this, 'translatedTitle', translatedTitle);
  }

  User._();

  @override
  String? get name => RealmObjectBase.get<String>(this, 'name') as String?;
  @override
  set name(String? value) => RealmObjectBase.set(this, 'name', value);

  @override
  String? get userId => RealmObjectBase.get<String>(this, 'userId') as String?;
  @override
  set userId(String? value) => RealmObjectBase.set(this, 'userId', value);

  @override
  String? get email => RealmObjectBase.get<String>(this, 'email') as String?;
  @override
  set email(String? value) => RealmObjectBase.set(this, 'email', value);

  @override
  String? get gender => RealmObjectBase.get<String>(this, 'gender') as String?;
  @override
  set gender(String? value) => RealmObjectBase.set(this, 'gender', value);

  @override
  String? get cellphone =>
      RealmObjectBase.get<String>(this, 'cellphone') as String?;
  @override
  set cellphone(String? value) => RealmObjectBase.set(this, 'cellphone', value);

  @override
  String? get created =>
      RealmObjectBase.get<String>(this, 'created') as String?;
  @override
  set created(String? value) => RealmObjectBase.set(this, 'created', value);

  @override
  String? get userType =>
      RealmObjectBase.get<String>(this, 'userType') as String?;
  @override
  set userType(String? value) => RealmObjectBase.set(this, 'userType', value);

  @override
  String? get organizationName =>
      RealmObjectBase.get<String>(this, 'organizationName') as String?;
  @override
  set organizationName(String? value) =>
      RealmObjectBase.set(this, 'organizationName', value);

  @override
  String? get fcmRegistration =>
      RealmObjectBase.get<String>(this, 'fcmRegistration') as String?;
  @override
  set fcmRegistration(String? value) =>
      RealmObjectBase.set(this, 'fcmRegistration', value);

  @override
  String? get countryId =>
      RealmObjectBase.get<String>(this, 'countryId') as String?;
  @override
  set countryId(String? value) => RealmObjectBase.set(this, 'countryId', value);

  @override
  String? get organizationId =>
      RealmObjectBase.get<String>(this, 'organizationId') as String?;
  @override
  set organizationId(String? value) =>
      RealmObjectBase.set(this, 'organizationId', value);

  @override
  Position? get position =>
      RealmObjectBase.get<Position>(this, 'position') as Position?;
  @override
  set position(covariant Position? value) =>
      RealmObjectBase.set(this, 'position', value);

  @override
  String? get password =>
      RealmObjectBase.get<String>(this, 'password') as String?;
  @override
  set password(String? value) => RealmObjectBase.set(this, 'password', value);

  @override
  String? get updated =>
      RealmObjectBase.get<String>(this, 'updated') as String?;
  @override
  set updated(String? value) => RealmObjectBase.set(this, 'updated', value);

  @override
  int? get active => RealmObjectBase.get<int>(this, 'active') as int?;
  @override
  set active(int? value) => RealmObjectBase.set(this, 'active', value);

  @override
  String? get imageUrl =>
      RealmObjectBase.get<String>(this, 'imageUrl') as String?;
  @override
  set imageUrl(String? value) => RealmObjectBase.set(this, 'imageUrl', value);

  @override
  String? get thumbnailUrl =>
      RealmObjectBase.get<String>(this, 'thumbnailUrl') as String?;
  @override
  set thumbnailUrl(String? value) =>
      RealmObjectBase.set(this, 'thumbnailUrl', value);

  @override
  String? get locale => RealmObjectBase.get<String>(this, 'locale') as String?;
  @override
  set locale(String? value) => RealmObjectBase.set(this, 'locale', value);

  @override
  String? get translatedMessage =>
      RealmObjectBase.get<String>(this, 'translatedMessage') as String?;
  @override
  set translatedMessage(String? value) =>
      RealmObjectBase.set(this, 'translatedMessage', value);

  @override
  String? get translatedTitle =>
      RealmObjectBase.get<String>(this, 'translatedTitle') as String?;
  @override
  set translatedTitle(String? value) =>
      RealmObjectBase.set(this, 'translatedTitle', value);

  @override
  Stream<RealmObjectChanges<User>> get changes =>
      RealmObjectBase.getChanges<User>(this);

  @override
  User freeze() => RealmObjectBase.freezeObject<User>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(User._);
    return const SchemaObject(ObjectType.realmObject, User, 'User', [
      SchemaProperty('name', RealmPropertyType.string, optional: true),
      SchemaProperty('userId', RealmPropertyType.string, optional: true),
      SchemaProperty('email', RealmPropertyType.string, optional: true),
      SchemaProperty('gender', RealmPropertyType.string, optional: true),
      SchemaProperty('cellphone', RealmPropertyType.string, optional: true),
      SchemaProperty('created', RealmPropertyType.string, optional: true),
      SchemaProperty('userType', RealmPropertyType.string, optional: true),
      SchemaProperty('organizationName', RealmPropertyType.string,
          optional: true),
      SchemaProperty('fcmRegistration', RealmPropertyType.string,
          optional: true),
      SchemaProperty('countryId', RealmPropertyType.string, optional: true),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('position', RealmPropertyType.object,
          optional: true, linkTarget: 'Position'),
      SchemaProperty('password', RealmPropertyType.string, optional: true),
      SchemaProperty('updated', RealmPropertyType.string, optional: true),
      SchemaProperty('active', RealmPropertyType.int, optional: true),
      SchemaProperty('imageUrl', RealmPropertyType.string, optional: true),
      SchemaProperty('thumbnailUrl', RealmPropertyType.string, optional: true),
      SchemaProperty('locale', RealmPropertyType.string, optional: true),
      SchemaProperty('translatedMessage', RealmPropertyType.string,
          optional: true),
      SchemaProperty('translatedTitle', RealmPropertyType.string,
          optional: true),
    ]);
  }
}

class GioSubscription extends _GioSubscription
    with RealmEntity, RealmObjectBase, RealmObject {
  GioSubscription({
    String? subscriptionId,
    String? date,
    User? user,
    String? organizationId,
    String? organizationName,
    String? updated,
    int? intDate,
    int? intUpdated,
    int? subscriptionType,
    int? active,
  }) {
    RealmObjectBase.set(this, 'subscriptionId', subscriptionId);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'user', user);
    RealmObjectBase.set(this, 'organizationId', organizationId);
    RealmObjectBase.set(this, 'organizationName', organizationName);
    RealmObjectBase.set(this, 'updated', updated);
    RealmObjectBase.set(this, 'intDate', intDate);
    RealmObjectBase.set(this, 'intUpdated', intUpdated);
    RealmObjectBase.set(this, 'subscriptionType', subscriptionType);
    RealmObjectBase.set(this, 'active', active);
  }

  GioSubscription._();

  @override
  String? get subscriptionId =>
      RealmObjectBase.get<String>(this, 'subscriptionId') as String?;
  @override
  set subscriptionId(String? value) =>
      RealmObjectBase.set(this, 'subscriptionId', value);

  @override
  String? get date => RealmObjectBase.get<String>(this, 'date') as String?;
  @override
  set date(String? value) => RealmObjectBase.set(this, 'date', value);

  @override
  User? get user => RealmObjectBase.get<User>(this, 'user') as User?;
  @override
  set user(covariant User? value) => RealmObjectBase.set(this, 'user', value);

  @override
  String? get organizationId =>
      RealmObjectBase.get<String>(this, 'organizationId') as String?;
  @override
  set organizationId(String? value) =>
      RealmObjectBase.set(this, 'organizationId', value);

  @override
  String? get organizationName =>
      RealmObjectBase.get<String>(this, 'organizationName') as String?;
  @override
  set organizationName(String? value) =>
      RealmObjectBase.set(this, 'organizationName', value);

  @override
  String? get updated =>
      RealmObjectBase.get<String>(this, 'updated') as String?;
  @override
  set updated(String? value) => RealmObjectBase.set(this, 'updated', value);

  @override
  int? get intDate => RealmObjectBase.get<int>(this, 'intDate') as int?;
  @override
  set intDate(int? value) => RealmObjectBase.set(this, 'intDate', value);

  @override
  int? get intUpdated => RealmObjectBase.get<int>(this, 'intUpdated') as int?;
  @override
  set intUpdated(int? value) => RealmObjectBase.set(this, 'intUpdated', value);

  @override
  int? get subscriptionType =>
      RealmObjectBase.get<int>(this, 'subscriptionType') as int?;
  @override
  set subscriptionType(int? value) =>
      RealmObjectBase.set(this, 'subscriptionType', value);

  @override
  int? get active => RealmObjectBase.get<int>(this, 'active') as int?;
  @override
  set active(int? value) => RealmObjectBase.set(this, 'active', value);

  @override
  Stream<RealmObjectChanges<GioSubscription>> get changes =>
      RealmObjectBase.getChanges<GioSubscription>(this);

  @override
  GioSubscription freeze() =>
      RealmObjectBase.freezeObject<GioSubscription>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(GioSubscription._);
    return const SchemaObject(
        ObjectType.realmObject, GioSubscription, 'GioSubscription', [
      SchemaProperty('subscriptionId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('date', RealmPropertyType.string, optional: true),
      SchemaProperty('user', RealmPropertyType.object,
          optional: true, linkTarget: 'User'),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('organizationName', RealmPropertyType.string,
          optional: true),
      SchemaProperty('updated', RealmPropertyType.string, optional: true),
      SchemaProperty('intDate', RealmPropertyType.int, optional: true),
      SchemaProperty('intUpdated', RealmPropertyType.int, optional: true),
      SchemaProperty('subscriptionType', RealmPropertyType.int, optional: true),
      SchemaProperty('active', RealmPropertyType.int, optional: true),
    ]);
  }
}

class Pricing extends _Pricing with RealmEntity, RealmObjectBase, RealmObject {
  Pricing({
    String? countryId,
    String? date,
    String? countryName,
    double? monthlyPrice,
    double? annualPrice,
  }) {
    RealmObjectBase.set(this, 'countryId', countryId);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'countryName', countryName);
    RealmObjectBase.set(this, 'monthlyPrice', monthlyPrice);
    RealmObjectBase.set(this, 'annualPrice', annualPrice);
  }

  Pricing._();

  @override
  String? get countryId =>
      RealmObjectBase.get<String>(this, 'countryId') as String?;
  @override
  set countryId(String? value) => RealmObjectBase.set(this, 'countryId', value);

  @override
  String? get date => RealmObjectBase.get<String>(this, 'date') as String?;
  @override
  set date(String? value) => RealmObjectBase.set(this, 'date', value);

  @override
  String? get countryName =>
      RealmObjectBase.get<String>(this, 'countryName') as String?;
  @override
  set countryName(String? value) =>
      RealmObjectBase.set(this, 'countryName', value);

  @override
  double? get monthlyPrice =>
      RealmObjectBase.get<double>(this, 'monthlyPrice') as double?;
  @override
  set monthlyPrice(double? value) =>
      RealmObjectBase.set(this, 'monthlyPrice', value);

  @override
  double? get annualPrice =>
      RealmObjectBase.get<double>(this, 'annualPrice') as double?;
  @override
  set annualPrice(double? value) =>
      RealmObjectBase.set(this, 'annualPrice', value);

  @override
  Stream<RealmObjectChanges<Pricing>> get changes =>
      RealmObjectBase.getChanges<Pricing>(this);

  @override
  Pricing freeze() => RealmObjectBase.freezeObject<Pricing>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Pricing._);
    return const SchemaObject(ObjectType.realmObject, Pricing, 'Pricing', [
      SchemaProperty('countryId', RealmPropertyType.string, optional: true),
      SchemaProperty('date', RealmPropertyType.string, optional: true),
      SchemaProperty('countryName', RealmPropertyType.string, optional: true),
      SchemaProperty('monthlyPrice', RealmPropertyType.double, optional: true),
      SchemaProperty('annualPrice', RealmPropertyType.double, optional: true),
    ]);
  }
}

class OrgMessage extends _OrgMessage
    with RealmEntity, RealmObjectBase, RealmObject {
  OrgMessage({
    String? name,
    String? userId,
    String? message,
    String? created,
    String? organizationId,
    String? projectId,
    String? projectName,
    String? adminId,
    String? adminName,
    String? frequency,
    String? result,
    String? orgMessageId,
  }) {
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'message', message);
    RealmObjectBase.set(this, 'created', created);
    RealmObjectBase.set(this, 'organizationId', organizationId);
    RealmObjectBase.set(this, 'projectId', projectId);
    RealmObjectBase.set(this, 'projectName', projectName);
    RealmObjectBase.set(this, 'adminId', adminId);
    RealmObjectBase.set(this, 'adminName', adminName);
    RealmObjectBase.set(this, 'frequency', frequency);
    RealmObjectBase.set(this, 'result', result);
    RealmObjectBase.set(this, 'orgMessageId', orgMessageId);
  }

  OrgMessage._();

  @override
  String? get name => RealmObjectBase.get<String>(this, 'name') as String?;
  @override
  set name(String? value) => RealmObjectBase.set(this, 'name', value);

  @override
  String? get userId => RealmObjectBase.get<String>(this, 'userId') as String?;
  @override
  set userId(String? value) => RealmObjectBase.set(this, 'userId', value);

  @override
  String? get message =>
      RealmObjectBase.get<String>(this, 'message') as String?;
  @override
  set message(String? value) => RealmObjectBase.set(this, 'message', value);

  @override
  String? get created =>
      RealmObjectBase.get<String>(this, 'created') as String?;
  @override
  set created(String? value) => RealmObjectBase.set(this, 'created', value);

  @override
  String? get organizationId =>
      RealmObjectBase.get<String>(this, 'organizationId') as String?;
  @override
  set organizationId(String? value) =>
      RealmObjectBase.set(this, 'organizationId', value);

  @override
  String? get projectId =>
      RealmObjectBase.get<String>(this, 'projectId') as String?;
  @override
  set projectId(String? value) => RealmObjectBase.set(this, 'projectId', value);

  @override
  String? get projectName =>
      RealmObjectBase.get<String>(this, 'projectName') as String?;
  @override
  set projectName(String? value) =>
      RealmObjectBase.set(this, 'projectName', value);

  @override
  String? get adminId =>
      RealmObjectBase.get<String>(this, 'adminId') as String?;
  @override
  set adminId(String? value) => RealmObjectBase.set(this, 'adminId', value);

  @override
  String? get adminName =>
      RealmObjectBase.get<String>(this, 'adminName') as String?;
  @override
  set adminName(String? value) => RealmObjectBase.set(this, 'adminName', value);

  @override
  String? get frequency =>
      RealmObjectBase.get<String>(this, 'frequency') as String?;
  @override
  set frequency(String? value) => RealmObjectBase.set(this, 'frequency', value);

  @override
  String? get result => RealmObjectBase.get<String>(this, 'result') as String?;
  @override
  set result(String? value) => RealmObjectBase.set(this, 'result', value);

  @override
  String? get orgMessageId =>
      RealmObjectBase.get<String>(this, 'orgMessageId') as String?;
  @override
  set orgMessageId(String? value) =>
      RealmObjectBase.set(this, 'orgMessageId', value);

  @override
  Stream<RealmObjectChanges<OrgMessage>> get changes =>
      RealmObjectBase.getChanges<OrgMessage>(this);

  @override
  OrgMessage freeze() => RealmObjectBase.freezeObject<OrgMessage>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(OrgMessage._);
    return const SchemaObject(
        ObjectType.realmObject, OrgMessage, 'OrgMessage', [
      SchemaProperty('name', RealmPropertyType.string, optional: true),
      SchemaProperty('userId', RealmPropertyType.string, optional: true),
      SchemaProperty('message', RealmPropertyType.string, optional: true),
      SchemaProperty('created', RealmPropertyType.string, optional: true),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('projectId', RealmPropertyType.string, optional: true),
      SchemaProperty('projectName', RealmPropertyType.string, optional: true),
      SchemaProperty('adminId', RealmPropertyType.string, optional: true),
      SchemaProperty('adminName', RealmPropertyType.string, optional: true),
      SchemaProperty('frequency', RealmPropertyType.string, optional: true),
      SchemaProperty('result', RealmPropertyType.string, optional: true),
      SchemaProperty('orgMessageId', RealmPropertyType.string, optional: true),
    ]);
  }
}

class LocationRequest extends _LocationRequest
    with RealmEntity, RealmObjectBase, RealmObject {
  LocationRequest({
    String? organizationId,
    String? requesterId,
    String? created,
    String? requesterName,
    String? userId,
    String? userName,
    String? organizationName,
    String? translatedMessage,
    String? translatedTitle,
  }) {
    RealmObjectBase.set(this, 'organizationId', organizationId);
    RealmObjectBase.set(this, 'requesterId', requesterId);
    RealmObjectBase.set(this, 'created', created);
    RealmObjectBase.set(this, 'requesterName', requesterName);
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'userName', userName);
    RealmObjectBase.set(this, 'organizationName', organizationName);
    RealmObjectBase.set(this, 'translatedMessage', translatedMessage);
    RealmObjectBase.set(this, 'translatedTitle', translatedTitle);
  }

  LocationRequest._();

  @override
  String? get organizationId =>
      RealmObjectBase.get<String>(this, 'organizationId') as String?;
  @override
  set organizationId(String? value) =>
      RealmObjectBase.set(this, 'organizationId', value);

  @override
  String? get requesterId =>
      RealmObjectBase.get<String>(this, 'requesterId') as String?;
  @override
  set requesterId(String? value) =>
      RealmObjectBase.set(this, 'requesterId', value);

  @override
  String? get created =>
      RealmObjectBase.get<String>(this, 'created') as String?;
  @override
  set created(String? value) => RealmObjectBase.set(this, 'created', value);

  @override
  String? get requesterName =>
      RealmObjectBase.get<String>(this, 'requesterName') as String?;
  @override
  set requesterName(String? value) =>
      RealmObjectBase.set(this, 'requesterName', value);

  @override
  String? get userId => RealmObjectBase.get<String>(this, 'userId') as String?;
  @override
  set userId(String? value) => RealmObjectBase.set(this, 'userId', value);

  @override
  String? get userName =>
      RealmObjectBase.get<String>(this, 'userName') as String?;
  @override
  set userName(String? value) => RealmObjectBase.set(this, 'userName', value);

  @override
  String? get organizationName =>
      RealmObjectBase.get<String>(this, 'organizationName') as String?;
  @override
  set organizationName(String? value) =>
      RealmObjectBase.set(this, 'organizationName', value);

  @override
  String? get translatedMessage =>
      RealmObjectBase.get<String>(this, 'translatedMessage') as String?;
  @override
  set translatedMessage(String? value) =>
      RealmObjectBase.set(this, 'translatedMessage', value);

  @override
  String? get translatedTitle =>
      RealmObjectBase.get<String>(this, 'translatedTitle') as String?;
  @override
  set translatedTitle(String? value) =>
      RealmObjectBase.set(this, 'translatedTitle', value);

  @override
  Stream<RealmObjectChanges<LocationRequest>> get changes =>
      RealmObjectBase.getChanges<LocationRequest>(this);

  @override
  LocationRequest freeze() =>
      RealmObjectBase.freezeObject<LocationRequest>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(LocationRequest._);
    return const SchemaObject(
        ObjectType.realmObject, LocationRequest, 'LocationRequest', [
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('requesterId', RealmPropertyType.string, optional: true),
      SchemaProperty('created', RealmPropertyType.string, optional: true),
      SchemaProperty('requesterName', RealmPropertyType.string, optional: true),
      SchemaProperty('userId', RealmPropertyType.string, optional: true),
      SchemaProperty('userName', RealmPropertyType.string, optional: true),
      SchemaProperty('organizationName', RealmPropertyType.string,
          optional: true),
      SchemaProperty('translatedMessage', RealmPropertyType.string,
          optional: true),
      SchemaProperty('translatedTitle', RealmPropertyType.string,
          optional: true),
    ]);
  }
}

class LocationResponse extends _LocationResponse
    with RealmEntity, RealmObjectBase, RealmObject {
  LocationResponse({
    String? date,
    String? userId,
    String? organizationId,
    String? userName,
    String? locationResponseId,
    String? organizationName,
    Position? position,
    String? requesterId,
    String? requesterName,
    String? translatedMessage,
    String? translatedTitle,
  }) {
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'organizationId', organizationId);
    RealmObjectBase.set(this, 'userName', userName);
    RealmObjectBase.set(this, 'locationResponseId', locationResponseId);
    RealmObjectBase.set(this, 'organizationName', organizationName);
    RealmObjectBase.set(this, 'position', position);
    RealmObjectBase.set(this, 'requesterId', requesterId);
    RealmObjectBase.set(this, 'requesterName', requesterName);
    RealmObjectBase.set(this, 'translatedMessage', translatedMessage);
    RealmObjectBase.set(this, 'translatedTitle', translatedTitle);
  }

  LocationResponse._();

  @override
  String? get date => RealmObjectBase.get<String>(this, 'date') as String?;
  @override
  set date(String? value) => RealmObjectBase.set(this, 'date', value);

  @override
  String? get userId => RealmObjectBase.get<String>(this, 'userId') as String?;
  @override
  set userId(String? value) => RealmObjectBase.set(this, 'userId', value);

  @override
  String? get organizationId =>
      RealmObjectBase.get<String>(this, 'organizationId') as String?;
  @override
  set organizationId(String? value) =>
      RealmObjectBase.set(this, 'organizationId', value);

  @override
  String? get userName =>
      RealmObjectBase.get<String>(this, 'userName') as String?;
  @override
  set userName(String? value) => RealmObjectBase.set(this, 'userName', value);

  @override
  String? get locationResponseId =>
      RealmObjectBase.get<String>(this, 'locationResponseId') as String?;
  @override
  set locationResponseId(String? value) =>
      RealmObjectBase.set(this, 'locationResponseId', value);

  @override
  String? get organizationName =>
      RealmObjectBase.get<String>(this, 'organizationName') as String?;
  @override
  set organizationName(String? value) =>
      RealmObjectBase.set(this, 'organizationName', value);

  @override
  Position? get position =>
      RealmObjectBase.get<Position>(this, 'position') as Position?;
  @override
  set position(covariant Position? value) =>
      RealmObjectBase.set(this, 'position', value);

  @override
  String? get requesterId =>
      RealmObjectBase.get<String>(this, 'requesterId') as String?;
  @override
  set requesterId(String? value) =>
      RealmObjectBase.set(this, 'requesterId', value);

  @override
  String? get requesterName =>
      RealmObjectBase.get<String>(this, 'requesterName') as String?;
  @override
  set requesterName(String? value) =>
      RealmObjectBase.set(this, 'requesterName', value);

  @override
  String? get translatedMessage =>
      RealmObjectBase.get<String>(this, 'translatedMessage') as String?;
  @override
  set translatedMessage(String? value) =>
      RealmObjectBase.set(this, 'translatedMessage', value);

  @override
  String? get translatedTitle =>
      RealmObjectBase.get<String>(this, 'translatedTitle') as String?;
  @override
  set translatedTitle(String? value) =>
      RealmObjectBase.set(this, 'translatedTitle', value);

  @override
  Stream<RealmObjectChanges<LocationResponse>> get changes =>
      RealmObjectBase.getChanges<LocationResponse>(this);

  @override
  LocationResponse freeze() =>
      RealmObjectBase.freezeObject<LocationResponse>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(LocationResponse._);
    return const SchemaObject(
        ObjectType.realmObject, LocationResponse, 'LocationResponse', [
      SchemaProperty('date', RealmPropertyType.string, optional: true),
      SchemaProperty('userId', RealmPropertyType.string, optional: true),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('userName', RealmPropertyType.string, optional: true),
      SchemaProperty('locationResponseId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('organizationName', RealmPropertyType.string,
          optional: true),
      SchemaProperty('position', RealmPropertyType.object,
          optional: true, linkTarget: 'Position'),
      SchemaProperty('requesterId', RealmPropertyType.string, optional: true),
      SchemaProperty('requesterName', RealmPropertyType.string, optional: true),
      SchemaProperty('translatedMessage', RealmPropertyType.string,
          optional: true),
      SchemaProperty('translatedTitle', RealmPropertyType.string,
          optional: true),
    ]);
  }
}

class ActivityModel extends _ActivityModel
    with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  ActivityModel({
    String? activityModelId,
    String? activityType,
    String? date,
    String? userId,
    String? userName,
    String? projectId,
    String? projectName,
    String? organizationName,
    String? organizationId,
    Photo? photo,
    Video? video,
    Audio? audio,
    User? user,
    Project? project,
    ProjectPosition? projectPosition,
    ProjectPolygon? projectPolygon,
    OrgMessage? orgMessage,
    GeofenceEvent? geofenceEvent,
    LocationRequest? locationRequest,
    LocationResponse? locationResponse,
    String? userThumbnailUrl,
    String? userType,
    String? translatedUserType,
    SettingsModel? settingsModel,
    int intDate = 0,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<ActivityModel>({
        'intDate': 0,
      });
    }
    RealmObjectBase.set(this, 'activityModelId', activityModelId);
    RealmObjectBase.set(this, 'activityType', activityType);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'userName', userName);
    RealmObjectBase.set(this, 'projectId', projectId);
    RealmObjectBase.set(this, 'projectName', projectName);
    RealmObjectBase.set(this, 'organizationName', organizationName);
    RealmObjectBase.set(this, 'organizationId', organizationId);
    RealmObjectBase.set(this, 'photo', photo);
    RealmObjectBase.set(this, 'video', video);
    RealmObjectBase.set(this, 'audio', audio);
    RealmObjectBase.set(this, 'user', user);
    RealmObjectBase.set(this, 'project', project);
    RealmObjectBase.set(this, 'projectPosition', projectPosition);
    RealmObjectBase.set(this, 'projectPolygon', projectPolygon);
    RealmObjectBase.set(this, 'orgMessage', orgMessage);
    RealmObjectBase.set(this, 'geofenceEvent', geofenceEvent);
    RealmObjectBase.set(this, 'locationRequest', locationRequest);
    RealmObjectBase.set(this, 'locationResponse', locationResponse);
    RealmObjectBase.set(this, 'userThumbnailUrl', userThumbnailUrl);
    RealmObjectBase.set(this, 'userType', userType);
    RealmObjectBase.set(this, 'translatedUserType', translatedUserType);
    RealmObjectBase.set(this, 'settingsModel', settingsModel);
    RealmObjectBase.set(this, 'intDate', intDate);
  }

  ActivityModel._();

  @override
  String? get activityModelId =>
      RealmObjectBase.get<String>(this, 'activityModelId') as String?;
  @override
  set activityModelId(String? value) =>
      RealmObjectBase.set(this, 'activityModelId', value);

  @override
  String? get activityType =>
      RealmObjectBase.get<String>(this, 'activityType') as String?;
  @override
  set activityType(String? value) =>
      RealmObjectBase.set(this, 'activityType', value);

  @override
  String? get date => RealmObjectBase.get<String>(this, 'date') as String?;
  @override
  set date(String? value) => RealmObjectBase.set(this, 'date', value);

  @override
  String? get userId => RealmObjectBase.get<String>(this, 'userId') as String?;
  @override
  set userId(String? value) => RealmObjectBase.set(this, 'userId', value);

  @override
  String? get userName =>
      RealmObjectBase.get<String>(this, 'userName') as String?;
  @override
  set userName(String? value) => RealmObjectBase.set(this, 'userName', value);

  @override
  String? get projectId =>
      RealmObjectBase.get<String>(this, 'projectId') as String?;
  @override
  set projectId(String? value) => RealmObjectBase.set(this, 'projectId', value);

  @override
  String? get projectName =>
      RealmObjectBase.get<String>(this, 'projectName') as String?;
  @override
  set projectName(String? value) =>
      RealmObjectBase.set(this, 'projectName', value);

  @override
  String? get organizationName =>
      RealmObjectBase.get<String>(this, 'organizationName') as String?;
  @override
  set organizationName(String? value) =>
      RealmObjectBase.set(this, 'organizationName', value);

  @override
  String? get organizationId =>
      RealmObjectBase.get<String>(this, 'organizationId') as String?;
  @override
  set organizationId(String? value) =>
      RealmObjectBase.set(this, 'organizationId', value);

  @override
  Photo? get photo => RealmObjectBase.get<Photo>(this, 'photo') as Photo?;
  @override
  set photo(covariant Photo? value) =>
      RealmObjectBase.set(this, 'photo', value);

  @override
  Video? get video => RealmObjectBase.get<Video>(this, 'video') as Video?;
  @override
  set video(covariant Video? value) =>
      RealmObjectBase.set(this, 'video', value);

  @override
  Audio? get audio => RealmObjectBase.get<Audio>(this, 'audio') as Audio?;
  @override
  set audio(covariant Audio? value) =>
      RealmObjectBase.set(this, 'audio', value);

  @override
  User? get user => RealmObjectBase.get<User>(this, 'user') as User?;
  @override
  set user(covariant User? value) => RealmObjectBase.set(this, 'user', value);

  @override
  Project? get project =>
      RealmObjectBase.get<Project>(this, 'project') as Project?;
  @override
  set project(covariant Project? value) =>
      RealmObjectBase.set(this, 'project', value);

  @override
  ProjectPosition? get projectPosition =>
      RealmObjectBase.get<ProjectPosition>(this, 'projectPosition')
          as ProjectPosition?;
  @override
  set projectPosition(covariant ProjectPosition? value) =>
      RealmObjectBase.set(this, 'projectPosition', value);

  @override
  ProjectPolygon? get projectPolygon =>
      RealmObjectBase.get<ProjectPolygon>(this, 'projectPolygon')
          as ProjectPolygon?;
  @override
  set projectPolygon(covariant ProjectPolygon? value) =>
      RealmObjectBase.set(this, 'projectPolygon', value);

  @override
  OrgMessage? get orgMessage =>
      RealmObjectBase.get<OrgMessage>(this, 'orgMessage') as OrgMessage?;
  @override
  set orgMessage(covariant OrgMessage? value) =>
      RealmObjectBase.set(this, 'orgMessage', value);

  @override
  GeofenceEvent? get geofenceEvent =>
      RealmObjectBase.get<GeofenceEvent>(this, 'geofenceEvent')
          as GeofenceEvent?;
  @override
  set geofenceEvent(covariant GeofenceEvent? value) =>
      RealmObjectBase.set(this, 'geofenceEvent', value);

  @override
  LocationRequest? get locationRequest =>
      RealmObjectBase.get<LocationRequest>(this, 'locationRequest')
          as LocationRequest?;
  @override
  set locationRequest(covariant LocationRequest? value) =>
      RealmObjectBase.set(this, 'locationRequest', value);

  @override
  LocationResponse? get locationResponse =>
      RealmObjectBase.get<LocationResponse>(this, 'locationResponse')
          as LocationResponse?;
  @override
  set locationResponse(covariant LocationResponse? value) =>
      RealmObjectBase.set(this, 'locationResponse', value);

  @override
  String? get userThumbnailUrl =>
      RealmObjectBase.get<String>(this, 'userThumbnailUrl') as String?;
  @override
  set userThumbnailUrl(String? value) =>
      RealmObjectBase.set(this, 'userThumbnailUrl', value);

  @override
  String? get userType =>
      RealmObjectBase.get<String>(this, 'userType') as String?;
  @override
  set userType(String? value) => RealmObjectBase.set(this, 'userType', value);

  @override
  String? get translatedUserType =>
      RealmObjectBase.get<String>(this, 'translatedUserType') as String?;
  @override
  set translatedUserType(String? value) =>
      RealmObjectBase.set(this, 'translatedUserType', value);

  @override
  SettingsModel? get settingsModel =>
      RealmObjectBase.get<SettingsModel>(this, 'settingsModel')
          as SettingsModel?;
  @override
  set settingsModel(covariant SettingsModel? value) =>
      RealmObjectBase.set(this, 'settingsModel', value);

  @override
  int get intDate => RealmObjectBase.get<int>(this, 'intDate') as int;
  @override
  set intDate(int value) => RealmObjectBase.set(this, 'intDate', value);

  @override
  Stream<RealmObjectChanges<ActivityModel>> get changes =>
      RealmObjectBase.getChanges<ActivityModel>(this);

  @override
  ActivityModel freeze() => RealmObjectBase.freezeObject<ActivityModel>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(ActivityModel._);
    return const SchemaObject(
        ObjectType.realmObject, ActivityModel, 'ActivityModel', [
      SchemaProperty('activityModelId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('activityType', RealmPropertyType.string, optional: true),
      SchemaProperty('date', RealmPropertyType.string, optional: true),
      SchemaProperty('userId', RealmPropertyType.string, optional: true),
      SchemaProperty('userName', RealmPropertyType.string, optional: true),
      SchemaProperty('projectId', RealmPropertyType.string, optional: true),
      SchemaProperty('projectName', RealmPropertyType.string, optional: true),
      SchemaProperty('organizationName', RealmPropertyType.string,
          optional: true),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('photo', RealmPropertyType.object,
          optional: true, linkTarget: 'Photo'),
      SchemaProperty('video', RealmPropertyType.object,
          optional: true, linkTarget: 'Video'),
      SchemaProperty('audio', RealmPropertyType.object,
          optional: true, linkTarget: 'Audio'),
      SchemaProperty('user', RealmPropertyType.object,
          optional: true, linkTarget: 'User'),
      SchemaProperty('project', RealmPropertyType.object,
          optional: true, linkTarget: 'Project'),
      SchemaProperty('projectPosition', RealmPropertyType.object,
          optional: true, linkTarget: 'ProjectPosition'),
      SchemaProperty('projectPolygon', RealmPropertyType.object,
          optional: true, linkTarget: 'ProjectPolygon'),
      SchemaProperty('orgMessage', RealmPropertyType.object,
          optional: true, linkTarget: 'OrgMessage'),
      SchemaProperty('geofenceEvent', RealmPropertyType.object,
          optional: true, linkTarget: 'GeofenceEvent'),
      SchemaProperty('locationRequest', RealmPropertyType.object,
          optional: true, linkTarget: 'LocationRequest'),
      SchemaProperty('locationResponse', RealmPropertyType.object,
          optional: true, linkTarget: 'LocationResponse'),
      SchemaProperty('userThumbnailUrl', RealmPropertyType.string,
          optional: true),
      SchemaProperty('userType', RealmPropertyType.string, optional: true),
      SchemaProperty('translatedUserType', RealmPropertyType.string,
          optional: true),
      SchemaProperty('settingsModel', RealmPropertyType.object,
          optional: true, linkTarget: 'SettingsModel'),
      SchemaProperty('intDate', RealmPropertyType.int),
    ]);
  }
}

class Country extends _Country with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  Country({
    String? name,
    String? countryId,
    String? countryCode,
    int? population = 0,
    Position? position,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<Country>({
        'population': 0,
      });
    }
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'countryId', countryId);
    RealmObjectBase.set(this, 'countryCode', countryCode);
    RealmObjectBase.set(this, 'population', population);
    RealmObjectBase.set(this, 'position', position);
  }

  Country._();

  @override
  String? get name => RealmObjectBase.get<String>(this, 'name') as String?;
  @override
  set name(String? value) => RealmObjectBase.set(this, 'name', value);

  @override
  String? get countryId =>
      RealmObjectBase.get<String>(this, 'countryId') as String?;
  @override
  set countryId(String? value) => RealmObjectBase.set(this, 'countryId', value);

  @override
  String? get countryCode =>
      RealmObjectBase.get<String>(this, 'countryCode') as String?;
  @override
  set countryCode(String? value) =>
      RealmObjectBase.set(this, 'countryCode', value);

  @override
  int? get population => RealmObjectBase.get<int>(this, 'population') as int?;
  @override
  set population(int? value) => RealmObjectBase.set(this, 'population', value);

  @override
  Position? get position =>
      RealmObjectBase.get<Position>(this, 'position') as Position?;
  @override
  set position(covariant Position? value) =>
      RealmObjectBase.set(this, 'position', value);

  @override
  Stream<RealmObjectChanges<Country>> get changes =>
      RealmObjectBase.getChanges<Country>(this);

  @override
  Country freeze() => RealmObjectBase.freezeObject<Country>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Country._);
    return const SchemaObject(ObjectType.realmObject, Country, 'Country', [
      SchemaProperty('name', RealmPropertyType.string, optional: true),
      SchemaProperty('countryId', RealmPropertyType.string, optional: true),
      SchemaProperty('countryCode', RealmPropertyType.string, optional: true),
      SchemaProperty('population', RealmPropertyType.int, optional: true),
      SchemaProperty('position', RealmPropertyType.object,
          optional: true, linkTarget: 'Position'),
    ]);
  }
}
