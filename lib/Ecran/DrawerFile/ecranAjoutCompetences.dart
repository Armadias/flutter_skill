//import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:skill_check/Utilitaires/constantes.dart';
import 'package:http/http.dart' as http;
import 'package:skill_check/Utilitaires/drawer.dart';


class EcranAjoutCompetences extends StatefulWidget {
  final Map<String, dynamic> profil;
  final String statusString;
  final List<String> listCours;

  EcranAjoutCompetences({Key key, @required  this.profil, this.statusString, this.listCours}) : super(key: key);

  @override
  EcranAjoutCompetencesEtat createState() => EcranAjoutCompetencesEtat();
  }

class EcranAjoutCompetencesEtat extends State<EcranAjoutCompetences>{

  bool visible = false;

  String firstValue;

  @override
  void initState() {
    firstValue = widget.listCours.first;
    super.initState();
  }

  List<String> dropList;

  final coursController = TextEditingController();
  final descriptionController = TextEditingController();
	final nomCompetenceController = TextEditingController();

  Future ajoutCompetence() async {
    setState(() {
      visible = true;
    });

    String nomCours = coursController.text;
    String descrCompetence = descriptionController.text;
    String nomCompetence = nomCompetenceController.text;
    
    print(firstValue);
    var url = 'https://flagrant-amusements.000webhostapp.com/ajouteCompetence.php';
    var data = {'nomCours': firstValue, 'descrCompetence': descrCompetence, 'nomCompetence': nomCompetence};
    var response = await http.post(url, body: json.encode(data));
    print(response);
    var message = jsonDecode(response.body);

    if(message == '-1'){
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Erreur, la compétence doit déjà exister..."),
          actions: <Widget>[
            FlatButton(
            child: Text("OK"),
            onPressed: () { Navigator.of(context).pop(); },
            ),
          ],
        );
      },
      );
    }
    else{
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("La compétence à été créée \nElle a aussi été ajoutée à tous les élèves du cours"),
          actions: <Widget>[
            FlatButton(
            child: Text("OK"),
            onPressed: () { Navigator.of(context).pop(); },
            ),
          ],
        );
      },
      );  
    }

    if(response.statusCode == 200){
    setState(() {
      visible = false;
    });
    }
  }

  bool rappel = false;
  
  Widget constructeurCours(){

      final dropdownMenuOptions = widget.listCours
      .map((String item) =>
      new DropdownMenuItem<String>(value : item, child : new Text(item , style: klistItem,))
      ).toList();

    return Container(
      color: Colors.cyan[300],
      child : new Theme(
        data: Theme.of(context).copyWith(
          canvasColor : Colors.cyan[300]
        ), 
        child: DropdownButton<String>(
          value : firstValue,
          items: dropdownMenuOptions,
          onChanged: (s) {
            setState(() {
              firstValue = s;
            });
          },
        )));
  }

    Widget constructeurNomCompetence(){
    return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                    Text(
                      'Nom de la compétence',
                      style: kLabelStyle,
                    ),
                  SizedBox(height: 10.0),
                  Container(alignment: Alignment.centerLeft,
                  decoration: kBoxDecorationStyle,
                  height: 60.0,
                  child: TextField(
                    controller:nomCompetenceController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: Colors.white,
                       fontFamily: 'Kufam',
                        fontSize: 13.0),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 18.0),
                      prefixIcon: Icon(
                        Icons.adjust, 
                        color: Colors.white,
                      ),
                      hintText: 'Entrez le nom de cours ici',
                      hintStyle: kHintTextStyle,
                    ),
                    ),
                  ),
                 ],
                );
  }

  Widget constructeurDescription(){
    return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                  Text(
                    'Description de la compétence',
                    style: kLabelStyle,
                  ),
                  SizedBox(height: 10.0),
                  Container(//alignment: Alignment.topLeft,
                  decoration: kBoxDecorationStyle,
                  height: 225.0,
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: descriptionController,
                    style: TextStyle(
                      color: Colors.white,
                       fontFamily: 'Kufam',
                        fontSize: 13.0),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(20.0),
                    ),
                    ),
                  ),
                 ],
                );
  }

  Widget constructeurBouttonCreation(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
       onPressed: ajoutCompetence,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: Colors.cyan[900],
        child:Text(
          'Créer',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Kufam',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajout de compétences',
        style: kLabelStyle,
        ),
      ),
      drawer: CustomDrawer(
        statusString: widget.statusString,
        profil: widget.profil,
        isInCours: false,
        isInListe: false,
        ),
      body: Stack(
        children: <Widget>[
        colorGradient,
        Container(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 80.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, 
              children: <Widget>[
                Text(
                  'Ajout de Compétence',
                  style: TextStyle(
                    color :Colors.white,
                    fontFamily: 'Kufam', 
                    fontSize: 26.0, 
                    fontWeight: FontWeight.bold,
                  ),
                ),                
                SizedBox(height: 10.0),
                constructeurCours(),
                SizedBox(height: 10.0),
                constructeurNomCompetence(),
                SizedBox(height: 30.0),
                constructeurDescription(),
                constructeurBouttonCreation(),
                SizedBox(height: 30.0),
              ],
            ),
          ),
        ),
      ],
    ),
  );
 }

}
  
class SlideRightRoute extends PageRouteBuilder {
  final Widget page;
  SlideRightRoute({this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
        );
}