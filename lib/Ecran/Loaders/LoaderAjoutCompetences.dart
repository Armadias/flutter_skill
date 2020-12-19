import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:skill_check/Ecran/DrawerFile/ecranAjoutCompetences.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:skill_check/Utilitaires/liens.dart';

class LoaderAjoutCompetences extends StatefulWidget {

  final Map<String, dynamic> profil;
  final String statusString;


  LoaderAjoutCompetences({Key key, @required this.profil, this.statusString}) : super(key: key);

  @override
  LoaderCompetencesState createState() => LoaderCompetencesState();
  }


class LoaderCompetencesState extends State<LoaderAjoutCompetences> 
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
                          return "Récupération de vos cours";
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
  // SERVER LOGIN API URL
  var url = getcours;

  // Store all data with Param Name.
  var data = {'id' : widget.profil["id"]};

  // Starting Web API Call.
  var response = await http.post(url, body: json.encode(data));

var mess = jsonDecode(response.body);

    List<String> coursList = new List<String>();
  if (mess != -1) 
  {
    message = json.decode(response.body);

    for (int i = 0; i < message.length; i++)
    {

        coursList.add(message[i]["nomCours"]);
      }
  }

  Navigator.pop(context);
  Navigator.push(
    context, 
    MaterialPageRoute(builder: (BuildContext context) =>
    EcranAjoutCompetences(
      profil: widget.profil,
      statusString: widget.statusString,
      listCours: coursList,
    )
    )
  );


}
}