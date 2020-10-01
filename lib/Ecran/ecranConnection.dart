//import 'dart:async';
//import 'dart:convert';

import 'package:skill_check/Ecran/DrawerFile/ecranAccueil.dart';
import 'package:skill_check/Ecran/ecranInscription.dart';
import 'package:flutter/material.dart';
import 'package:skill_check/Utilitaires/constantes.dart';
//import 'package:http/http.dart' as http;

class EcranConnection extends StatefulWidget {
  @override
  EcranConnectionEtat createState() => EcranConnectionEtat();
  }

class EcranConnectionEtat extends State<EcranConnection>{

TextEditingController password=new TextEditingController();
TextEditingController email=new TextEditingController();

/*Future<List> senddata() async {
  final response = await http.post("https://flagrant-amusements.000webhostapp.com/insertData.php", body: {
    "password": password.text,
    "email": email.text,
  });
}*/
  bool rappel = false;
  
  Widget constructeurEmail(){
    return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                    Text(
                      'Email',
                      style: kLabelStyle,
                    ),
                  SizedBox(height: 10.0),
                  Container(alignment: Alignment.centerLeft,
                  decoration: kBoxDecorationStyle,
                  height: 60.0,
                  child: TextField(
                    controller:email,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Colors.white,
                       fontFamily: 'Kufam',
                        fontSize: 13.0),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 18.0),
                      prefixIcon: Icon(
                        Icons.email, 
                        color: Colors.white,
                      ),
                      hintText: 'Entrez votre adresse ici',
                      hintStyle: kHintTextStyle,
                    ),
                    ),
                  ),
                 ],
                );
  }

  Widget constructeurMDP(){
    return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                  Text(
                    'Mot de passe',
                    style: kLabelStyle,
                  ),
                  SizedBox(height: 10.0),
                  Container(alignment: Alignment.centerLeft,
                  decoration: kBoxDecorationStyle,
                  height: 60.0,
                  child: TextField(
                    controller: password,
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.white,
                       fontFamily: 'Kufam',
                        fontSize: 13.0),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 18.0),
                      prefixIcon: Icon(
                        Icons.lock, 
                        color: Colors.white,
                      ),
                      hintText: 'Entrez votre mot de passe ici',
                      hintStyle: kHintTextStyle,
                    ),
                    ),
                  ),
                 ],
                );
  }

  Widget constructeurMDPOublie(){
    return  Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(onPressed: () => print('Mot de passe oublié appuillé'),
                  padding: EdgeInsets.only(right: 0.0),
                  child: Text(
                    'Mot de passe oublié?',
                    style: kLabelStyle,
                    ),
                  ),
                  );
  }

  Widget constructeurRappel(){
    return Container(
                  child: Row(
                    children: <Widget>[
                      Theme(
                        data: ThemeData(unselectedWidgetColor: Colors.white),
                        child: Checkbox(
                          value: rappel,
                          checkColor: Colors.green,
                          activeColor: Colors.white,
                          onChanged: (value){
                            setState(() {
                              rappel = value;
                            });
                          },
                        ),
                      ),
                       Text(
                          'Rappel',
                          style: kLabelStyle,
                      ),
                    ],
                  ),
                );
  }

  Widget constructeurBouttonConnexion(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () { 
          print('login appuillé');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EcranAccueil()),
          );
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: Colors.deepOrangeAccent,
        child:Text(
          'CONNEXION',
          style: TextStyle(
            color: Colors.white70,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Kufam',
          ),
        ),
      ),
    );
  }

  Widget constructeurMessage(){
    return Container(
                  child: Text(
                    'Pas de compte?',
                    style: kLabelStyle,
                  ),
                );
  }
  
  Widget constructeurBoutonCreeCompte() {
    return Container(
                  //padding: EdgeInsets.symmetric(vertical: 2.0),
                  width: double.infinity,
                  child: RaisedButton(
                    elevation: 5.0,
                    onPressed: () { 
                      print('login appuillé');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EcranInscription()),
                      );
                    },
                    padding: EdgeInsets.all(15.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    color: Colors.deepOrangeAccent,
                    child:Text(
                      'INSCRIPTION',
                      style: TextStyle(
                        color: Colors.white70,
                        letterSpacing: 1.5,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Kufam',
                      ),
                    ),
                  ),
                );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.red,
                Colors.orange,
                Colors.orangeAccent,
                Colors.deepOrange,
            ],
            stops: [0.1,0.4,0.7,0.9],
            ),
          ),
        ),
        Container(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 120.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: <Widget>[
                Text(
                  'Perfectatorminal',
                  style: TextStyle(
                    color :Colors.white,
                    fontFamily: 'Kufam', 
                    fontSize: 30.0, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height : 17.0),
                Text(
                  'Connexion',
                  style: TextStyle(
                    color :Colors.white,
                    fontFamily: 'Kufam', 
                    fontSize: 25.0, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                constructeurEmail(),
                SizedBox(height: 30.0),
                constructeurMDP(),
                constructeurMDPOublie(),
                constructeurRappel(),
                constructeurBouttonConnexion(),
                SizedBox(height: 30.0),
                constructeurMessage(),
                constructeurBoutonCreeCompte(),
              ],
            ),
          ),
        ),
      ],
    ),
  );
 }
  
}