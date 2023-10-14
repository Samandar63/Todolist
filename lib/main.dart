import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/home_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

void main() async{
  // init Hive 
  await Hive.initFlutter();
  
  // open a box
  var box = await Hive.openBox("mybox");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),

    );
  }
}