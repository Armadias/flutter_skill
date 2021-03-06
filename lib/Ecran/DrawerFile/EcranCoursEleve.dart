import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:skill_check/Utilitaires/Competences.dart';

import 'package:skill_check/Utilitaires/constantes.dart';
import 'package:skill_check/Utilitaires/drawer.dart';

import 'package:http/http.dart' as http;
import 'package:skill_check/Utilitaires/liens.dart';

class EcranCoursEleve extends StatefulWidget {

  final List<Cours> cours;
  final Map<String, dynamic> profil;
  final String status;

  EcranCoursEleve({Key key, this.cours, @required  this.profil, this.status}) : super(key: key);

  @override
  EcranCoursEleveEtat createState() => EcranCoursEleveEtat();
  }


class EcranCoursEleveEtat extends State<EcranCoursEleve> 
{
  @override 
  Widget build(BuildContext context)
  { 
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Liste de vos cours',
            style: kLabelStyle,
          ),
        ),
        drawer: CustomDrawer(
          profil: widget.profil,
          statusString: widget.status,
          isInListe: false,
          isInCours: true,
          ),
          body: Stack(
            children: <Widget>[
              colorGradient,
              constructeurListeCours(),
          ],
        )
      ) 
    );
  }   

  Widget constructeurListeCours()
  {
    return new ListView.builder(
      itemCount: widget.cours.length,
      itemBuilder: (context, index)
      {
        return Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 1, color: Colors.black38)),
            color: Colors.cyan,
          ),
          //color: Colors.cyan,
          child : new ExpansionTile(
            backgroundColor: Colors.cyan[600],
            title: new Text(
              widget.cours[index].nom,
              style: kLabelStyle,
            ),
              subtitle : Text(
                widget.cours[index].description,
                style: klistItem,),
            children: <Widget>[
              Divider(thickness: 2),
              constructeurListeCompetences(index)
            ],
          )
        );
      }
    );
  }

  Widget constructeurListeCompetences(int i)
  {
    return ListView.builder(
        physics: ScrollPhysics() ,
        shrinkWrap: true,
        itemCount: widget.cours[i].comp.length,
        itemBuilder: (context, index) {
          return Card(
            color: widget.cours[i].comp[index].validiteP? Colors.green : Colors.cyan[700],
          child : CheckboxListTile(
            activeColor: Colors.white,
            checkColor: Colors.green,
            value: widget.cours[i].comp[index].validiteE, 
            onChanged: (val)
            {
              if (val)
              {
                widget.cours[i].comp[index].validiteE = true;
              }
              else
                widget.cours[i].comp[index].validiteE = false;
                setState(() {
                });
                sendData(widget.cours[i].comp[index].id, widget.cours[i].comp[index].validiteE);
            },
            title: new Text(
              widget.cours[i].comp[index].nom,
              style: ktitlelist,
            ),
            subtitle: new Text(
              widget.cours[i].comp[index].description,
              style: klistItem,
            ),
          )
          );
        },
      );
         
  }

  Future sendData(int id , bool valide) async
  {
      Flushbar(
      title: "Envoi des données en cours...",
      message: "ne fermez pas cette fenêtre",
      duration: Duration(seconds: 1),
    )..show(context);
    var url = validation;
 
  // Store all data with Param Name.

  

  var data = {'idComp': id, 'id' : int.parse(widget.profil["id"]), 'valide' : valide, 'status' : widget.profil["status"]};
 
  // Starting Web API Call.
  var response = await http.post(url, body: json.encode(data));
  var mess = jsonDecode(response.body);

  if (mess =='-1')
        popdial(context, "ERREUR D'ENVOI DES DONNEES");

        else
    Flushbar(
      title: "Donnée evoyée!",
      message: "Merci d'avoir patienté",
      duration: Duration(seconds: 2),
    )..show(context);
  }
}