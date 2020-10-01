import 'package:flutter/material.dart';
import 'package:skill_check/Ecran/ecranConnection.dart';
/// *******************************https://trello.com/b/eptS0fbm********************************/

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App Projet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.deepOrange), 
      home: EcranConnection(),
    );
  }
} 