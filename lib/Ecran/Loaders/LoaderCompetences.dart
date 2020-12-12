import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:skill_check/Ecran/DrawerFile/ecranCompetences.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class LoaderCompetences extends StatefulWidget {

  final Map<String, dynamic> profil;
  final String statusString;
  final int idEleve;

  final List<dynamic> listEleve;

  LoaderCompetences({Key key, @required this.profil, this.statusString, this.idEleve, this.listEleve}) : super(key: key);

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
  var url = 'https://flagrant-amusements.000webhostapp.com/getCompetencesEleve.php';

  // Store all data with Param Name.
  var data = {'id' : eleve};

  // Starting Web API Call.
  var response = await http.post(url, body: json.encode(data));

  var mess = jsonDecode(response.body);
  
  if (mess != -1)
  message = json.decode(response.body);

  else

  print(message);
  Navigator.pop(context);

  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (BuildContext context) =>
    EcranCompetences(
      idEleve : 1,
      message : message,
      profil : widget.profil,
      statusString : widget.statusString,
      listEleve: widget.listEleve,)
  ),
);
}
}