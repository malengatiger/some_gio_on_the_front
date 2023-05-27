import 'package:flutter/material.dart';
import 'package:geo_monitor/realm_data/data/schemas.dart';
import 'package:geo_monitor/realm_data/data/tester.dart';
import 'package:realm/realm.dart';

final config =
    Configuration.local([City.schema, Position.schema, AppError.schema]);
final realm = Realm(config);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Realm Skunkworks'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var list = <City>[];

  void _getCities() {
    createCities();
    list = getCities();
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    _getCities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      backgroundColor: Colors.brown[50],
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, index){
          var c = list.elementAt(index);
          return Card(
            elevation: 4.0,
            child: ListTile(
              title: Text(c.name!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCities,
        elevation: 16,
        tooltip: 'Increment',
        child: const Icon(Icons.search),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
