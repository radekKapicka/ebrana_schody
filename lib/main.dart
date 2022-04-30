import 'package:ebrana_schody/pages/navpages/main_page.dart';
import 'package:ebrana_schody/pages/test_pedo.dart';
import 'package:ebrana_schody/pages/welcome_page.dart';
import 'package:ebrana_schody/root.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'eBRANA schody',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: RootWidget()
    );
  }
}