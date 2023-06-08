// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schemas.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class City extends _City with RealmEntity, RealmObjectBase, RealmObject {
  City(
    ObjectId id, {
    String? cityId,
    String? countryId,
    String? name,
    Position? position,
    String? stateId,
    String? stateName,
    String? countryName,
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'cityId', cityId);
    RealmObjectBase.set(this, 'countryId', countryId);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'position', position);
    RealmObjectBase.set(this, 'stateId', stateId);
    RealmObjectBase.set(this, 'stateName', stateName);
    RealmObjectBase.set(this, 'countryName', countryName);
  }

  City._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

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
  String? get name => RealmObjectBase.get<String>(this, 'name') as String?;
  @override
  set name(String? value) => RealmObjectBase.set(this, 'name', value);

  @override
  Position? get position =>
      RealmObjectBase.get<Position>(this, 'position') as Position?;
  @override
  set position(covariant Position? value) =>
      RealmObjectBase.set(this, 'position', value);

  @override
  String? get stateId =>
      RealmObjectBase.get<String>(this, 'stateId') as String?;
  @override
  set stateId(String? value) => RealmObjectBase.set(this, 'stateId', value);

  @override
  String? get stateName =>
      RealmObjectBase.get<String>(this, 'stateName') as String?;
  @override
  set stateName(String? value) => RealmObjectBase.set(this, 'stateName', value);

  @override
  String? get countryName =>
      RealmObjectBase.get<String>(this, 'countryName') as String?;
  @override
  set countryName(String? value) =>
      RealmObjectBase.set(this, 'countryName', value);

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
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('cityId', RealmPropertyType.string, optional: true),
      SchemaProperty('countryId', RealmPropertyType.string, optional: true),
      SchemaProperty('name', RealmPropertyType.string, optional: true),
      SchemaProperty('position', RealmPropertyType.object,
          optional: true, linkTarget: 'Position'),
      SchemaProperty('stateId', RealmPropertyType.string, optional: true),
      SchemaProperty('stateName', RealmPropertyType.string, optional: true),
      SchemaProperty('countryName', RealmPropertyType.string, optional: true),
    ]);
  }
}

class State extends _State with RealmEntity, RealmObjectBase, RealmObject {
  State(
    ObjectId id, {
    String? countryId,
    String? name,
    Position? position,
    String? stateId,
    String? countryName,
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'countryId', countryId);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'position', position);
    RealmObjectBase.set(this, 'stateId', stateId);
    RealmObjectBase.set(this, 'countryName', countryName);
  }

  State._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String? get countryId =>
      RealmObjectBase.get<String>(this, 'countryId') as String?;
  @override
  set countryId(String? value) => RealmObjectBase.set(this, 'countryId', value);

  @override
  String? get name => RealmObjectBase.get<String>(this, 'name') as String?;
  @override
  set name(String? value) => RealmObjectBase.set(this, 'name', value);

  @override
  Position? get position =>
      RealmObjectBase.get<Position>(this, 'position') as Position?;
  @override
  set position(covariant Position? value) =>
      RealmObjectBase.set(this, 'position', value);

  @override
  String? get stateId =>
      RealmObjectBase.get<String>(this, 'stateId') as String?;
  @override
  set stateId(String? value) => RealmObjectBase.set(this, 'stateId', value);

  @override
  String? get countryName =>
      RealmObjectBase.get<String>(this, 'countryName') as String?;
  @override
  set countryName(String? value) =>
      RealmObjectBase.set(this, 'countryName', value);

  @override
  Stream<RealmObjectChanges<State>> get changes =>
      RealmObjectBase.getChanges<State>(this);

  @override
  State freeze() => RealmObjectBase.freezeObject<State>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(State._);
    return const SchemaObject(ObjectType.realmObject, State, 'State', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('countryId', RealmPropertyType.string, optional: true),
      SchemaProperty('name', RealmPropertyType.string, optional: true),
      SchemaProperty('position', RealmPropertyType.object,
          optional: true, linkTarget: 'Position'),
      SchemaProperty('stateId', RealmPropertyType.string, optional: true),
      SchemaProperty('countryName', RealmPropertyType.string, optional: true),
    ]);
  }
}

class Position extends _Position
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  static var _defaultsSet = false;

  Position({
    String? type = 'Point',
    double? latitude,
    double? longitude,
    Iterable<double> coordinates = const [],
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<Position>({
        'type': 'Point',
      });
    }
    RealmObjectBase.set(this, 'type', type);
    RealmObjectBase.set(this, 'latitude', latitude);
    RealmObjectBase.set(this, 'longitude', longitude);
    RealmObjectBase.set<RealmList<double>>(
        this, 'coordinates', RealmList<double>(coordinates));
  }

  Position._();

  @override
  String? get type => RealmObjectBase.get<String>(this, 'type') as String?;
  @override
  set type(String? value) => RealmObjectBase.set(this, 'type', value);

  @override
  double? get latitude =>
      RealmObjectBase.get<double>(this, 'latitude') as double?;
  @override
  set latitude(double? value) => RealmObjectBase.set(this, 'latitude', value);

  @override
  double? get longitude =>
      RealmObjectBase.get<double>(this, 'longitude') as double?;
  @override
  set longitude(double? value) => RealmObjectBase.set(this, 'longitude', value);

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
    return const SchemaObject(ObjectType.embeddedObject, Position, 'Position', [
      SchemaProperty('type', RealmPropertyType.string, optional: true),
      SchemaProperty('latitude', RealmPropertyType.double, optional: true),
      SchemaProperty('longitude', RealmPropertyType.double, optional: true),
      SchemaProperty('coordinates', RealmPropertyType.double,
          collectionType: RealmCollectionType.list),
    ]);
  }
}

