import 'package:flutter/material.dart';
import 'package:geo_monitor/library/bloc/old_to_realm.dart';
import 'package:geo_monitor/library/functions.dart';
import 'package:geo_monitor/library/utilities/sharedprefs.dart';
import 'package:geo_monitor/realm_data/data/schemas.dart' as mrm;
import 'package:badges/badges.dart' as bd;
import 'package:realm/realm.dart';
import '../initializer.dart';
import '../library/api/prefs_og.dart';
import 'data/realm_sync_api.dart';

class TestRealmSync extends StatefulWidget {
  const TestRealmSync({Key? key}) : super(key: key);

  @override
  TestRealmSyncState createState() => TestRealmSyncState();
}

class TestRealmSyncState extends State<TestRealmSync> {
  final mm = '🔶🔶🔶🔶🔶🔶TestRealmSync: ';
  var list = <mrm.SettingsModel>[];

  @override
  void initState() {
    super.initState();
    _init();
  }

  RealmResults<mrm.SettingsModel>? query;
  late mrm.SettingsModel sett;

  _init() async {
    setState(() {
      busy = true;
    });
    await initializer.initializeGioServices();
    var x = await prefsOGx.getSettings();
    sett = OldToRealm.getSettings(x);
    // _getData();
    query = realmSyncApi.getSettingsQuery(sett.organizationId!);
    pp('$mm organizationId: ${sett.organizationId}');
    setState(() {
      busy = false;
    });
  }

  _addSetting() {
    var s = mrm.SettingsModel(ObjectId(),
        organizationId: sett.organizationId,
        created: DateTime.now().toIso8601String(),
        locale: 'fr',
        themeIndex: 1,
        refreshRateInMinutes: 5,
        projectId: null,
        translatedTitle: 'Test of Sync',
        translatedMessage: 'A widget to learn about Realm sync',
        settingsId: '973484982379',
        activityStreamHours: 78,
        distanceFromProject: 8,
        maxAudioLengthInMinutes: 878,
        maxVideoLengthInSeconds: 240,
        organizationName: 'Some Org',
        photoSize: 1,
        numberOfDays: 8);
    realmSyncApi.addSettings([s]);
    //_getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Realm Syncer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: busy? const Center(
          child: SizedBox(width: 32, height: 32, child: CircularProgressIndicator(
            strokeWidth: 6, backgroundColor: Colors.pink,
          ),),
        ): Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: StreamBuilder<RealmResultsChanges<mrm.SettingsModel>>(
              stream: query?.changes,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                pp('$mm query stream has fired: snapshot: $snapshot');
                if (snapshot.hasData) {
                  pp('$mm snapshot has data! 🍎🍎 ${snapshot.data}');
                  var m = snapshot.data as RealmResultsChanges<mrm.SettingsModel>;
                  pp('$mm length: ${m.results.length}');
                  pp('$mm last: ${m.results.last.created}');
                  pp('$mm first: ${m.results.first.created}');
                  list.clear();
                  for (var element in m.results) {
                    list.add(element);
                  }
                  list.sort((a,b) => b.created!.compareTo(a.created!));
                } else {
                  pp('$mm snapshot has NO data!');

                }
                var cnt = list.length;
                return bd.Badge(
                  badgeContent: Text('${list.length}'),
                  position: bd.BadgePosition.topEnd(),
                  badgeAnimation: const bd.BadgeAnimation.rotation(),
                  child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (ctx, index) {
                        var sett = list.elementAt(index);
                        return Card(
                          shape: getRoundedBorder(radius: 16),
                          elevation: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('${sett.created}'),
                          ),
                        );
                      }),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addSetting();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
