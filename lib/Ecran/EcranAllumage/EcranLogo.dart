import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:skill_check/Ecran/ecranConnection.dart';

import 'dart:async';

class EcranLogo extends StatefulWidget
{
  @override
  EcranLogoEtat createState() => EcranLogoEtat();
}

class EcranLogoEtat extends State<EcranLogo>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
            body: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 30.0),
                      Container(
                        alignment: Alignment.center,
                        width: 190.0,
                        height: 190.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/images/logo.jpg"),
                          ),   
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 190,
                        height: 190,
                        child: Text("TITRE ICI",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Kufam',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

    @override void initState() {
    super.initState();
    onStart();
  }

  void onStart() async{
    await Future.delayed(Duration(milliseconds: 3600));
          Navigator.push(
            context,
          MaterialPageRoute(builder: (context) => EcranConnection()),
          );
  }

}