class Audio extends _Audio with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  Audio(
    ObjectId id, {
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
    RealmObjectBase.set(this, '_id', id);
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
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

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
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('audioId', RealmPropertyType.string, optional: true),
      SchemaProperty('durationInSeconds', RealmPropertyType.int,
          optional: true),
      SchemaProperty('created', RealmPropertyType.string, optional: true),
      SchemaProperty('url', RealmPropertyType.string, optional: true),
      SchemaProperty('projectPositionId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('userId', RealmPropertyType.string,
          optional: true, indexed: true),
      SchemaProperty('userName', RealmPropertyType.string, optional: true),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true, indexed: true),
      SchemaProperty('projectPosition', RealmPropertyType.object,
          optional: true, linkTarget: 'Position'),
      SchemaProperty('distanceFromProjectPosition', RealmPropertyType.double,
          optional: true),
      SchemaProperty('projectId', RealmPropertyType.string,
          optional: true, indexed: true),
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
    ObjectId id, {
    String? photoId,
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
    RealmObjectBase.set(this, '_id', id);
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
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String? get photoId =>
      RealmObjectBase.get<String>(this, 'photoId') as String?;
  @override
  set photoId(String? value) => RealmObjectBase.set(this, 'photoId', value);

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
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('photoId', RealmPropertyType.string, optional: true),
      SchemaProperty('created', RealmPropertyType.string, optional: true),
      SchemaProperty('url', RealmPropertyType.string, optional: true),
      SchemaProperty('thumbnailUrl', RealmPropertyType.string, optional: true),
      SchemaProperty('landscape', RealmPropertyType.int, optional: true),
      SchemaProperty('projectPositionId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('userId', RealmPropertyType.string,
          optional: true, indexed: true),
      SchemaProperty('userName', RealmPropertyType.string, optional: true),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true, indexed: true),
      SchemaProperty('projectPosition', RealmPropertyType.object,
          optional: true, linkTarget: 'Position'),
      SchemaProperty('distanceFromProjectPosition', RealmPropertyType.double,
          optional: true),
      SchemaProperty('projectId', RealmPropertyType.string,
          optional: true, indexed: true),
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
    ObjectId id, {
    String? videoId,
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
    RealmObjectBase.set(this, '_id', id);
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
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String? get videoId =>
      RealmObjectBase.get<String>(this, 'videoId') as String?;
  @override
  set videoId(String? value) => RealmObjectBase.set(this, 'videoId', value);

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
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('videoId', RealmPropertyType.string, optional: true),
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
  Organization(
    ObjectId id, {
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
    RealmObjectBase.set(this, '_id', id);
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
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

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
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
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

class GioPaymentRequest extends _GioPaymentRequest
    with RealmEntity, RealmObjectBase, RealmObject {
  GioPaymentRequest(
    ObjectId id, {
    int? quantity,
    String? currency,
    String? organizationId,
    String? payerReference,
    String? externalReference,
    String? beneficiaryName,
    String? beneficiaryBankId,
    String? beneficiaryAccountNumber,
    String? merchant,
    String? paymentRequestId,
    String? subscriptionId,
    String? beneficiaryReference,
    String? date,
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'quantity', quantity);
    RealmObjectBase.set(this, 'currency', currency);
    RealmObjectBase.set(this, 'organizationId', organizationId);
    RealmObjectBase.set(this, 'payerReference', payerReference);
    RealmObjectBase.set(this, 'externalReference', externalReference);
    RealmObjectBase.set(this, 'beneficiaryName', beneficiaryName);
    RealmObjectBase.set(this, 'beneficiaryBankId', beneficiaryBankId);
    RealmObjectBase.set(
        this, 'beneficiaryAccountNumber', beneficiaryAccountNumber);
    RealmObjectBase.set(this, 'merchant', merchant);
    RealmObjectBase.set(this, 'paymentRequestId', paymentRequestId);
    RealmObjectBase.set(this, 'subscriptionId', subscriptionId);
    RealmObjectBase.set(this, 'beneficiaryReference', beneficiaryReference);
    RealmObjectBase.set(this, 'date', date);
  }

  GioPaymentRequest._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  int? get quantity => RealmObjectBase.get<int>(this, 'quantity') as int?;
  @override
  set quantity(int? value) => RealmObjectBase.set(this, 'quantity', value);

  @override
  String? get currency =>
      RealmObjectBase.get<String>(this, 'currency') as String?;
  @override
  set currency(String? value) => RealmObjectBase.set(this, 'currency', value);

  @override
  String? get organizationId =>
      RealmObjectBase.get<String>(this, 'organizationId') as String?;
  @override
  set organizationId(String? value) =>
      RealmObjectBase.set(this, 'organizationId', value);

  @override
  String? get payerReference =>
      RealmObjectBase.get<String>(this, 'payerReference') as String?;
  @override
  set payerReference(String? value) =>
      RealmObjectBase.set(this, 'payerReference', value);

  @override
  String? get externalReference =>
      RealmObjectBase.get<String>(this, 'externalReference') as String?;
  @override
  set externalReference(String? value) =>
      RealmObjectBase.set(this, 'externalReference', value);

  @override
  String? get beneficiaryName =>
      RealmObjectBase.get<String>(this, 'beneficiaryName') as String?;
  @override
  set beneficiaryName(String? value) =>
      RealmObjectBase.set(this, 'beneficiaryName', value);

  @override
  String? get beneficiaryBankId =>
      RealmObjectBase.get<String>(this, 'beneficiaryBankId') as String?;
  @override
  set beneficiaryBankId(String? value) =>
      RealmObjectBase.set(this, 'beneficiaryBankId', value);

  @override
  String? get beneficiaryAccountNumber =>
      RealmObjectBase.get<String>(this, 'beneficiaryAccountNumber') as String?;
  @override
  set beneficiaryAccountNumber(String? value) =>
      RealmObjectBase.set(this, 'beneficiaryAccountNumber', value);

  @override
  String? get merchant =>
      RealmObjectBase.get<String>(this, 'merchant') as String?;
  @override
  set merchant(String? value) => RealmObjectBase.set(this, 'merchant', value);

  @override
  String? get paymentRequestId =>
      RealmObjectBase.get<String>(this, 'paymentRequestId') as String?;
  @override
  set paymentRequestId(String? value) =>
      RealmObjectBase.set(this, 'paymentRequestId', value);

  @override
  String? get subscriptionId =>
      RealmObjectBase.get<String>(this, 'subscriptionId') as String?;
  @override
  set subscriptionId(String? value) =>
      RealmObjectBase.set(this, 'subscriptionId', value);

  @override
  String? get beneficiaryReference =>
      RealmObjectBase.get<String>(this, 'beneficiaryReference') as String?;
  @override
  set beneficiaryReference(String? value) =>
      RealmObjectBase.set(this, 'beneficiaryReference', value);

  @override
  String? get date => RealmObjectBase.get<String>(this, 'date') as String?;
  @override
  set date(String? value) => RealmObjectBase.set(this, 'date', value);

  @override
  Stream<RealmObjectChanges<GioPaymentRequest>> get changes =>
      RealmObjectBase.getChanges<GioPaymentRequest>(this);

  @override
  GioPaymentRequest freeze() =>
      RealmObjectBase.freezeObject<GioPaymentRequest>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(GioPaymentRequest._);
    return const SchemaObject(
        ObjectType.realmObject, GioPaymentRequest, 'GioPaymentRequest', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('quantity', RealmPropertyType.int, optional: true),
      SchemaProperty('currency', RealmPropertyType.string, optional: true),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('payerReference', RealmPropertyType.string,
          optional: true),
      SchemaProperty('externalReference', RealmPropertyType.string,
          optional: true),
      SchemaProperty('beneficiaryName', RealmPropertyType.string,
          optional: true),
      SchemaProperty('beneficiaryBankId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('beneficiaryAccountNumber', RealmPropertyType.string,
          optional: true),
      SchemaProperty('merchant', RealmPropertyType.string, optional: true),
      SchemaProperty('paymentRequestId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('subscriptionId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('beneficiaryReference', RealmPropertyType.string,
          optional: true),
      SchemaProperty('date', RealmPropertyType.string, optional: true),
    ]);
  }
}

class Project extends _Project with RealmEntity, RealmObjectBase, RealmObject {
  Project(
    ObjectId id, {
    String? projectId,
    String? name,
    String? created,
    String? organizationId,
    String? organizationName,
    String? description,
    String? translatedMessage,
    String? translatedTitle,
    int? monitorMaxDistanceInMetres,
    Iterable<String> nearestCities = const [],
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'projectId', projectId);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'created', created);
    RealmObjectBase.set(this, 'organizationId', organizationId);
    RealmObjectBase.set(this, 'organizationName', organizationName);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'translatedMessage', translatedMessage);
    RealmObjectBase.set(this, 'translatedTitle', translatedTitle);
    RealmObjectBase.set(
        this, 'monitorMaxDistanceInMetres', monitorMaxDistanceInMetres);
    RealmObjectBase.set<RealmList<String>>(
        this, 'nearestCities', RealmList<String>(nearestCities));
  }

  Project._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

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
  String? get created =>
      RealmObjectBase.get<String>(this, 'created') as String?;
  @override
  set created(String? value) => RealmObjectBase.set(this, 'created', value);

  @override
  RealmList<String> get nearestCities =>
      RealmObjectBase.get<String>(this, 'nearestCities') as RealmList<String>;
  @override
  set nearestCities(covariant RealmList<String> value) =>
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
  int? get monitorMaxDistanceInMetres =>
      RealmObjectBase.get<int>(this, 'monitorMaxDistanceInMetres') as int?;
  @override
  set monitorMaxDistanceInMetres(int? value) =>
      RealmObjectBase.set(this, 'monitorMaxDistanceInMetres', value);

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
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('projectId', RealmPropertyType.string, optional: true),
      SchemaProperty('name', RealmPropertyType.string, optional: true),
      SchemaProperty('created', RealmPropertyType.string, optional: true),
      SchemaProperty('nearestCities', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true, indexed: true),
      SchemaProperty('organizationName', RealmPropertyType.string,
          optional: true),
      SchemaProperty('description', RealmPropertyType.string, optional: true),
      SchemaProperty('translatedMessage', RealmPropertyType.string,
          optional: true),
      SchemaProperty('translatedTitle', RealmPropertyType.string,
          optional: true),
      SchemaProperty('monitorMaxDistanceInMetres', RealmPropertyType.int,
          optional: true),
    ]);
  }
}

