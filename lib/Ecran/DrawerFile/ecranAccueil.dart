import 'package:flutter/material.dart';

import 'package:skill_check/Utilitaires/constantes.dart';
import 'package:skill_check/Utilitaires/drawer.dart';

class EcranAccueil extends StatefulWidget {
  
  final String id;
  final String name;
  final String email;
  final String password;
  final String status;
  final String statusString;

  final Map<String,dynamic> message;

  EcranAccueil({Key key, @required this.id, this.name, this.email, this.password, this.status, this.statusString, this.message}) : super(key: key);

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
          drawer: CustomDrawer(id : widget.id,
                                name: widget.name,
                                email: widget.email,
                                password: widget.password,
                                status: widget.status,
                                profil: widget.message,
                                statusString: widget.statusString,),
           body: Stack(children: <Widget>[
            colorGradient,
          ],
        ),
      );
    }

}