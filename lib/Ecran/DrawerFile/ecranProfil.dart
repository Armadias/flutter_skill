import 'package:skill_check/Ecran/DrawerFile/ecranAccueil.dart';
import 'package:skill_check/Ecran/ecranInscription.dart';
import 'package:skill_check/Utilitaires/drawer.dart';
import 'package:flutter/material.dart';
import 'package:skill_check/Utilitaires/constantes.dart';

class EcranProfil extends StatefulWidget {
  @override
  EcranProfilEtat createState() => EcranProfilEtat();
  }

class EcranProfilEtat extends State<EcranProfil>{

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

    Widget constructeurImageProfil(){
    return Container(
                  alignment: Alignment.center,
                  width: 190.0,
                  height: 190.0,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new NetworkImage(
                      "https://i.imgur.com/BoN9kdC.png")
                    )
                  )
    );
    }

    Widget constructeurChangerMail(){
    return  Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(onPressed: () => print('Mail changé appuillé'),
                  padding: EdgeInsets.only(right: 0.0),
                  child: Text(
                    'Changer Email',
                    style: kLabelStyle,
                    ),
                  ),
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

  Widget constructeurChangerMDP(){
    return  Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(onPressed: () => print('Mot de passe changé appuillé'),
                  padding: EdgeInsets.only(right: 0.0),
                  child: Text(
                    'Changer Mot de Passe',
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
                        MaterialPageRoute(builder: (context) => EcranAccueil(mail : "")),
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
      appBar: AppBar(
            title: Text('Profil',
            style: kLabelStyle,
            ),
          ),
      drawer: CustomDrawer(mail : ""),
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
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 120.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Votre Profil',
                  style: TextStyle(
                    color :Colors.white,
                    fontFamily: 'Kufam', 
                    fontSize: 30.0, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30.0),
                constructeurImageProfil(),
                SizedBox(height: 10.0),
                constructeurEmail(),
                constructeurChangerMail(),
                SizedBox(height: 30.0),
                constructeurMDP(),
                constructeurChangerMDP(),
              ],
            ),
          ),
        ),
      ],
    ),
  );
 }
  
}