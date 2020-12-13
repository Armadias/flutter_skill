//import 'dart:async';
import 'dart:convert';

import 'package:skill_check/Ecran/Loaders/LoaderCompetencesEleve.dart';
import 'package:skill_check/Ecran/Loaders/LoaderListEleve.dart';
import 'package:skill_check/Ecran/ecranInscription.dart';
import 'package:flutter/material.dart';
import 'package:skill_check/Utilitaires/constantes.dart';
import 'package:http/http.dart' as http;

import 'package:progress_dialog/progress_dialog.dart';


class EcranConnection extends StatefulWidget {
  @override
  EcranConnectionEtat createState() => EcranConnectionEtat();
  }

class EcranConnectionEtat extends State<EcranConnection>{

  final emailController = TextEditingController();
  final motDePasseController = TextEditingController();
	
Future userLogin() async{
 
 
  // Getting value from Controller
  String email = emailController.text;
  String motDePasse = motDePasseController.text;
  String nomPrenom;
  if (email.isEmpty | motDePasse.isEmpty)
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
    final ProgressDialog pr =  ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.style(
  message: 'Connection en cours...',
  borderRadius: 20.0,
  backgroundColor: Colors.white,
  progressWidget: CircularProgressIndicator(),
  elevation: 50.0,
  insetAnimCurve: Curves.easeInOut,
  messageTextStyle: TextStyle(
     color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
  );
  await pr.show();
  // SERVER LOGIN API URL
  var url = 'https://flagrant-amusements.000webhostapp.com/login_user.php';
 
  // Store all data with Param Name.
  var data = {'email': email, 'motDePasse' : motDePasse, 'nomPrenom' : nomPrenom};
 
  // Starting Web API Call.
  var response = await http.post(url, body: json.encode(data));
 
  // Getting Server response into variable.
  var message = jsonDecode(response.body);

  await pr.hide();
  // If the Response Message is Matched.
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
    // Navigate to Profile Screen & Sending Email to Next Screen.

      
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
    );}
  }
 
}
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
                    controller: motDePasseController,
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
                  //padding: EdgeInsets.symmetric(vertical: 2.0),
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