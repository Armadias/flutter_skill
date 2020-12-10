import 'package:flutter/material.dart';

import 'package:skill_check/Utilitaires/constantes.dart';
import 'package:skill_check/Utilitaires/drawer.dart';

class EcranAccueil extends StatefulWidget {


  final String statusString;

  final Map<String,dynamic> message;

  EcranAccueil({Key key, @required this.statusString, this.message}) : super(key: key);

  @override
  EcranAccueilEtat createState() => EcranAccueilEtat();
  }


class EcranAccueilEtat extends State<EcranAccueil> {

  List<dynamic> message = List<dynamic>();

  var name;
  var password;
  final List<dynamic> noms = ["Yoan Ameloot", "Martin Folliet", "Virgile Jacquet", "Rémi Matrod", "Nicolas Commandeur", "Un autre élève"];
  //final String mail;

  //EcranAccueilEtat({Key key, @required this.mail}) : super(key: key);

  @override
  Widget build(BuildContext context) {

        return Scaffold(
          appBar: AppBar(
            title: Text('Accueil',
            style: kDrawerTitle,
            ),
          ),
          drawer: CustomDrawer(
                                profil: widget.message,
                                statusString: widget.statusString,
                              ),
           body: Stack(children: <Widget>[
            colorGradient,
          ],
        ),
      );
    }

}