class ProjectPosition extends _ProjectPosition
    with RealmEntity, RealmObjectBase, RealmObject {
  ProjectPosition(
    ObjectId id, {
    String? projectName,
    String? projectId,
    String? caption,
    String? created,
    String? projectPositionId,
    String? organizationId,
    String? organizationName,
    Position? position,
    String? name,
    String? userId,
    String? userName,
    String? userUrl,
    String? possibleAddress,
    String? translatedMessage,
    String? translatedTitle,
    Iterable<String> nearestCities = const [],
  }) {
    RealmObjectBase.set(this, 'projectName', projectName);
    RealmObjectBase.set(this, 'projectId', projectId);
    RealmObjectBase.set(this, 'caption', caption);
    RealmObjectBase.set(this, 'created', created);
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'projectPositionId', projectPositionId);
    RealmObjectBase.set(this, 'organizationId', organizationId);
    RealmObjectBase.set(this, 'organizationName', organizationName);
    RealmObjectBase.set(this, 'position', position);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'userName', userName);
    RealmObjectBase.set(this, 'userUrl', userUrl);
    RealmObjectBase.set(this, 'possibleAddress', possibleAddress);
    RealmObjectBase.set(this, 'translatedMessage', translatedMessage);
    RealmObjectBase.set(this, 'translatedTitle', translatedTitle);
    RealmObjectBase.set<RealmList<String>>(
        this, 'nearestCities', RealmList<String>(nearestCities));
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
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

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
  RealmList<String> get nearestCities =>
      RealmObjectBase.get<String>(this, 'nearestCities') as RealmList<String>;
  @override
  set nearestCities(covariant RealmList<String> value) =>
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
  String? get userUrl =>
      RealmObjectBase.get<String>(this, 'userUrl') as String?;
  @override
  set userUrl(String? value) => RealmObjectBase.set(this, 'userUrl', value);

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
      SchemaProperty('projectId', RealmPropertyType.string,
          optional: true, indexed: true),
      SchemaProperty('caption', RealmPropertyType.string, optional: true),
      SchemaProperty('created', RealmPropertyType.string, optional: true),
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('projectPositionId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true, indexed: true),
      SchemaProperty('organizationName', RealmPropertyType.string,
          optional: true),
      SchemaProperty('position', RealmPropertyType.object,
          optional: true, linkTarget: 'Position'),
      SchemaProperty('nearestCities', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('name', RealmPropertyType.string, optional: true),
      SchemaProperty('userId', RealmPropertyType.string, optional: true),
      SchemaProperty('userName', RealmPropertyType.string, optional: true),
      SchemaProperty('userUrl', RealmPropertyType.string, optional: true),
      SchemaProperty('possibleAddress', RealmPropertyType.string,
          optional: true),
      SchemaProperty('translatedMessage', RealmPropertyType.string,
          optional: true),
      SchemaProperty('translatedTitle', RealmPropertyType.string,
          optional: true),
    ]);
  }
}

