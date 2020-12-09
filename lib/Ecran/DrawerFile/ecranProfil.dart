import 'package:skill_check/Utilitaires/drawer.dart';
import 'package:flutter/material.dart';
import 'package:skill_check/Utilitaires/constantes.dart';

class EcranProfil extends StatefulWidget {

  final Map<String, dynamic> profil;
  final String status;

  EcranProfil({Key key, @required this.profil, this.status}) : super(key : key);

  @override
  EcranProfilEtat createState() => EcranProfilEtat();
  }

class EcranProfilEtat extends State<EcranProfil>{

  @override
  Widget build(BuildContext context){
    print(widget.status);
    return Scaffold(
      appBar: AppBar(
            title: Text('Profil',
            style: kDrawerTitle,
            ),
          ),
          drawer: CustomDrawer(
                                statusString: widget.status,
                                profil: widget.profil,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      CircleAvatar(
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
            //Navigator.pop(context);
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
            //Navigator.pop(context);
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