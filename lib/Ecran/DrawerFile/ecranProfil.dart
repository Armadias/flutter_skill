import 'package:skill_check/Ecran/ProfilModificateur/ModifMdp.dart';
import 'package:skill_check/Ecran/ProfilModificateur/ProfileModifier.dart';
import 'package:skill_check/Utilitaires/drawer.dart';
import 'package:flutter/material.dart';
import 'package:skill_check/Utilitaires/constantes.dart';
import 'dart:math';

class EcranProfil extends StatefulWidget {

  final Map<String, dynamic> profil;
  final String status;

  EcranProfil({Key key, @required this.profil, this.status}) : super(key : key);

  @override
  EcranProfilEtat createState() => EcranProfilEtat();
  }

class EcranProfilEtat extends State<EcranProfil>{
  bool aImage;

  @override
  Widget build(BuildContext context){
    var random = new Random();
    String r = random.nextInt(100).toString();
    widget.profil["image"] == null? aImage = false : aImage = true; 
    return Scaffold(
      appBar: AppBar(
            title: Text(
            'Profil',
            style: kDrawerTitle,
            ),
          ),
          drawer: CustomDrawer(
            statusString: widget.status,
            profil: widget.profil,
            isInListe: false,
            ),
          body: ListView(
            children: <Widget>[
              Container(
                height: 250,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [                
                            Colors.cyan[300],
                            Colors.cyan[400],
                            Colors.cyan,
                            ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                        Container(
                          child: SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                          ),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Visibility (
                        visible: !aImage,
                        child:CircleAvatar(
                          backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                          ? Colors.white70
                          : Colors.white70,
                          minRadius: 60,
                          child: CircleAvatar(
                            minRadius: 50,
                            backgroundColor: Colors.white,
                          child : Text(widget.profil["nomPrenom"][0],
                          style: TextStyle(fontSize: 60.0),
                            ),
                          ),
                        ),
                        replacement: CircleAvatar(
                          backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                          ? Colors.white70
                          : Colors.white70,
                          minRadius: 60,
                          child: CircleAvatar(
                            minRadius: 50,
                            backgroundImage: NetworkImage(
                              "https://flagrant-amusements.000webhostapp.com/image/" + widget.profil["image"] + "?v=" + r,
                            ),
                          ),
                        ), 
                      ),
                    ],
                  ),
                SizedBox(
                  height: 10,
                ),
                Text( 
                 widget.profil["nomPrenom"],
                  style : TextStyle(
                    color : Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Kufam',
                  ),
                ),
                Text(
                  widget.status,
                  style : TextStyle(
                    color : Colors.white,
                    fontSize: 20,
                    fontFamily: 'Kufam',
                  ),
                )
                ],
                ),
              ),
              SizedBox(height : 10.0),
              Container(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: Text("Email",
                      style : TextStyle(
                    color : Colors.cyan,
                    fontSize: 20,
                    fontFamily: 'Kufam',
                  ),
                  ),
                  subtitle: Text(
                    widget.profil["email"],
                    style : TextStyle(
                    fontSize: 18
                  ),
                  ),
                  ),
 
                  ],
                ),
              ),
              Divider(thickness: 2,),
              SizedBox(height : 60),
              constructeurModifProfil(),
              constructeurModifMDP(),
            ],

            
          ),
        
    );

 }

  Widget constructeurModifMDP(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
              Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => 
              ModifMdp(
                profil : widget.profil,
                status: widget.status
              )) );
            },
        padding: EdgeInsets.all(15.0),
        color: Colors.cyan[900],
        child:Text(
          'Modifier le mot de passe',
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

    Widget constructeurModifProfil(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => 
              ProfileModifier(
                profil : widget.profil,
                status: widget.status
              )) );
            },
        padding: EdgeInsets.all(15.0),
        color: Colors.cyan[900],
        child:Text(
          'Modifier le profil',
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
  
}