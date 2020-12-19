import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';	
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skill_check/Ecran/DrawerFile/ecranProfil.dart';
import 'package:skill_check/Ecran/ecranConnection.dart';

import 'package:skill_check/Utilitaires/constantes.dart';
import 'package:skill_check/Utilitaires/liens.dart';

class EcranInscription extends StatefulWidget {
  @override
  EcranInscriptionEtat createState() => EcranInscriptionEtat();
  }


class EcranInscriptionEtat extends State<EcranInscription> {

  final nomPrenomController = TextEditingController();
  final emailController = TextEditingController();
  final motDePasseController = TextEditingController();

  Widget constructeurEmail(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: emailController,
            autocorrect: true,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Kufam',
              fontSize: 13.0
            ),
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

  Widget constructeurUtilisateur(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Nom d\'utilisateur',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: nomPrenomController,
            autocorrect: true,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Kufam',
              fontSize: 13.0
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 18.0),
              prefixIcon: Icon(
                Icons.people, 
                color: Colors.white,
              ),
            hintText: 'Entrez votre nom d\'utilisateur ici',
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
            controller: motDePasseController,
            autocorrect: true,
            obscureText: true,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Kufam',
              fontSize: 13.0
            ),
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
        SizedBox(height: 20.0),
      ],
    );              
  }

  Widget constructeurBoutton(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: userRegistration,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: Colors.cyan[900],
        child:Text(
          'INSCRIPTION',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Kufam',
          ),
        ),
      ),
    );
  }

    Widget constructeurBouttonRetrun(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          Navigator.push(
            context,
            SlideRightRoute(page : EcranConnection()),
          );
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: Colors.cyan[900],
        child:Text(
          'RETOUR',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Kufam',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          colorGradient,
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
                    'Inscription',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Kufam',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  SizedBox(height: 40.0),
                  constructeurEmail(),
                  SizedBox(height: 20.0),
                  constructeurUtilisateur(),
                  SizedBox(height: 20.0),
                  constructeurMDP(),
                  SizedBox(height: 20.0),
                  constructeurBoutton(),
                  SizedBox(height: 20.0),
                  constructeurBouttonRetrun(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///fonction d'appel du serveur
  Future userRegistration() async {

    String nomPrenom = nomPrenomController.text;
    String email = emailController.text;
    String motDePasse = motDePasseController.text;

    var conect = await Connectivity().checkConnectivity();

    if (conect != ConnectivityResult.none){
      
      if (email.isEmpty | nomPrenom.isEmpty |motDePasse.isEmpty)
        popdial(context, "une des entrées est vide, veuillez la remplire");
    
      else{

        var url = register;
        var data = {'nomPrenom': nomPrenom, 'email': email, 'motDePasse': motDePasse};
        var response = await http.post(url, body: json.encode(data));
        var message = jsonDecode(response.body);

        String text;
        if (message != '-1')
        {
          text = "Inscription Réussie!";
        }
        else text = "Erreur lors de l'inscription";
        showDialog(
          context:context,
          builder: (BuildContext context){
            return AlertDialog(
              title: new Text(text),
              actions: <Widget>[
                FlatButton(
                  child: new Text("OK"),
                  onPressed: () {
                    if(message != "-1"){
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => 
                        EcranProfil(
                          status: "Eleve",
                          profil: message,
                        )
                        ),
                      );
                    }
                    else
                    {
                      Navigator.of(context).pop();
                    } 
                  },
                ),
              ],
            );
          },
        );
      }
    }
    else
    popdial(context, "vous n'êtes pas connecté à internet!");
  }
}


//classe de transition
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