class ProjectPolygon extends _ProjectPolygon
    with RealmEntity, RealmObjectBase, RealmObject {
  ProjectPolygon(
    ObjectId id, {
    String? projectName,
    String? projectId,
    String? created,
    String? projectPolygonId,
    String? organizationId,
    String? organizationName,
    String? userId,
    String? userName,
    String? userUrl,
    String? translatedMessage,
    String? translatedTitle,
    Iterable<Position> positions = const [],
    Iterable<String> nearestCities = const [],
  }) {
    RealmObjectBase.set(this, 'projectName', projectName);
    RealmObjectBase.set(this, 'projectId', projectId);
    RealmObjectBase.set(this, 'created', created);
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'projectPolygonId', projectPolygonId);
    RealmObjectBase.set(this, 'organizationId', organizationId);
    RealmObjectBase.set(this, 'organizationName', organizationName);
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'userName', userName);
    RealmObjectBase.set(this, 'userUrl', userUrl);
    RealmObjectBase.set(this, 'translatedMessage', translatedMessage);
    RealmObjectBase.set(this, 'translatedTitle', translatedTitle);
    RealmObjectBase.set<RealmList<Position>>(
        this, 'positions', RealmList<Position>(positions));
    RealmObjectBase.set<RealmList<String>>(
        this, 'nearestCities', RealmList<String>(nearestCities));
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
  String? get created =>
      RealmObjectBase.get<String>(this, 'created') as String?;
  @override
  set created(String? value) => RealmObjectBase.set(this, 'created', value);

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

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
  RealmList<String> get nearestCities =>
      RealmObjectBase.get<String>(this, 'nearestCities') as RealmList<String>;
  @override
  set nearestCities(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

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
      SchemaProperty('created', RealmPropertyType.string, optional: true),
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('projectPolygonId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true, indexed: true),
      SchemaProperty('organizationName', RealmPropertyType.string,
          optional: true),
      SchemaProperty('positions', RealmPropertyType.object,
          linkTarget: 'Position', collectionType: RealmCollectionType.list),
      SchemaProperty('nearestCities', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('userId', RealmPropertyType.string, optional: true),
      SchemaProperty('userName', RealmPropertyType.string, optional: true),
      SchemaProperty('userUrl', RealmPropertyType.string, optional: true),
      SchemaProperty('translatedMessage', RealmPropertyType.string,
          optional: true),
      SchemaProperty('translatedTitle', RealmPropertyType.string,
          optional: true),
    ]);
  }
}

class Rating extends _Rating with RealmEntity, RealmObjectBase, RealmObject {
  Rating(
    ObjectId id, {
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
    RealmObjectBase.set(this, '_id', id);
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
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

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
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('remarks', RealmPropertyType.string, optional: true),
      SchemaProperty('created', RealmPropertyType.string, optional: true),
      SchemaProperty('audioId', RealmPropertyType.string, optional: true),
      SchemaProperty('photoId', RealmPropertyType.string, optional: true),
      SchemaProperty('userId', RealmPropertyType.string, optional: true),
      SchemaProperty('userName', RealmPropertyType.string, optional: true),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true, indexed: true),
      SchemaProperty('ratingCode', RealmPropertyType.int, optional: true),
      SchemaProperty('projectId', RealmPropertyType.string,
          optional: true, indexed: true),
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

  SettingsModel(
    ObjectId id, {
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
    int? refreshRateInMinutes,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<SettingsModel>({
        'locale': "en",
      });
    }
    RealmObjectBase.set(this, '_id', id);
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
    RealmObjectBase.set(this, 'refreshRateInMinutes', refreshRateInMinutes);
  }

  SettingsModel._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

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
  int? get refreshRateInMinutes =>
      RealmObjectBase.get<int>(this, 'refreshRateInMinutes') as int?;
  @override
  set refreshRateInMinutes(int? value) =>
      RealmObjectBase.set(this, 'refreshRateInMinutes', value);

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
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
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
      SchemaProperty('refreshRateInMinutes', RealmPropertyType.int,
          optional: true),
    ]);
  }
}

