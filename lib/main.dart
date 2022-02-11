import 'dart:io';

import 'package:cmlw_labour_registration/pages/districts.dart';
import 'package:cmlw_labour_registration/pages/labours.dart';
import 'package:cmlw_labour_registration/layouts/partials/tile.dart';
import 'package:cmlw_labour_registration/services/labourServices.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home:const MyHomePage(title: 'Dashboard'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            getTile("Labours Registered: 200",()=>{}),
            getTile("Register Labour",()=>{
              Navigator.push(context, MaterialPageRoute(builder: (context)=>DistrictPage()))
            }),
            getTile("Registered Labours",()=>{
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LaboursPage()))
            }),
            getTile("Export Labour CSV File",()async{
              LabourService labourService = new LabourService();
              List<List<dynamic>> list = await labourService.exportList();
              //print(list);
              getCsv(list);
              //String csv = const ListToCsvConverter().convert([["Munawar","Aman","Usama"],["CO","Sub Engr","CO"]]);
              //print(csv.runtimeType);
              //Navigator.push(context, MaterialPageRoute(builder: (context)=>const Sync()))
            })
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  getCsv(List<List<dynamic>> data) async {
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
    String appDocumentsPath = (await getExternalStorageDirectory())!.path;
    String filePath = '$appDocumentsPath/labours.csv';
    String csv = const ListToCsvConverter().convert(data);
    File file = File(filePath); // 1
    file.writeAsString(csv);
    /*
    String dir = (await getExternalStorageDirectory())!.path + "/CMLW_Labours/labours.csv";
    String file = "$dir";
    print(" FILE " + file);
    File f = new File(file);*/

// convert rows to String and write as csv file
/*
    String csv = const ListToCsvConverter().convert(data);
    f.writeAsString(csv);*/
    /*var status = await Permission.storage.status;
    if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
    }*/
/*
// You can request multiple permissions at once.
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();*/
    //print(statuses[Permission.storage]);

/*
// You can can also directly ask the permission about its status.
    if (await Permission.location.isRestricted) {
      // The OS restricts access, for example because of parental controls.
    }
    await SimplePermissions.requestPermission(Permission. WriteExternalStorage);
    bool checkPermission=await SimplePermissions.checkPermission(Permission.WriteExternalStorage);
    if(checkPermission) {

//store file in documents folder

      String dir = (await getExternalStorageDirectory()).absolute.path + "/documents";
      file = "$dir";
      print(LOGTAG+" FILE " + file);
      File f = new File(file+"filename.csv");

// convert rows to String and write as csv file

      String csv = const ListToCsvConverter().convert(rows);
      f.writeAsString(csv);
    }*/
  }
}
