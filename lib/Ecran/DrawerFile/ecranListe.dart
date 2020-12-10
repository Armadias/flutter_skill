import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:skill_check/Utilitaires/constantes.dart';
import 'package:skill_check/Utilitaires/drawer.dart';
import 'package:skill_check/Ecran/DrawerFile/LoaderCompetences.dart';

class EcranListe extends StatefulWidget {

  final List<dynamic> message;
  final Map<String, dynamic> profil;
  final String statusString;

  EcranListe({Key key, this.message, @required  this.profil, this.statusString}) : super(key: key);

  @override
  EcranListeEtat createState() => EcranListeEtat();
  }


class EcranListeEtat extends State<EcranListe> 
{

  @override 
  Widget build(BuildContext context)
  {
    return Scaffold(
          appBar: AppBar(
            title: Text('Liste',
            style: kLabelStyle,
            ),
          ),
          drawer: CustomDrawer(
            profil: widget.profil,
            statusString: widget.statusString,
            isInListe: true,
          ),
           body: Stack(
             children: <Widget>[
            colorGradient,
            constructeurList(),
          ],
        ),
      );
  }
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
                    onTap: () {
                      Navigator.push(
                        context,
                          MaterialPageRoute(builder: (context) => LoaderCompetences(
                            profil: widget.profil,
                            statusString: widget.statusString,
                            listEleve : widget.message,
                            idEleve: int.parse(widget.message[index]["id"]))),
            );
                    },
                    child : Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height/  15,
                      child : Center(
                        child : Text(
                          '${widget.message[index]["0"]}',
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
}