class DataCounts extends _DataCounts
    with RealmEntity, RealmObjectBase, RealmObject {
  DataCounts(
    ObjectId id, {
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
    RealmObjectBase.set(this, '_id', id);
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
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

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
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('projectId', RealmPropertyType.string,
          optional: true, indexed: true),
      SchemaProperty('projects', RealmPropertyType.int, optional: true),
      SchemaProperty('users', RealmPropertyType.int, optional: true),
      SchemaProperty('created', RealmPropertyType.string, optional: true),
      SchemaProperty('photos', RealmPropertyType.string, optional: true),
      SchemaProperty('userId', RealmPropertyType.string, optional: true),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true, indexed: true),
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

  GeofenceEvent(
    ObjectId id, {
    String? status,
    String? geofenceEventId,
    String? date,
    String? projectPositionId,
    String? projectName,
    String? userId,
    String? userName,
    String? userUrl,
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
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'status', status);
    RealmObjectBase.set(this, 'geofenceEventId', geofenceEventId);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'projectPositionId', projectPositionId);
    RealmObjectBase.set(this, 'projectName', projectName);
    RealmObjectBase.set(this, 'userId', userId);
    RealmObjectBase.set(this, 'userName', userName);
    RealmObjectBase.set(this, 'userUrl', userUrl);
    RealmObjectBase.set(this, 'organizationId', organizationId);
    RealmObjectBase.set(this, 'position', position);
    RealmObjectBase.set(this, 'projectId', projectId);
    RealmObjectBase.set(this, 'locale', locale);
    RealmObjectBase.set(this, 'translatedMessage', translatedMessage);
    RealmObjectBase.set(this, 'translatedTitle', translatedTitle);
  }

  GeofenceEvent._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

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
  String? get userId => RealmObjectBase.get<String>(this, 'userId') as String?;
  @override
  set userId(String? value) => RealmObjectBase.set(this, 'userId', value);

  @override
  String? get userName =>
      RealmObjectBase.get<String>(this, 'userName') as String?;
  @override
  set userName(String? value) => RealmObjectBase.set(this, 'userName', value);

  @override
  String? get userUrl =>
      RealmObjectBase.get<String>(this, 'userUrl') as String?;
  @override
  set userUrl(String? value) => RealmObjectBase.set(this, 'userUrl', value);

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
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('status', RealmPropertyType.string, optional: true),
      SchemaProperty('geofenceEventId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('date', RealmPropertyType.string, optional: true),
      SchemaProperty('projectPositionId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('projectName', RealmPropertyType.string, optional: true),
      SchemaProperty('userId', RealmPropertyType.string, optional: true),
      SchemaProperty('userName', RealmPropertyType.string, optional: true),
      SchemaProperty('userUrl', RealmPropertyType.string, optional: true),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true, indexed: true),
      SchemaProperty('position', RealmPropertyType.object,
          optional: true, linkTarget: 'Position'),
      SchemaProperty('projectId', RealmPropertyType.string,
          optional: true, indexed: true),
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

  User(
    ObjectId id, {
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
    RealmObjectBase.set(this, '_id', id);
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
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

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
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
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
          optional: true, indexed: true),
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
  GioSubscription(
    ObjectId id, {
    String? subscriptionId,
    String? date,
    String? user,
    String? organizationId,
    String? organizationName,
    String? updated,
    int? intDate,
    int? intUpdated,
    int? subscriptionType,
    int? active,
  }) {
    RealmObjectBase.set(this, '_id', id);
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
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

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
  String? get user => RealmObjectBase.get<String>(this, 'user') as String?;
  @override
  set user(String? value) => RealmObjectBase.set(this, 'user', value);

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
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('subscriptionId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('date', RealmPropertyType.string, optional: true),
      SchemaProperty('user', RealmPropertyType.string, optional: true),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true, indexed: true),
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
  Pricing(
    ObjectId id, {
    String? countryId,
    String? date,
    String? countryName,
    double? monthlyPrice,
    double? annualPrice,
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'countryId', countryId);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'countryName', countryName);
    RealmObjectBase.set(this, 'monthlyPrice', monthlyPrice);
    RealmObjectBase.set(this, 'annualPrice', annualPrice);
  }

  Pricing._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

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
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
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
  OrgMessage(
    ObjectId id, {
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
    RealmObjectBase.set(this, '_id', id);
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
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

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
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string, optional: true),
      SchemaProperty('userId', RealmPropertyType.string, optional: true),
      SchemaProperty('message', RealmPropertyType.string, optional: true),
      SchemaProperty('created', RealmPropertyType.string, optional: true),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true, indexed: true),
      SchemaProperty('projectId', RealmPropertyType.string,
          optional: true, indexed: true),
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
  LocationRequest(
    ObjectId id, {
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
    RealmObjectBase.set(this, '_id', id);
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
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

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
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true, indexed: true),
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
  LocationResponse(
    ObjectId id, {
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
    RealmObjectBase.set(this, '_id', id);
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
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

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
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('date', RealmPropertyType.string, optional: true),
      SchemaProperty('userId', RealmPropertyType.string, optional: true),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true, indexed: true),
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

  ActivityModel(
    ObjectId id, {
    String? activityModelId,
    String? activityType,
    String? date,
    String? userId,
    String? userName,
    String? projectId,
    String? projectName,
    String? organizationName,
    String? organizationId,
    String? photo,
    String? video,
    String? audio,
    String? user,
    String? project,
    String? projectPosition,
    String? projectPolygon,
    String? orgMessage,
    String? geofenceEvent,
    String? locationRequest,
    String? locationResponse,
    String? userThumbnailUrl,
    String? userType,
    String? translatedUserType,
    String? settingsModel,
    int? intDate = 0,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<ActivityModel>({
        'intDate': 0,
      });
    }
    RealmObjectBase.set(this, '_id', id);
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
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

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
  String? get photo => RealmObjectBase.get<String>(this, 'photo') as String?;
  @override
  set photo(String? value) => RealmObjectBase.set(this, 'photo', value);

  @override
  String? get video => RealmObjectBase.get<String>(this, 'video') as String?;
  @override
  set video(String? value) => RealmObjectBase.set(this, 'video', value);

  @override
  String? get audio => RealmObjectBase.get<String>(this, 'audio') as String?;
  @override
  set audio(String? value) => RealmObjectBase.set(this, 'audio', value);

  @override
  String? get user => RealmObjectBase.get<String>(this, 'user') as String?;
  @override
  set user(String? value) => RealmObjectBase.set(this, 'user', value);

  @override
  String? get project =>
      RealmObjectBase.get<String>(this, 'project') as String?;
  @override
  set project(String? value) => RealmObjectBase.set(this, 'project', value);

  @override
  String? get projectPosition =>
      RealmObjectBase.get<String>(this, 'projectPosition') as String?;
  @override
  set projectPosition(String? value) =>
      RealmObjectBase.set(this, 'projectPosition', value);

  @override
  String? get projectPolygon =>
      RealmObjectBase.get<String>(this, 'projectPolygon') as String?;
  @override
  set projectPolygon(String? value) =>
      RealmObjectBase.set(this, 'projectPolygon', value);

  @override
  String? get orgMessage =>
      RealmObjectBase.get<String>(this, 'orgMessage') as String?;
  @override
  set orgMessage(String? value) =>
      RealmObjectBase.set(this, 'orgMessage', value);

  @override
  String? get geofenceEvent =>
      RealmObjectBase.get<String>(this, 'geofenceEvent') as String?;
  @override
  set geofenceEvent(String? value) =>
      RealmObjectBase.set(this, 'geofenceEvent', value);

  @override
  String? get locationRequest =>
      RealmObjectBase.get<String>(this, 'locationRequest') as String?;
  @override
  set locationRequest(String? value) =>
      RealmObjectBase.set(this, 'locationRequest', value);

  @override
  String? get locationResponse =>
      RealmObjectBase.get<String>(this, 'locationResponse') as String?;
  @override
  set locationResponse(String? value) =>
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
  String? get settingsModel =>
      RealmObjectBase.get<String>(this, 'settingsModel') as String?;
  @override
  set settingsModel(String? value) =>
      RealmObjectBase.set(this, 'settingsModel', value);

  @override
  int? get intDate => RealmObjectBase.get<int>(this, 'intDate') as int?;
  @override
  set intDate(int? value) => RealmObjectBase.set(this, 'intDate', value);

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
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('activityModelId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('activityType', RealmPropertyType.string, optional: true),
      SchemaProperty('date', RealmPropertyType.string, optional: true),
      SchemaProperty('userId', RealmPropertyType.string, optional: true),
      SchemaProperty('userName', RealmPropertyType.string, optional: true),
      SchemaProperty('projectId', RealmPropertyType.string,
          optional: true, indexed: true),
      SchemaProperty('projectName', RealmPropertyType.string, optional: true),
      SchemaProperty('organizationName', RealmPropertyType.string,
          optional: true),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true, indexed: true),
      SchemaProperty('photo', RealmPropertyType.string, optional: true),
      SchemaProperty('video', RealmPropertyType.string, optional: true),
      SchemaProperty('audio', RealmPropertyType.string, optional: true),
      SchemaProperty('user', RealmPropertyType.string, optional: true),
      SchemaProperty('project', RealmPropertyType.string, optional: true),
      SchemaProperty('projectPosition', RealmPropertyType.string,
          optional: true),
      SchemaProperty('projectPolygon', RealmPropertyType.string,
          optional: true),
      SchemaProperty('orgMessage', RealmPropertyType.string, optional: true),
      SchemaProperty('geofenceEvent', RealmPropertyType.string, optional: true),
      SchemaProperty('locationRequest', RealmPropertyType.string,
          optional: true),
      SchemaProperty('locationResponse', RealmPropertyType.string,
          optional: true),
      SchemaProperty('userThumbnailUrl', RealmPropertyType.string,
          optional: true),
      SchemaProperty('userType', RealmPropertyType.string, optional: true),
      SchemaProperty('translatedUserType', RealmPropertyType.string,
          optional: true),
      SchemaProperty('settingsModel', RealmPropertyType.string, optional: true),
      SchemaProperty('intDate', RealmPropertyType.int, optional: true),
    ]);
  }
}

class Timezone extends _Timezone
    with RealmEntity, RealmObjectBase, EmbeddedObject {
  Timezone({
    String? zoneName,
    int? gmtOffset,
    String? gmtOffsetName,
    String? abbreviation,
    String? tzName,
  }) {
    RealmObjectBase.set(this, 'zoneName', zoneName);
    RealmObjectBase.set(this, 'gmtOffset', gmtOffset);
    RealmObjectBase.set(this, 'gmtOffsetName', gmtOffsetName);
    RealmObjectBase.set(this, 'abbreviation', abbreviation);
    RealmObjectBase.set(this, 'tzName', tzName);
  }

  Timezone._();

  @override
  String? get zoneName =>
      RealmObjectBase.get<String>(this, 'zoneName') as String?;
  @override
  set zoneName(String? value) => RealmObjectBase.set(this, 'zoneName', value);

  @override
  int? get gmtOffset => RealmObjectBase.get<int>(this, 'gmtOffset') as int?;
  @override
  set gmtOffset(int? value) => RealmObjectBase.set(this, 'gmtOffset', value);

  @override
  String? get gmtOffsetName =>
      RealmObjectBase.get<String>(this, 'gmtOffsetName') as String?;
  @override
  set gmtOffsetName(String? value) =>
      RealmObjectBase.set(this, 'gmtOffsetName', value);

  @override
  String? get abbreviation =>
      RealmObjectBase.get<String>(this, 'abbreviation') as String?;
  @override
  set abbreviation(String? value) =>
      RealmObjectBase.set(this, 'abbreviation', value);

  @override
  String? get tzName => RealmObjectBase.get<String>(this, 'tzName') as String?;
  @override
  set tzName(String? value) => RealmObjectBase.set(this, 'tzName', value);

  @override
  Stream<RealmObjectChanges<Timezone>> get changes =>
      RealmObjectBase.getChanges<Timezone>(this);

  @override
  Timezone freeze() => RealmObjectBase.freezeObject<Timezone>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Timezone._);
    return const SchemaObject(ObjectType.embeddedObject, Timezone, 'Timezone', [
      SchemaProperty('zoneName', RealmPropertyType.string, optional: true),
      SchemaProperty('gmtOffset', RealmPropertyType.int, optional: true),
      SchemaProperty('gmtOffsetName', RealmPropertyType.string, optional: true),
      SchemaProperty('abbreviation', RealmPropertyType.string, optional: true),
      SchemaProperty('tzName', RealmPropertyType.string, optional: true),
    ]);
  }
}

