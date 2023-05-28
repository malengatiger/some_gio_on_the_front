// import 'package:flutter/material.dart';
// import 'package:geo_monitor/realm_data/data/schemas.dart';
// import 'package:geo_monitor/realm_data/data/tester.dart';
// import 'package:realm/realm.dart';
//
// final config =
//     Configuration.local([City.schema, Position.schema, AppError.schema]);
// final realm = Realm(config);
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Realm Skunkworks'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   var list = <City>[];
//
//   void _getCities() {
//     createCities();
//     list = getCities();
//     setState(() {
//
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _getCities();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       backgroundColor: Colors.brown[50],
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: ListView.builder(
//             itemCount: list.length,
//             itemBuilder: (_, index){
//           var c = list.elementAt(index);
//           return Card(
//             elevation: 4.0,
//             child: ListTile(
//               title: Text(c.name!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
//             ),
//           );
//         }),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _getCities,
//         elevation: 16,
//         tooltip: 'Increment',
//         child: const Icon(Icons.search),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_monitor/initializer.dart';
import 'package:geo_monitor/library/bloc/isolate_handler.dart';
import 'package:geo_monitor/library/bloc/organization_bloc.dart';
import 'package:geo_monitor/library/bloc/project_bloc.dart';
import 'package:geo_monitor/library/functions.dart';
import 'package:geo_monitor/realm_data/data/schemas.dart';
import 'package:geo_monitor/splash/splash_page.dart';
import 'package:geo_monitor/stitch/stitch_service.dart';
import 'package:geo_monitor/ui/dashboard/dashboard_main.dart';
import 'package:geo_monitor/ui/intro/intro_main.dart';
import 'package:page_transition/page_transition.dart';
import 'package:realm/realm.dart';
import 'package:universal_platform/universal_platform.dart';

import 'firebase_options.dart';
import 'library/api/data_api_og.dart';
import 'library/api/prefs_og.dart';
import 'library/bloc/cloud_storage_bloc.dart';
import 'library/bloc/fcm_bloc.dart';
import 'library/bloc/geo_uploader.dart';
import 'library/bloc/refresh_bloc.dart';
import 'library/bloc/theme_bloc.dart';
import 'library/cache_manager.dart';
import 'library/emojis.dart';

int themeIndex = 0;
var locale = const Locale('en');
late FirebaseApp firebaseApp;
fb.User? fbAuthedUser;
final mx =
    '${E.heartGreen}${E.heartGreen}${E.heartGreen}${E.heartGreen} main: ';
final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
  pp('$mx initializeGioServices: '
      ' Firebase App has been initialized: ${firebaseApp.name}, checking for authed current user');
  fbAuthedUser = fb.FirebaseAuth.instance.currentUser;

  // runApp(ProviderScope(
  //     child: DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (BuildContext context) {
  //     return const GeoApp();
  //   },
  // )));
  runApp(const ProviderScope(child: GeoApp()));
}

void testRealmJson() {
  AppError ae = AppError(id: ObjectId(), errorMessage: 'some error',
      manufacturer: 'Apple', brand: 'iPhone 11 Pro', created: DateTime.now().toUtc().toIso8601String(),
      userName: 'Aubrey',
      errorPosition: Position(coordinates: [76.85876, -73.79865]));

  City c = City(ObjectId(),
      cityId: 'ii1324',
      name: "Pecanwood",
      created: DateTime.now().toUtc().toIso8601String(),
      country: 'mZantsi',
      countryId: 'iutoyto98y',
      province: 'Gauteng',
      cityLocation: Position(coordinates: [76.85876, -73.79865]));

  var map = c.toJson();
  var map2 = ae.toJson();
  pp('\n\n ........ 🔵🔵🔵🔵🔵🔵 TESTING REALM  🔵🔵🔵🔵🔵🔵');
  pp('🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵 city json map:  🌸🌸 $map');
  pp('🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵 appError json map:  🍎🍎🍎 $map2');

  pp('🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵 city json map:  🌸🌸 ${map['cityLocation']}');

  City d = CityJ.fromJson(map);
  AppError dx = AppErrorJ.fromJson(map2);

  pp('🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵 city map produced json:  🌸🌸 ${d.toJson()}');
  pp('🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵 appError map produced json:  🍎🍎🍎 ${dx.toJson()}');
  pp('\n\n DONE WITH REALM !!');

}

class GeoApp extends ConsumerWidget {
  const GeoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        pp('$mx 🌀🌀🌀🌀 Tap detected; should dismiss keyboard ...');
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: StreamBuilder<LocaleAndTheme>(
        stream: themeBloc.localeAndThemeStream,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            pp('${E.check}${E.check}${E.check}'
                'build: theme index has changed to ${snapshot.data!.themeIndex}'
                '  and locale is ${snapshot.data!.locale.toString()}');
            themeIndex = snapshot.data!.themeIndex;
            locale = snapshot.data!.locale;
            pp('${E.check}${E.check}${E.check} GeoApp: build: locale object received from stream: $locale');
          }

