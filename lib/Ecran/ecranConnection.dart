//import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:skill_check/Ecran/Loaders/LoaderCompetencesEleve.dart';
import 'package:skill_check/Ecran/Loaders/LoaderListEleve.dart';
import 'package:skill_check/Ecran/ecranInscription.dart';
import 'package:flutter/material.dart';
import 'package:skill_check/Utilitaires/constantes.dart';
import 'package:skill_check/Utilitaires/liens.dart';
import 'package:http/http.dart' as http;

import 'package:progress_dialog/progress_dialog.dart';


class EcranConnection extends StatefulWidget {
  @override
  EcranConnectionEtat createState() => EcranConnectionEtat();
  }

class EcranConnectionEtat extends State<EcranConnection>{

  // variables pour les text input
  final emailController = TextEditingController();
  final motDePasseController = TextEditingController();
	
  //variable non utilisée (checkbox rappel)
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
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller:emailController,
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

  Widget constructeurMDP(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Mot de passe',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: motDePasseController,
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
      ],
    );
  }

//widgets non utilisé pour le moment
/*--------------------------------------------------------------------*/
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

/*--------------------------------------------------------------------*/

  Widget constructeurBouttonConnexion(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: userLogin,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: Colors.cyan[900],
        child:Text(
          'CONNEXION',
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
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          Navigator.push(
            context,
            SlideRightRoute(page : EcranInscription()),
          );
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
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

  @override
  Widget build(BuildContext context){
    return WillPopScope(
      onWillPop: () async => false,
      child:Scaffold(
        body: Stack(children: <Widget>[
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
                    'SkillChecker',
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
                  SizedBox(height : 50.0),
                  //constructeurMDPOublie(),
                  //constructeurRappel(),
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
    ),
  );
 }

  /// Fonction gérant la communication avec le serveur
 Future userLogin() async{

  var conect = await Connectivity().checkConnectivity();

  // vérification de la connection du téléphone
  if (conect != ConnectivityResult.none){
  
    String email = emailController.text;
    String motDePasse = motDePasseController.text;

    if (email.isEmpty | motDePasse.isEmpty)
      popdial(context, "une des entrées est vide, veuillez la remplir");

    else{

      final ProgressDialog pr = progressdial(context, 'Connection en cours...');
      await pr.show();

      var url = login;
      var data = {'email': email, 'motDePasse' : motDePasse };
      var response = await http.post(url, body: json.encode(data));
      var message = jsonDecode(response.body);

      await pr.hide();

    if(message != "-1")
      {
        String status;
        if (message["status"] == "1")
        {
          status = "Professeur";
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Loader(
              statusString : status,
              profil: message,
              )
            )
          );
        }
        else
        {
          status = "Éleve";
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoaderCompetencesEleve(
              status : status,
              profil: message,
              )
            )
          );
        }      
      }
      else
      {
        await pr.hide();

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text("ERREUR DE CONNECTION\n avez-vous un compte?"),
              actions: <Widget>[
                FlatButton(
                  child: Text("OUI"),
                  onPressed: () { Navigator.of(context).pop(); },
                ),
                FlatButton(
                  child: new Text("NON"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => new EcranInscription()),
                    );
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }
  else
  {
    popdial(context, "vous n'êtes pas connecté à internet!");
  }
 
}

}
  

/// Classe gérant l'animation de transition sur l'écran d'inscription

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