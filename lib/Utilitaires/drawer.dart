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

  
  @override
  Widget build(BuildContext context) => new Drawer(
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
              ));
             /* Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) =>
                  EcranProfil(
                                profil: widget.profil,
                                status: widget.statusString,
                              )
                  ),
              );*/
                  },
          ),
        ),
        //Infos Personnelles
        Card(
          child: ListTile(
            leading: Icon(Icons.list),
            title: Text(() 
          {
            if (widget.statusString == "Éleves")
              return "Liste de vos professeurs";
            else
              return "Liste de vos éleves";
          }()),
            onTap: (){
              if (!widget.isInListe){
                Navigator.of(context).pushReplacement(MaterialPageRoute(
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
        //Badges
        Card(
          child: ListTile(
            leading: Icon(Icons.stars),
            title: Text('Badges'),
            onTap: (){
              /*Navigator.push(context,
              MaterialPageRoute(builder: (context) => EcranAccueil()
                    ),
                    );*/
                    Navigator.pop(context);
                  },
          ),
        ),
        //Progression
        Card(
          child: ListTile(
            leading: Icon(Icons.assessment),
            title: Text('Progression'),
            onTap: (){
              /*Navigator.push(context,
              MaterialPageRoute(builder: (context) => EcranAccueil()
                    ),
                    );*/
                    Navigator.pop(context);
                  },
          ),
        ),
      ],
    ),  
  );

  
}

