import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:skill_check/Ecran/DrawerFile/Loader.dart';

import 'package:skill_check/Ecran/DrawerFile/ecranAccueil.dart';
import 'package:skill_check/Ecran/DrawerFile/ecranProfil.dart';

class CustomDrawer extends StatefulWidget{
  final String id;
  final String name;
  final String email;
  final String password;
  final String status;
  final String statusString;
  final Map<String,dynamic> profil;

  CustomDrawer({Key key, @required this.id, this.name, this.email, this.password, this.status, this.statusString, this.profil}) : super(key : key);
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
          accountName: Text(widget.name),
          accountEmail: Text( 
         widget.profil["email"] + "\n" + widget.statusString
              ),
          currentAccountPicture: CircleAvatar(
            backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
            ? Colors.white
            : Colors.white,
            child: Text(widget.name[0],
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
                  EcranAccueil(id : widget.id,
                                name: widget.name,
                                email: widget.email,
                                password: widget.password,
                                status: widget.status,
                                statusString: widget.statusString,
                                message: widget.profil),
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
                  EcranProfil(
                                profil: widget.profil,
                                status: widget.statusString,
                              )
                  ),
              );
                  },
          ),
        ),
        //Infos Personnelles
        Card(
          child: ListTile(
            leading: Icon(Icons.lock_open),
            title: Text(() 
          {
            if (widget.status == "0")
              return "Liste de vos professeurs";
            else
              return "Liste de vos éleves";
          }()),
            onTap: (){
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) =>
                  Loader(id : widget.id,
                                name: widget.name,
                                email: widget.email,
                                password: widget.password,
                                status: widget.status)
                  ),
              );
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