          return MaterialApp(
            // useInheritedMediaQuery: true,
            // locale: DevicePreview.locale(context),
            // builder: DevicePreview.appBuilder,
            scaffoldMessengerKey: rootScaffoldMessengerKey,
            debugShowCheckedModeBanner: false,
            title: 'Gio',
            theme: themeBloc.getTheme(themeIndex).lightTheme,
            darkTheme: themeBloc.getTheme(themeIndex).darkTheme,
            themeMode: ThemeMode.system,
            // home:  const DroneMain()
            home: AnimatedSplashScreen(
              duration: 5000,
              splash: const SplashWidget(),
              animationDuration: const Duration(milliseconds: 3000),
              curve: Curves.easeInCirc,
              splashIconSize: 160.0,
              nextScreen: LandingPage(prefsOGx: PrefsOGx()),
              splashTransition: SplashTransition.fadeTransition,
              pageTransitionType: PageTransitionType.leftToRight,
              backgroundColor: Colors.pink.shade900,
            ),
          );
        },
      ),
    );
  }
}

late StreamSubscription killSubscriptionFCM;

void showKillDialog({required String message, required BuildContext context}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      title: Text(
        "Critical App Message",
        style: myTextStyleLarge(ctx),
      ),
      content: Text(
        message,
        style: myTextStyleMedium(ctx),
      ),
      shape: getRoundedBorder(radius: 16),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            pp('$mm Navigator popping for the last time, Sucker! 🔵🔵🔵');
            var android = UniversalPlatform.isAndroid;
            var ios = UniversalPlatform.isIOS;
            if (android) {
              SystemNavigator.pop();
            }
            if (ios) {
              Navigator.of(ctx).pop();
              Navigator.of(ctx).pop();
            }
          },
          child: const Text("Exit the App"),
        ),
      ],
    ),
  );
}

StreamSubscription<String> listenForKill({required BuildContext context}) {
  pp('\n$mx Kill message; listen for KILL message ...... 🍎🍎🍎🍎 ......');

  var sub = fcmBloc.killStream.listen((event) {
    pp('$mm Kill message arrived: 🍎🍎🍎🍎 $event 🍎🍎🍎🍎');
    try {
      showKillDialog(message: event, context: context);
    } catch (e) {
      pp(e);
    }
  });

  return sub;
}

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key, required this.prefsOGx}) : super(key: key);

  final PrefsOGx prefsOGx;

  @override
  State<LandingPage> createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  final mx = '🔵🔵🔵🔵🔵🔵 LandingPage 🔵🔵';
  bool busy = false;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future initialize() async {
    pp('$mx ...................... initialize .............🍎🍎🍎');
    final start = DateTime.now();
    setState(() {
      busy = true;
    });

    try {
      final user = await widget.prefsOGx.getUser();
      if (user != null) {
        await initializer.setupGio();
        final end = DateTime.now();
        pp('$mx ................. initialization took: 🔆 ${end.difference(start).inMilliseconds} inMilliseconds 🔆');
      } else {
        await initializer.initializeGioServices();
        fbAuthedUser = null;
      }
    } catch (e) {
      pp(e);
      showSnackBar(message: 'Initialization failed', context: context);
    }

    setState(() {
      busy = false;
    });
  }

  Widget getWidget() {
    if (busy) {
      pp('$mx getWidget: BUSY! returning empty sizeBox because initialization is still going on ...');
      return const Center(
          child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(),
      ));
    }
    if (fbAuthedUser == null) {
      pp('$mx getWidget returning widget IntroMain ..(fbAuthedUser == null)');
      return IntroMain(
        prefsOGx: prefsOGx,
        dataApiDog: dataApiDog,
        cacheManager: cacheManager,
        isolateHandler: dataHandler,
        fcmBloc: fcmBloc,
        refreshBloc: refreshBloc,
        organizationBloc: organizationBloc,
        projectBloc: projectBloc,
        geoUploader: geoUploader,
        stitchService: stitchService,
        cloudStorageBloc: cloudStorageBloc,
        firebaseAuth: FirebaseAuth.instance,
      );
    } else {
      pp('$mx getWidget returning widget DashboardMain ..(fbAuthedUser == ✅)');
      return DashboardMain(
        dataHandler: dataHandler,
        dataApiDog: dataApiDog,
        fcmBloc: fcmBloc,
        projectBloc: projectBloc,
        prefsOGx: prefsOGx,
        refreshBloc: refreshBloc,
        firebaseAuth: FirebaseAuth.instance,
        cloudStorageBloc: cloudStorageBloc,
        stitchService: stitchService,
        geoUploader: geoUploader,
        organizationBloc: organizationBloc,
        cacheManager: cacheManager,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    pp('$mx build method starting ....');
    return SafeArea(
        child: Scaffold(
      body: busy
          ? Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: Image.asset(
                  'assets/gio.png',
                  height: 120,
                  width: 100,
                ),
              ),
            )
          : getWidget(),
    ));
  }
}
