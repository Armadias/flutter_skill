import 'package:flutter/material.dart';

import 'package:skill_check/Utilitaires/constantes.dart';
import 'package:skill_check/Utilitaires/drawer.dart';

class EcranAccueil extends StatefulWidget {

  final Map<String,dynamic> message;
  final String statusString;

  EcranAccueil({Key key, @required this.statusString, this.message}) : super(key: key);

  @override
  EcranAccueilEtat createState() => EcranAccueilEtat();
  }

class EcranAccueilEtat extends State<EcranAccueil> {

  //final String mail;

  //EcranAccueilEtat({Key key, @required this.mail}) : super(key: key);

 /* Future<List<StudentData>> fetchStudents() async {
    var apiURL = 'https://flagrant-amusements.000webhostapp.com/login_user.php';
    //int utilisateurid = int.parse(widget.id);

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
*/
  @override
  Widget build(BuildContext context) {

        return Scaffold(
          appBar: AppBar(
            title: Text('Accueil',
            style: kDrawerTitle,
            ),
          ),
          drawer: CustomDrawer(
                                profil: widget.message,
                                statusString: widget.statusString,
                              ),
           body: Stack(children: <Widget>[
            colorGradient,
          ],
        ),
      );
    }

}