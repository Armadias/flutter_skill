import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:http/http.dart' as http;
import 'package:skill_check/Ecran/DrawerFile/ecranListeProf.dart';
import 'dart:convert';

import 'package:skill_check/Ecran/DrawerFile/ecranProfil.dart';
import 'package:skill_check/Utilitaires/liens.dart';

class LoaderProf extends StatefulWidget {

  final Map<String, dynamic> profil;
  final String statusString;

  LoaderProf({Key key, @required this.profil, this.statusString}) : super(key: key);

  @override
  LoaderState createState() => LoaderState();
  }


class LoaderState extends State<LoaderProf> 
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
                          return "Récupération de vos éleves";
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
  int id = int.parse(widget.profil["id"]);
  // SERVER LOGIN API URL
  var url = listeprof;

  // Store all data with Param Name.
  var data = {'id' : id};

  // Starting Web API Call.
  var response = await http.post(url, body: json.encode(data));

  var mess = jsonDecode(response.body);
  
  if (mess != -1)
    message = json.decode(response.body);
  else
  {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (BuildContext context) =>
    EcranProfil(
      profil : widget.profil,
      status : widget.statusString,
    )
  ),
);
  }
  Navigator.pop(context);

  Navigator.of(context).push(MaterialPageRoute(
    builder: (BuildContext context) =>
    EcranListeProf(
      profil : widget.profil,
      statusString : widget.statusString,
      message : message)
  ),
);
}
}