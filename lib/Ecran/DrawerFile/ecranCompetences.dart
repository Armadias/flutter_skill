import 'package:flutter/material.dart';

import 'package:skill_check/Utilitaires/constantes.dart';
import 'package:skill_check/Utilitaires/drawer.dart';


import 'package:http/http.dart' as http;
import 'dart:convert';


class EcranCompetences extends StatefulWidget {
  
  final String id;
  final String name;
  final String email;
  final String password;
  final String status;
  final int idEleve;

  EcranCompetences({Key key, @required this.id, this.name, this.email, this.password, this.status, this.idEleve}) : super(key: key);

  @override
  EcranCompetencesEtat createState() => EcranCompetencesEtat();
  }

class EcranCompetencesEtat extends State<EcranCompetences> {

  List<dynamic> message = List<dynamic>();

  @override
  Widget build(BuildContext context) {

        print("saucisson" + widget.id + widget.name);
        return Scaffold(
          appBar: AppBar(
            title: Text('Compétences de l\'élève',
            style: kLabelStyle,
            ),
          ),
          drawer: CustomDrawer(id : widget.id,
                                name: widget.name,
                                email: widget.email,
                                password: widget.password,
                                status: widget.status),
           body: Stack(children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.red,
                    Colors.orange,
                    Colors.orangeAccent,
                    Colors.deepOrange,
                ],
                stops: [0.1,0.4,0.7,0.9],
                ),
              ),
              
              child: Text("oscour !"),
              //child: Text(widget.id + " " + widget.name + " " + widget.email + " " + widget.password + " " + widget.status ),
            ),
            SizedBox(height: 40.0),
            constructeurList(),
            SizedBox(height: 40.0),
          ],
        ),
      );
    }

    Widget constructeurBoutton(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: test,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: Colors.deepOrangeAccent,
        child:Text(
          'TEST',
          style: TextStyle(
            color: Colors.white70,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Kufam',
          ),
        ),
      ),
    );
  }

  Widget constructeurList(){
    return ListView.builder(
      //itemCount: noms.length;
      itemBuilder: (BuildContext context, int index){
        return Container(
          height: 50,
          child : Center(
            child: Text('${message[index]["0"]}')
          )
        );
      }
  ); 
  }

  /*Widget constructeurDropdownButton(){
    return DropdownButton(items: new List.generate(20, (int index){

    }))

    );
  }*/

  Future test() async{
 
  int idEleve = widget.idEleve;
  // SERVER LOGIN API URL
  var url = 'https://flagrant-amusements.000webhostapp.com/getCompetencesEleve.php';
 
  // Store all data with Param Name.
  var data = {'idEleve' : idEleve};
 
  // Starting Web API Call.
  var response = await http.post(url, body: json.encode(data));
 
  // Getting Server response into variable.
 List<dynamic> message = jsonDecode(response.body);

  List<Map<String, dynamic>> noms = List<Map<String, dynamic>>();

  // If the Response Message is Matched.
 if(message[0] != "-1")
  {

    for (int i = 0; i < message.length; i++)
    {
      noms.add(message[i]["0"]);
      print(noms);
    }

    print (noms);
//jsonconverter(message[i]);

  print("ceci est un test : ");
  //window.location.reload();
  setState(() {
    
  ListView.builder(
      //itemCount: noms.length;
      itemBuilder: (BuildContext context, int index){
        return Container(
          height: 50,
          child : Center(
            child: Text('${message[index]["0"]}')
          )
        );
      }
  ); 
  });
    


         showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text(() 
          {
             return "boop";
          }()),
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
  else
  {
 
    
  }
 
}


}