import 'package:skill_check/Ecran/ecranConnection.dart';
import 'package:flutter/material.dart';

import 'dart:async';

class EcranChargement extends StatefulWidget{
  @override
  EcranChargementEtat createState() => EcranChargementEtat();
}

class EcranChargementEtat extends State<EcranChargement>{

  Timer timer;
  FlutterLogoStyle logo = FlutterLogoStyle.markOnly;

  EcranChargementEtat(){
  timer = new Timer(const Duration(seconds: 2), (){
    setState(() {
      logo = FlutterLogoStyle.horizontal;
    });
  });
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Container(
            child: new FlutterLogo(
              size: 200.0, style: logo
            ),
          ),
        ),
      ),
    );

  }

  @override void initState() {
    super.initState();
    onStart();
  }

  void onStart() async{
    await Future.delayed(Duration(seconds: 5)); //chargement();
    Navigator.push(context, SlideRightRoute(page: EcranConnection()));
  }

  void chargement(){
    Future.delayed(Duration(seconds: 5));
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
        );
}