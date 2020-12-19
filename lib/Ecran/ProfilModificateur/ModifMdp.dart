import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:skill_check/Ecran/DrawerFile/ecranProfil.dart';
import 'package:skill_check/Utilitaires/constantes.dart';
import 'package:http/http.dart' as http;
import 'package:skill_check/Utilitaires/liens.dart';

class ModifMdp extends StatefulWidget
{

  final Map<String, dynamic> profil;
  final String status;

  ModifMdp({Key key, @required this.profil, this.status }) : super(key: key);

  @override
  ModifMdpEtat createState() => ModifMdpEtat();
}

class ModifMdpEtat extends State<ModifMdp>
{
  final TextEditingController mdpActuelControlleur = TextEditingController();
  final TextEditingController mdpNouveauControlleur = TextEditingController();
  final TextEditingController mdpConfirmationControlleur = TextEditingController();

  bool valide;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
            title: Text(
            'Modification du mot de passe',
            style: kDrawerTitle,
            ),
          ),
          body:Stack(
            children: <Widget>[
              colorGradient,
              ListView(
                children: <Widget>[
                  SizedBox(height : 100),
                  constructeurMdpActuel(),
                  SizedBox(height : 25),
                  Divider(thickness: 2),
                  SizedBox(height : 25),
                  constructeurMdPNouveau(),
                  SizedBox(height: 40),
                  constructeurMdpConfirmation(),
                  SizedBox(height : 30),
                  bouttonModifierCompte(),
                ],           
              ),
            ],
          )         
    );
  }
    Widget constructeurMdpActuel(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left : 11),
          child : Text(
          'Mot de passe actuel',
          style: kLabelStyle,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left : 10, right : 10),
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller:mdpActuelControlleur,
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
                hintText: 'Entrez votre mot de passe actuel ici',
                hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget constructeurMdPNouveau()
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left : 11),
          child : Text(
          'Nouveau mot de passe',
          style: kLabelStyle,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left : 10, right : 10),
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller:mdpNouveauControlleur,
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
                hintText: 'Entrez votre nouveau mot de passe ici',
                hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget constructeurMdpConfirmation()
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left : 11),
          child : Text(
          'Confirmation du mot de passe',
          style: kLabelStyle,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left : 10, right : 10),
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller:mdpConfirmationControlleur,
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

  Widget bouttonModifierCompte()
  {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          modifier();
            },
        padding: EdgeInsets.all(15.0),
        color: Colors.cyan[900],
        child:Text(
          'Valider les changements',
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


  Future modifier() async
  {

    var conect = await Connectivity().checkConnectivity();

    // vérification de la connection du téléphone
    if (conect != ConnectivityResult.none){
      String mdpActuel = mdpActuelControlleur.text;
      String mdpNouveau = mdpNouveauControlleur.text;
      String mdpConfirmation = mdpConfirmationControlleur.text;

      if (mdpActuel.isEmpty | mdpNouveau.isEmpty | mdpConfirmation.isEmpty)
        popdial(context, "vos champs sont vide, veuillez les remplir");
      else if(widget.profil["motDePasse"] != mdpActuel)
        popdial(context, "votre mot de passe actuel est erroné");
      else if(mdpNouveau != mdpConfirmation)
        popdial(context, "votre nouveau mot de passe n'est pas confirmé");
      else{
        ProgressDialog pr = progressdial(context, 'Modifications en cours...');
        await pr.show();
        var url = mdpmodif;

        int id = int.parse(widget.profil['id']);
        var data = {'motDePasse': mdpNouveau, 'id' : id};
      
        var response = await http.post(url, body: json.encode(data));
      
        // Getting Server response into variable.
        var message;
        message = jsonDecode(response.body);

        await pr.hide();

        if(message != "-1")
        {
            showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("Mot de passe changé!"),
                actions: <Widget>[
                  FlatButton(
                  child: Text("Ok"),
                  onPressed: () 
                  { 
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => 
                      EcranProfil(
                        status : widget.status,
                        profil: message,
                      )
                      )
                    );      
                  },
                ),
              ],
            );
          },
        );
      }
      else
        popdial(context, "Une erreur est survenue lors de la communication avec le serveur.");
      }
    }
    else
      popdial(context, "vous n'êtes pas connecté à internet!");
  }
}