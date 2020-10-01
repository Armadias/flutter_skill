import 'package:flutter/material.dart';	
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:skill_check/Utilitaires/constantes.dart';
import 'package:skill_check/Ecran/DrawerFile/ecranAccueil.dart';

class EcranInscription extends StatefulWidget {
  @override
  EcranInscriptionEtat createState() => EcranInscriptionEtat();
  }


class EcranInscriptionEtat extends State<EcranInscription> {

  bool visible = false;

  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  Future userRegistration() async {

    setState(() {
      visible = true;
    });

    String email = emailController.text;
    String userName = userNameController.text;
    String password = passwordController.text;

    var url = 'https://flagrant-amusements.000webhostapp.com/register_user.php';
    var data = {'email': email, 'userName': userName, 'password': password};
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
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                  MaterialPageRoute(builder: (context) => EcranAccueil()),
          );
                },
            ),
          ],
        );
      },
    );
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
            controller: userNameController,
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
          controller: passwordController,
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
      Text(
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
    ),
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
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
/*class RegisterUser extends StatefulWidget {

  RegisterUserState createState() => RegisterUserState();

}

class RegisterUserState extends State<RegisterUser> {
  bool visible = false;

  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  Future userRegistration() async {

    setState(() {
      visible = true;
    });

    String email = emailController.text;
    String userName = userNameController.text;
    String password = passwordController.text;

    var url = 'https://flagrant-amusements.000webhostapp.com/register_user.php';
    var data = {'email': email, 'userName': userName, 'password': password};
    var response = await http.post(url, body: json.encode(data));
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
                  Navigator.of(context).pop();
                },
            ),
          ],
        );
      },
    );
  }
}*/