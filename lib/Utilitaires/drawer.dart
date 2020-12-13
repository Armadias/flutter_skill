import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:skill_check/Ecran/Loaders/LoaderCompetencesEleve.dart';
import 'package:skill_check/Ecran/Loaders/LoaderListEleve.dart';
import 'package:skill_check/Ecran/DrawerFile/ecranProfil.dart';

import 'package:skill_check/Ecran/DrawerFile/ecranAjoutCompetences.dart';

class CustomDrawer extends StatefulWidget{

  final String statusString;
  final Map<String,dynamic> profil;
  final bool isInListe;
  final bool isInCours;

  CustomDrawer({Key key, this.isInCours,this.isInListe, @required this.statusString, this.profil}) : super(key : key);
  @override
  DrawerEtat createState() => new DrawerEtat();

}

class DrawerEtat extends State<CustomDrawer>{
  bool estEleve;
  bool aImage = false;

  @override
  Widget build(BuildContext context) {
    var random = new Random();
    String r = random.nextInt(100).toString();

    widget.profil["status"] == "0"? estEleve = true : estEleve = false;
    widget.profil["image"] == "-1"? aImage = false : aImage = true;

    return new Drawer(
    child: ListView(
      padding:EdgeInsets.zero,
      children: <Widget>[
        Visibility(
          visible: !aImage,
          child: UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.cyan),
            accountName: Text(widget.profil["nomPrenom"],
            style: TextStyle(color: Colors.white)),
            accountEmail: Text( 
          widget.profil["email"],
          style: TextStyle(color: Colors.white)
                ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
              ? Colors.white
              : Colors.white,
              child: Text(widget.profil["nomPrenom"][0],
              style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          replacement: UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.cyan),
            accountName: Text(widget.profil["nomPrenom"],
            style: TextStyle(color: Colors.white)),
            accountEmail: Text( 
              widget.profil["email"],
              style: TextStyle(color: Colors.white)
                ),
            currentAccountPicture: CircleAvatar(
              backgroundImage:  NetworkImage(
              "https://flagrant-amusements.000webhostapp.com/image/" + widget.profil["image"] + "?v=" + r,
                ),
              ),
            ),

          ), 
        //Profil
        Card(
          child: ListTile(
            leading : Icon(Icons.account_circle),
            title: Text('profil'),
            onTap: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) =>
                  EcranProfil(
                    profil: widget.profil,
                    status: widget.statusString,
                  )
                )
              );
            }            
          )
        ),
        //Liste Eleve/ prof
        Visibility(
          visible: estEleve,
          child : Card(
            child: ListTile(
              leading: Icon(Icons.list),
              title: Text('Liste de vos Professeurs'),
              onTap: (){
                if (!widget.isInListe){
                  Navigator.of(context).pop();
                }
                else
                Navigator.pop(context);
                    },
            ),
          ),
          replacement:
          Card(
            child: ListTile(
              leading: Icon(Icons.list),
              title: Text('Liste de vos éleves'),
              onTap: (){
                if (!widget.isInListe){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                      Loader(
                        profil: widget.profil,
                        statusString: widget.statusString
                        )
                      ),
                    );
                }
                else
                Navigator.pop(context);
                    },
            ),
          ),
        ),
/*
          Visibility(
          visible: false,
          child : Card(
            child: ListTile(
              leading: Icon(Icons.list),
              title: Text('Ajouter une compétence'),
              onTap: (){
                if (!widget.isInListe){
                  Navigator.of(context).pop();
                }
                else
                Navigator.pop(context);
                    },
            ),
          ),
          ),*/

        //Badges
        Visibility(
          visible: false,
        child : Card(
          child: ListTile(
            leading: Icon(Icons.stars),
            title: Text('Badges'),
            onTap: (){
                    Navigator.pop(context);
                  },
          ),
        ),
        ),
        //Progression
        Visibility(
          visible: estEleve,
          child : contructeurCoursEleve(),
          replacement: constructeurCoursProf()
          ),
        ],
      ),  
    );
  }

  Widget contructeurCoursEleve()
  {
    return Card(
      child: ListTile(
        leading: Icon(Icons.book),
        title: Text('Vos Cours'),
        onTap: (){
          if (!widget.isInListe){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) =>
              LoaderCompetencesEleve(
                profil: widget.profil,
                status: widget.statusString,
              ),
            ),
          );
          }else Navigator.pop(context);
        },
      ),
    );
  }

  Widget constructeurCoursProf()
  {
    return Card(
      child: ListTile(
        leading: Icon(Icons.stars),
        title: Text('Ajouter Vos Compétences'),
        onTap: (){
          Navigator.push(
            context,
              MaterialPageRoute(builder: (context) => EcranAjoutCompetences()
              )
          );  
        },
      ),
    );
  }
}