class Country extends _Country with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  Country(
    ObjectId id, {
    String? name,
    String? countryId,
    int? population = 0,
    Position? position,
    String? capital,
    String? iso2,
    String? iso3,
    String? currency,
    String? currencyName,
    String? currencySymbol,
    String? region,
    String? subregion,
    double? latitude,
    double? longitude,
    String? emoji,
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<Country>({
        'population': 0,
      });
    }
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'countryId', countryId);
    RealmObjectBase.set(this, 'population', population);
    RealmObjectBase.set(this, 'position', position);
    RealmObjectBase.set(this, 'capital', capital);
    RealmObjectBase.set(this, 'iso2', iso2);
    RealmObjectBase.set(this, 'iso3', iso3);
    RealmObjectBase.set(this, 'currency', currency);
    RealmObjectBase.set(this, 'currencyName', currencyName);
    RealmObjectBase.set(this, 'currencySymbol', currencySymbol);
    RealmObjectBase.set(this, 'region', region);
    RealmObjectBase.set(this, 'subregion', subregion);
    RealmObjectBase.set(this, 'latitude', latitude);
    RealmObjectBase.set(this, 'longitude', longitude);
    RealmObjectBase.set(this, 'emoji', emoji);
  }

  Country._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

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
  String? get capital =>
      RealmObjectBase.get<String>(this, 'capital') as String?;
  @override
  set capital(String? value) => RealmObjectBase.set(this, 'capital', value);

  @override
  String? get iso2 => RealmObjectBase.get<String>(this, 'iso2') as String?;
  @override
  set iso2(String? value) => RealmObjectBase.set(this, 'iso2', value);

  @override
  String? get iso3 => RealmObjectBase.get<String>(this, 'iso3') as String?;
  @override
  set iso3(String? value) => RealmObjectBase.set(this, 'iso3', value);

  @override
  String? get currency =>
      RealmObjectBase.get<String>(this, 'currency') as String?;
  @override
  set currency(String? value) => RealmObjectBase.set(this, 'currency', value);

  @override
  String? get currencyName =>
      RealmObjectBase.get<String>(this, 'currencyName') as String?;
  @override
  set currencyName(String? value) =>
      RealmObjectBase.set(this, 'currencyName', value);

  @override
  String? get currencySymbol =>
      RealmObjectBase.get<String>(this, 'currencySymbol') as String?;
  @override
  set currencySymbol(String? value) =>
      RealmObjectBase.set(this, 'currencySymbol', value);

  @override
  String? get region => RealmObjectBase.get<String>(this, 'region') as String?;
  @override
  set region(String? value) => RealmObjectBase.set(this, 'region', value);

  @override
  String? get subregion =>
      RealmObjectBase.get<String>(this, 'subregion') as String?;
  @override
  set subregion(String? value) => RealmObjectBase.set(this, 'subregion', value);

  @override
  double? get latitude =>
      RealmObjectBase.get<double>(this, 'latitude') as double?;
  @override
  set latitude(double? value) => RealmObjectBase.set(this, 'latitude', value);

  @override
  double? get longitude =>
      RealmObjectBase.get<double>(this, 'longitude') as double?;
  @override
  set longitude(double? value) => RealmObjectBase.set(this, 'longitude', value);

  @override
  String? get emoji => RealmObjectBase.get<String>(this, 'emoji') as String?;
  @override
  set emoji(String? value) => RealmObjectBase.set(this, 'emoji', value);

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
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string,
          optional: true, indexed: true),
      SchemaProperty('countryId', RealmPropertyType.string, optional: true),
      SchemaProperty('population', RealmPropertyType.int, optional: true),
      SchemaProperty('position', RealmPropertyType.object,
          optional: true, linkTarget: 'Position'),
      SchemaProperty('capital', RealmPropertyType.string, optional: true),
      SchemaProperty('iso2', RealmPropertyType.string, optional: true),
      SchemaProperty('iso3', RealmPropertyType.string, optional: true),
      SchemaProperty('currency', RealmPropertyType.string, optional: true),
      SchemaProperty('currencyName', RealmPropertyType.string, optional: true),
      SchemaProperty('currencySymbol', RealmPropertyType.string,
          optional: true),
      SchemaProperty('region', RealmPropertyType.string, optional: true),
      SchemaProperty('subregion', RealmPropertyType.string, optional: true),
      SchemaProperty('latitude', RealmPropertyType.double, optional: true),
      SchemaProperty('longitude', RealmPropertyType.double, optional: true),
      SchemaProperty('emoji', RealmPropertyType.string, optional: true),
    ]);
  }
}

