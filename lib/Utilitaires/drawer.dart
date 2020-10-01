import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:skill_check/Ecran/DrawerFile/ecranAccueil.dart';
import 'package:skill_check/Ecran/DrawerFile/ecranProfil.dart';

class CustomDrawer extends StatefulWidget{
  CustomDrawer({Key key}) : super(key : key);
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
          decoration: BoxDecoration(color: Colors.orange),
          accountName: Text("accountname"),
          accountEmail: Text("account@"),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
            ? Colors.white
            : Colors.white,
            child: Text("A",
            style: TextStyle(fontSize: 40.0),
            ),
          ),
        ),
        //Acceuil
        Card(
          child: ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Acceuil'),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) =>
                  EcranAccueil()
                  ),
              );
                  },
          ),
        ),
        //Profil
        Card(
          child: ListTile(
            leading: Icon(Icons.lock_open),
            title: Text('Profil'),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) =>
                  EcranProfil()
                  ),
              );
                  },
          ),
        ),
        //Infos Personnelles
        Card(
          child: ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Informations Personnelles'),
            onTap: (){
              /*Navigator.push(context,
              MaterialPageRoute(builder: (context) => EcranAccueil()
                    ),
                    );*/
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

