import 'package:flutter/material.dart';

import 'package:skill_check/Utilitaires/constantes.dart';
import 'package:skill_check/Utilitaires/drawer.dart';


import 'package:http/http.dart' as http;
import 'dart:convert';

class EcranAccueil extends StatefulWidget {
  @override
  EcranAccueilEtat createState() => EcranAccueilEtat();
  }


class EcranAccueilEtat extends State<EcranAccueil> {

  var name;
  var password;

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Accueil',
            style: kLabelStyle,
            ),
          ),
          drawer: CustomDrawer(),
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
              
              child: Text('Accueuil'),
            ),
          ],
        ),
      );
    }

    Future getData() async{
    var url = 'https://flagrant-amusements.000webhostapp.com/get.php';
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    print(data.toString());

    name = data['username'];
    password = data[password];
  }

  @override
  void initState() {
    super.initState();
    getData();
  }    
}