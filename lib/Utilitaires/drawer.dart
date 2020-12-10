import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:skill_check/Ecran/DrawerFile/Loader.dart';
import 'package:skill_check/Ecran/DrawerFile/ecranProfil.dart';

class CustomDrawer extends StatefulWidget{

  final String statusString;
  final Map<String,dynamic> profil;
  final bool isInListe;

  CustomDrawer({Key key, this.isInListe, @required this.statusString, this.profil}) : super(key : key);
  @override
  DrawerEtat createState() => new DrawerEtat();

}

class DrawerEtat extends State<CustomDrawer>{
  bool estEleve;
  
  @override
  Widget build(BuildContext context) {
    if (widget.statusString == "Éleve")
    {
      estEleve = true;
    }
    else
      estEleve = false;
    return new Drawer(
    child: ListView(
      padding:EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
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
        //Profil

          Card(
            child: ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profil'),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                    EcranProfil(
                                  profil: widget.profil,
                                  status: widget.statusString,
                                )
                  )
                );
              },
            ),
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
          child : Card(
            child: ListTile(
              leading: Icon(Icons.book_rounded),
              title: Text('Vos Cours'),
              onTap: (){
                      Navigator.pop(context);
                    },
            ),
          ),
          replacement: Card(
            child: ListTile(
              leading: Icon(Icons.bookmarks),
              title: Text('Ajouter Vos Compétences'),
              onTap: (){
                      Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),  
    );
  }
  
}

