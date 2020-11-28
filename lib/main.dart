import 'package:flutter/material.dart';
import 'package:skill_check/Ecran/EcranAllumage/AnimationScreen.dart';
import 'package:skill_check/Ecran/EcranAllumage/EcranLogo.dart';
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
      home: EcranStart(),
    );
  }
} 


class EcranStart extends StatefulWidget {
  @override
  _EcranStartState createState() => _EcranStartState();
}

class _EcranStartState extends State<EcranStart> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          Scaffold(
            body: EcranLogo()
          ),
          IgnorePointer(
            child: AnimationScreen(
              color: Theme.of(context).accentColor
            )
          )
        ]
      )
    );
  }
}
