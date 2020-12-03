import 'package:flutter/material.dart';	
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:skill_check/Ecran/ecranConnection.dart';

import 'package:skill_check/Utilitaires/constantes.dart';
import 'package:skill_check/Ecran/DrawerFile/ecranAccueil.dart';

class EcranInscription extends StatefulWidget {
  @override
  EcranInscriptionEtat createState() => EcranInscriptionEtat();
  }


class EcranInscriptionEtat extends State<EcranInscription> {

  bool visible = false;

  final nomPrenomController = TextEditingController();
  final emailController = TextEditingController();
  final motDePasseController = TextEditingController();

  Future userRegistration() async {

    setState(() {
      visible = true;
    });

    String nomPrenom = nomPrenomController.text;
    String email = emailController.text;
    String motDePasse = motDePasseController.text;

    if (email.isEmpty | nomPrenom.isEmpty |motDePasse.isEmpty)
  {
    showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("une des entrées est vide, veuillez la remplir"),
        actions: <Widget>[
          FlatButton(
           child: Text("Ok"),
           onPressed: () { Navigator.of(context).pop(); },
           ),
        ],
      );
    },
    );
  }
  else{

    var url = 'https://flagrant-amusements.000webhostapp.com/register_user.php';
    var data = {'nomPrenom': nomPrenom, 'email': email, 'motDePasse': motDePasse};
    var response = await http.post(url, body: json.encode(data));
    print(response);
    var message = jsonDecode(response.body);

    if(response.statusCode == 200){
    setState(() {
      visible = false;
    });
    }


    showDialog(
      context:context,
      builder: (BuildContext context){
        return AlertDialog(
          title: new Text(message),
          actions: <Widget>[
            FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  if(message == "C'est bon tu est inscrit frérot ! Génial non !?"){
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                    MaterialPageRoute(builder: (context) => EcranAccueil()),
                    );
                  }else if(message == "Soit t'es déjà inscrit, soit quelqu\'un à déjà créé un compte avec cette adresse..."){
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                    MaterialPageRoute(builder: (context) => EcranInscription()),
                    );
                  }
                  
                },
            ),
          ],
        );
      },
    );
  }
  }

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
            //keyboardType: TextInputType.emailAddress,
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
            //keyboardType: TextInputType.text,
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
      // en commentaire car c'est casse pieds pour le moment
      /*Text(
        'Confirmation du mot de passe',
        style: kLabelStyle,
      ),
      SizedBox(height: 10.0),
        Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 60.0,
        child: TextField(
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
          hintText: 'Confirmez votre mot de passe ici',
          hintStyle: kHintTextStyle,
        ),
      ),
    ),*/
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
        color: Colors.deepOrangeAccent,
        child:Text(
          'RETOUR',
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
  Widget build(BuildContext context) {
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
          )
        ],
      ),
    );
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