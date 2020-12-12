import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:skill_check/Utilitaires/constantes.dart';
import 'package:skill_check/Utilitaires/drawer.dart';

class EcranCoursEleve extends StatefulWidget {

  final List<dynamic> message;
  final Map<String, dynamic> profil;
  final String status;

  EcranCoursEleve({Key key, this.message, @required  this.profil, this.status}) : super(key: key);

  @override
  EcranCoursEleveEtat createState() => EcranCoursEleveEtat();
  }


class EcranCoursEleveEtat extends State<EcranCoursEleve> 
{

  @override 
  Widget build(BuildContext context)
  {
    return Scaffold(
      );
  }   
}
