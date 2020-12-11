import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:skill_check/Ecran/DrawerFile/ecranListe.dart';

import 'package:skill_check/Utilitaires/constantes.dart';


class EcranCompetences extends StatefulWidget {
  
  final int idEleve;
  final List<dynamic> listEleve;
  final List<dynamic> message;
  final Map<String, dynamic> profil;
  final String statusString;

  EcranCompetences({Key key, @required this.idEleve, this.message, this.profil, this.statusString, this.listEleve}) : super(key: key);

  @override
  EcranCompetencesEtat createState() => EcranCompetencesEtat();
  }

class EcranCompetencesEtat extends State<EcranCompetences> {

  List<dynamic> message = List<dynamic>();


Future valideComp(int competencesIdcompetences, int utilisateurId) async {
  // SERVER LOGIN API URL
  var url = 'https://flagrant-amusements.000webhostapp.com/valideCompProf.php';
 
  // Store all data with Param Name.
  var data = {'idComp': competencesIdcompetences, 'id' : utilisateurId};
 
  // Starting Web API Call.
  var response = await http.post(url, body: json.encode(data));
 
  // Getting Server response into variable.
  var message = jsonDecode(response.body);
}

  @override
    Widget build(BuildContext context)
  {
    return Scaffold(
          appBar: AppBar(
            title: Text('Compétences de l\'élève',
            style: kLabelStyle,
            ),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back), 
              onPressed:() => Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) =>
                  EcranListe(
                                statusString: widget.statusString,
                                profil: widget.profil,
                                message: widget.listEleve,
                    ),
                  ),
                )
              ),
          ),
           body: Stack(
             children: <Widget>[
            colorGradient,
            constructeurList(),
          ],
        ),
      );
  }

  //   Widget constructeurBoutton(){
  //   return Container(
  //     padding: EdgeInsets.symmetric(vertical: 25.0),
  //     width: double.infinity,
  //     child: RaisedButton(
  //       elevation: 5.0,
  //       //onPressed: test,
  //       padding: EdgeInsets.all(15.0),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(30),
  //       ),
  //       color: Colors.deepOrangeAccent,
  //       child:Text(
  //         'TEST',
  //         style: TextStyle(
  //           color: Colors.white70,
  //           letterSpacing: 1.5,
  //           fontSize: 18.0,
  //           fontWeight: FontWeight.bold,
  //           fontFamily: 'Kufam',
  //         ),
  //       ),
  //     ),
  //   );
  // }

    Widget constructeurList(){
      //if (widget.message.length > ) 15

    return ListView.builder(
      itemCount: widget.message.length,
      itemBuilder: (BuildContext context, int index){
        return AnimationConfiguration.staggeredList(
          position: index, 
          duration: const Duration(milliseconds : 375),
          child: SlideAnimation(
            verticalOffset: 50.0,
            child: FadeInAnimation(
              child: Center(
                child: Card(
                  color: Colors.cyan[50],
                  margin: EdgeInsets.only(top: 20, left: 5, right : 5),
                  elevation: 10.0,
                  child : InkWell(
                    splashColor: Colors.cyan,
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: new Text("Voulez-vous valider cette compétence à l'élève ?"),
                              actions: <Widget>[
                                FlatButton(
                                child: Text("Oui"),
                                onPressed: () { print("descr " + widget.message[index]["1"] + " id " + widget.message[index]["0"]); 
                                                valideComp(int.parse(widget.message[index]["1"]), int.parse(widget.message[index]["0"])); 
                                                Navigator.of(context).pop(); }, 
                                ),
                                FlatButton(
                                child: Text("Non"),
                                onPressed: () { Navigator.of(context).pop(); },
                                )
                              ],
                            );
                          },
                          );
                    },
                    child : Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height/  7,
                      child : Center(
                        child : Text(
                          '${widget.message[index]["nomCours"] + " " + widget.message[index]["descriptionCours"] + " " + widget.message[index]["descriptionCompetence"] + " " + widget.message[index]["valideEleve"] + " " + widget.message[index]["valideProf"] + " "}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.cyan[900],
                            fontFamily: 'Kufam'
                          ),
                        )
                      ),
                    ),
                  ),
                ) 
              ),
            ),
          ),
/*
        return GestureDetector(
          onTap: (){
            print("ca marche !!");
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EcranCompetences(id : widget.id,
                                name: widget.name,
                                email: widget.email,
                                password: widget.password,
                                status: widget.status,
                                idEleve: 1)),
            );
          },
          child: new Container(
            height: 50,
            child : Center(
              child: Text('${widget.message[index]["0"]}')
            )
          )
*/
        );
      }
    ); 
    }

  /*Widget constructeurDropdownButton(){
    return DropdownButton(items: new List.generate(20, (int index){

    }))

    );
  }*/

//   Future test() async{
 
//   int idEleve = widget.idEleve;
//   // SERVER LOGIN API URL
//   var url = 'https://flagrant-amusements.000webhostapp.com/getCompetencesEleve.php';
 
//   // Store all data with Param Name.
//   var data = {'idEleve' : idEleve};
 
//   // Starting Web API Call.
//   var response = await http.post(url, body: json.encode(data));
 
//   // Getting Server response into variable.
//  List<dynamic> message = jsonDecode(response.body);

//   List<Map<String, dynamic>> noms = List<Map<String, dynamic>>();

//   // If the Response Message is Matched.
//  if(message[0] != "-1")
//   {

//     for (int i = 0; i < message.length; i++)
//     {
//       noms.add(message[i]["0"]);
//       print(noms);
//     }

//     print (noms);
// //jsonconverter(message[i]);

//   print("ceci est un test : ");
//   //window.location.reload();
//   setState(() {
    
//   ListView.builder(
//       //itemCount: noms.length;
//       itemBuilder: (BuildContext context, int index){
//         return Container(
//           height: 50,
//           child : Center(
//             child: Text('${message[index]["0"]}')
//           )
//         );
//       }
//   ); 
//   });
    


//          showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: new Text(() 
//           {
//              return "boop";
//           }()),
//         actions: <Widget>[
//           FlatButton(
//            child: Text("Ok"),
//            onPressed: () { Navigator.of(context).pop(); },
//            ),
//         ],
//       );
//     },
//     ); 
//   }
//   else
//   {
 
    
//   }
 
// }


}