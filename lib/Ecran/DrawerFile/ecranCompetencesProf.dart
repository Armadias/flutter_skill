import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:skill_check/Ecran/DrawerFile/ecranListe.dart';
import 'package:skill_check/Utilitaires/Competences.dart';

import 'package:skill_check/Utilitaires/constantes.dart';
import 'package:http/http.dart' as http;


class EcranCompetences extends StatefulWidget {
  
  final String eleve;
  final int idEleve;
  final List<dynamic> listEleve;
  final List<Cours> cours;
  final Map<String, dynamic> profil;
  final String statusString;

  EcranCompetences({Key key, @required this.idEleve, this.eleve, this.cours, this.profil, this.statusString, this.listEleve}) : super(key: key);

  @override
  EcranCompetencesEtat createState() => EcranCompetencesEtat();
  }

class EcranCompetencesEtat extends State<EcranCompetences> {

Future valideComp(int competencesIdcompetences, int utilisateurId) async {
  // SERVER LOGIN API URL
  var url = 'https://flagrant-amusements.000webhostapp.com/valideCompProf.php';
 
  // Store all data with Param Name.
  var data = {'idComp': competencesIdcompetences, 'id' : utilisateurId};
 
  // Starting Web API Call.
  await http.post(url, body: json.encode(data));

  
}

  @override 
  Widget build(BuildContext context)
  { 
    return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                   Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) =>
                      EcranListe(
                        profil: widget.profil,
                        statusString: widget.statusString,
                        message: widget.listEleve
                      )
                    )
                  );
                },
              );
            },
          ),
          title: Text(
            'Cours de ' + widget.eleve,
            style: kLabelStyle,
          ),
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
            subtitle: Text(
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
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.cours[i].comp.length,
        itemBuilder: (context, index) {
          return Card(
            color: widget.cours[i].comp[index].validiteE? Colors.green : Colors.cyan[700],
          child : CheckboxListTile(
            activeColor: Colors.white,
            checkColor: Colors.green,
            value: widget.cours[i].comp[index].validiteP, 
            onChanged: (val)
            {
              if (val)
              {
                widget.cours[i].comp[index].validiteP = true;
              }
              else
                widget.cours[i].comp[index].validiteP = false;
                setState(() {
                });
                sendData(widget.cours[i].comp[index].id, widget.cours[i].comp[index].validiteP);

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
    var url = 'https://flagrant-amusements.000webhostapp.com/validation.php';
 
  // Store all data with Param Name.


  var data = {'idComp': id, 'id' : widget.idEleve, 'valide' : valide, 'status' : widget.profil["status"]};

 
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
    else
    Flushbar(
      title: "Donnée evoyée!",
      message: "Merci d'avoir patienté",
      duration: Duration(seconds: 2),
    )..show(context);
  }
}
