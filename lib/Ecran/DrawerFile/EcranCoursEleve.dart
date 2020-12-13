import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:skill_check/Utilitaires/Competences.dart';

import 'package:skill_check/Utilitaires/constantes.dart';
import 'package:skill_check/Utilitaires/drawer.dart';

import 'package:http/http.dart' as http;

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
          isInListe: true,
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
    var url = 'https://flagrant-amusements.000webhostapp.com/validation.php';
 
  // Store all data with Param Name.

  print(valide);

  var data = {'idComp': id, 'id' : int.parse(widget.profil["id"]), 'valide' : valide, 'status' : widget.profil["status"]};
 
  // Starting Web API Call.
  var response = await http.post(url, body: json.encode(data));
  var mess = jsonDecode(response.body);

  if (mess =='-1')
        showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("ERREUR DE COMMUNICATION A LA BASE DE DONNEE"),
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
}