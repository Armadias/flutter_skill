import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:skill_check/Ecran/DrawerFile/ecranCompetencesProf.dart';
import 'package:skill_check/Utilitaires/Competences.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:skill_check/Utilitaires/liens.dart';

class LoaderCompetences extends StatefulWidget {

  final Map<String, dynamic> profil;
  final String statusString;
  final int idEleve;
  final String eleve;

  final List<dynamic> listEleve;

  LoaderCompetences({Key key, @required this.eleve, this.profil, this.statusString, this.idEleve, this.listEleve}) : super(key: key);

  @override
  LoaderCompetencesState createState() => LoaderCompetencesState();
  }


class LoaderCompetencesState extends State<LoaderCompetences> 
{
  List<dynamic> message;


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      body: new InkWell(
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Container(
              decoration:  BoxDecoration(color: Colors.white),
            ),
            new Container(
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  flex: 3,
                  child: new Container(
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.only(top:30.0),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                          Colors.green
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        ),
                        Text(() 
                      {
                        if (widget.statusString == "Éleve")
                          return "Récupération de vos professeurs";
                        else
                          return "Récupération des compétences de l'élève...";
                      }()),
                    ],
                  ),
                ),
              ],
            ),
          ],
       ),
      ),
    );
  }

@override
void initState()
{
  super.initState();

  SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    fetch();
  });

}

@protected
Future fetch() async
{
  int eleve = widget.idEleve;
  // SERVER LOGIN API URL
  var url = compelev;

  // Store all data with Param Name.
  var data = {'id' : eleve};

  // Starting Web API Call.
  var response = await http.post(url, body: json.encode(data));

var mess = jsonDecode(response.body);

  if (mess != -1)
  {
    message = json.decode(response.body);
    List<Cours> coursList = new List<Cours>();
    int indexe;
    int nbCours = 0;
    

    for (int i = 0; i < message.length; i++)
    {
      indexe = -1;
      for (int j = 0; j < coursList.length; j++)
      {
        if (coursList[j].nom == message[i]["nomCours"])
        {
          indexe = j;
          break;
        }

      }

      if (indexe != -1)
      {
        Competences competence = new Competences(message[i]["descriptionCompetence"], int.parse(message[i]["valideEleve"]), int.parse(message[i]["valideProf"]), int.parse(message[i]["1"]),message[i]["nom"]);
        coursList[indexe].comp.add(competence);
      }
      else
      {
        Cours cours = new Cours(message[i]["nomCours"], message[i]["descriptionCours"]);
        coursList.add(cours);
        Competences competence = new Competences(message[i]["descriptionCompetence"], int.parse(message[i]["valideEleve"]), int.parse(message[i]["valideProf"]), int.parse(message[i]["1"]), message[i]["nom"]);
        coursList[nbCours].comp.add(competence);
        nbCours ++;
      }
    }

  Navigator.pop(context);

  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (BuildContext context) =>
    EcranCompetences(

      idEleve: widget.idEleve,
      eleve : widget.eleve,
      cours : coursList,
      profil : widget.profil,
      statusString : widget.statusString,
      listEleve: widget.listEleve,)
  ),
);
}
}
}