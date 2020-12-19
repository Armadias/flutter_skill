//import 'dart:async';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:skill_check/Utilitaires/constantes.dart';
import 'package:http/http.dart' as http;
import 'package:skill_check/Utilitaires/drawer.dart';
import 'package:skill_check/Utilitaires/liens.dart';


class EcranAjoutCompetences extends StatefulWidget {
  final Map<String, dynamic> profil;
  final String statusString;
  final List<String> listCours;

  EcranAjoutCompetences({Key key, @required  this.profil, this.statusString, this.listCours}) : super(key: key);

  @override
  EcranAjoutCompetencesEtat createState() => EcranAjoutCompetencesEtat();
  }

class EcranAjoutCompetencesEtat extends State<EcranAjoutCompetences>{

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

    var conect = await Connectivity().checkConnectivity();

    if (conect != ConnectivityResult.none){
      ProgressDialog pr = progressdial(context, 'ajout de la compétence en cours...');

      String descrCompetence = descriptionController.text;
      String nomCompetence = nomCompetenceController.text;

      if (descrCompetence.isEmpty | nomCompetence.isEmpty)
        popdial(context, "Erreur, vos champs sont vides...");
      else{
        await pr.show();
        var url = ajoutcomp;
        var data = {'nomCours': firstValue, 'descrCompetence': descrCompetence, 'nomCompetence': nomCompetence};
        print(data);
        var response = await http.post(url, body: json.encode(data));

        print(response);
        var message = jsonDecode(response.body);

        pr.hide();

        if(message == '-1')
          popdial(context, "Erreur, la compétence doit déjà exister...");
        else
          popdial(context, "La compétence à été créée \nElle a aussi été ajoutée à tous les élèves du cours");
      }
    }
    else
      popdial(context, "vous n'êtes pas connecté à internet!");
  }
  
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
        )
      )
    );
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
                      hintText: 'Entrez le nom de la compétence ici',
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