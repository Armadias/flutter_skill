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
  bool isChecked =false;
  List<dynamic> listeTest = ["francis", "jean", "papa", "nana", "titi", "toto"];
  List<bool> listeTestBool = [false, true, false, false, false, true];

  @override 
  Widget build(BuildContext context)
  { 
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Liste de vos cours',
          style: kLabelStyle,
        ),
      ),
      drawer: CustomDrawer(
        profil: widget.profil,
        statusString: widget.status,
        isInListe: true,
        ),
        body: Stack(
          children: <Widget>[
            colorGradient,
            constructeurListeCours(),
        ],
      ) 
    );
  }   

  Widget constructeurListeCours()
  {
    return new ListView.builder(
      itemCount: listeTest.length,
      itemBuilder: (context, index)
      {
        return new ExpansionTile(
          title: new Text(
            listeTest[index],
            style: kLabelStyle,
          ),
          children: <Widget>[
            constructeurListeCompetences()
          ],
        );
      }
    );
  }

  Widget constructeurListeCompetences()
  {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: listeTest.length,
        itemBuilder: (context, index) {
          return Container(
            color: listeTestBool[index]? Colors.green : null,
          child : CheckboxListTile(
            value: listeTestBool[index], 
            onChanged: (val)
            {
              if (val)
              {
                listeTestBool[index] = true;
              }
              else
                listeTestBool[index] = false;
                setState(() {
                });
            },
            title: new Text(
              listeTest[index]
            ),
          )
          );
        },
      );
         
  }
}