class FieldMonitorSchedule extends _FieldMonitorSchedule
    with RealmEntity, RealmObjectBase, RealmObject {
  FieldMonitorSchedule(
    ObjectId id, {
    String? fieldMonitorScheduleId,
    String? fieldMonitorId,
    String? adminId,
    String? organizationId,
    String? projectId,
    String? projectName,
    String? date,
    String? organizationName,
    int? perDay,
    int? perWeek,
    int? perMonth,
    String? userId,
  }) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'fieldMonitorScheduleId', fieldMonitorScheduleId);
    RealmObjectBase.set(this, 'fieldMonitorId', fieldMonitorId);
    RealmObjectBase.set(this, 'adminId', adminId);
    RealmObjectBase.set(this, 'organizationId', organizationId);
    RealmObjectBase.set(this, 'projectId', projectId);
    RealmObjectBase.set(this, 'projectName', projectName);
    RealmObjectBase.set(this, 'date', date);
    RealmObjectBase.set(this, 'organizationName', organizationName);
    RealmObjectBase.set(this, 'perDay', perDay);
    RealmObjectBase.set(this, 'perWeek', perWeek);
    RealmObjectBase.set(this, 'perMonth', perMonth);
    RealmObjectBase.set(this, 'userId', userId);
  }

  FieldMonitorSchedule._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

  @override
  String? get fieldMonitorScheduleId =>
      RealmObjectBase.get<String>(this, 'fieldMonitorScheduleId') as String?;
  @override
  set fieldMonitorScheduleId(String? value) =>
      RealmObjectBase.set(this, 'fieldMonitorScheduleId', value);

  @override
  String? get fieldMonitorId =>
      RealmObjectBase.get<String>(this, 'fieldMonitorId') as String?;
  @override
  set fieldMonitorId(String? value) =>
      RealmObjectBase.set(this, 'fieldMonitorId', value);

  @override
  String? get adminId =>
      RealmObjectBase.get<String>(this, 'adminId') as String?;
  @override
  set adminId(String? value) => RealmObjectBase.set(this, 'adminId', value);

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
  String? get date => RealmObjectBase.get<String>(this, 'date') as String?;
  @override
  set date(String? value) => RealmObjectBase.set(this, 'date', value);

  @override
  String? get organizationName =>
      RealmObjectBase.get<String>(this, 'organizationName') as String?;
  @override
  set organizationName(String? value) =>
      RealmObjectBase.set(this, 'organizationName', value);

  @override
  int? get perDay => RealmObjectBase.get<int>(this, 'perDay') as int?;
  @override
  set perDay(int? value) => RealmObjectBase.set(this, 'perDay', value);

  @override
  int? get perWeek => RealmObjectBase.get<int>(this, 'perWeek') as int?;
  @override
  set perWeek(int? value) => RealmObjectBase.set(this, 'perWeek', value);

  @override
  int? get perMonth => RealmObjectBase.get<int>(this, 'perMonth') as int?;
  @override
  set perMonth(int? value) => RealmObjectBase.set(this, 'perMonth', value);

  @override
  String? get userId => RealmObjectBase.get<String>(this, 'userId') as String?;
  @override
  set userId(String? value) => RealmObjectBase.set(this, 'userId', value);

  @override
  Stream<RealmObjectChanges<FieldMonitorSchedule>> get changes =>
      RealmObjectBase.getChanges<FieldMonitorSchedule>(this);

  @override
  FieldMonitorSchedule freeze() =>
      RealmObjectBase.freezeObject<FieldMonitorSchedule>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(FieldMonitorSchedule._);
    return const SchemaObject(
        ObjectType.realmObject, FieldMonitorSchedule, 'FieldMonitorSchedule', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('fieldMonitorScheduleId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('fieldMonitorId', RealmPropertyType.string,
          optional: true),
      SchemaProperty('adminId', RealmPropertyType.string, optional: true),
      SchemaProperty('organizationId', RealmPropertyType.string,
          optional: true, indexed: true),
      SchemaProperty('projectId', RealmPropertyType.string,
          optional: true, indexed: true),
      SchemaProperty('projectName', RealmPropertyType.string, optional: true),
      SchemaProperty('date', RealmPropertyType.string, optional: true),
      SchemaProperty('organizationName', RealmPropertyType.string,
          optional: true),
      SchemaProperty('perDay', RealmPropertyType.int, optional: true),
      SchemaProperty('perWeek', RealmPropertyType.int, optional: true),
      SchemaProperty('perMonth', RealmPropertyType.int, optional: true),
      SchemaProperty('userId', RealmPropertyType.string, optional: true),
    ]);
  }
}

class AppError extends _AppError
    with RealmEntity, RealmObjectBase, RealmObject {
  AppError(
    ObjectId id, {
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
    RealmObjectBase.set(this, '_id', id);
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
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, '_id', value);

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
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
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
