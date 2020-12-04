import 'package:flutter/material.dart';

import 'package:skill_check/Utilitaires/constantes.dart';
import 'package:skill_check/Utilitaires/drawer.dart';


import 'package:http/http.dart' as http;
import 'dart:convert';


class StudentData {
  int studentId;
  String studentName;
  String studentMail;

  StudentData({
    this.studentId,
    this.studentName,
    this.studentMail
  });

  factory StudentData.fromJson(Map<String, dynamic> json){
    return StudentData(
      studentId: json['id'],
      studentName: json['name'],
      studentMail: json['email']
    );
  }
}

class EcranAccueil extends StatefulWidget {
  
  final String id;
  final String name;
  final String email;
  final String password;
  final String status;

  EcranAccueil({Key key, @required this.id, this.name, this.email, this.password, this.status}) : super(key: key);

  @override
  EcranAccueilEtat createState() => EcranAccueilEtat();
  }

class EcranAccueilEtat extends State<EcranAccueil> {

  final String apiURL = 'https://flagrant-amusements.000webhostapp.com/get_students.php';
  //var name;
  //var password;
  //var utilisateurid = int.parse(name);
  

  //EcranAccueilEtat({Key key, @required this.mail}) : super(key: key);

  Future<List<StudentData>> fetchStudents() async {
    
    int utilisateurid = int.parse(widget.id);

    var response = await http.get(apiURL);
 
    if (response.statusCode == 200) {
 
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
 
      List<StudentData> studentList = items.map<StudentData>((json) {
        return StudentData.fromJson(json);
      }).toList();
 
      return studentList;
      }
     else {
      throw Exception('Failed to load data from Server.');
    }
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Accueil',
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
              
              child: Text(widget.id + " " + widget.name + " " + widget.email + " " + widget.password + " " + widget.status ),
            ),
          ],
        ),
      );
    }
}