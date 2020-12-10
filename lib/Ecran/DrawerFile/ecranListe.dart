import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:skill_check/Utilitaires/constantes.dart';
import 'package:skill_check/Utilitaires/drawer.dart';

class EcranListe extends StatefulWidget {

  final List<dynamic> message;
  final Map<String, dynamic> profil;
  final String statusString;

  EcranListe({Key key, @required this.message, this.profil, this.statusString}) : super(key: key);

  @override
  EcranListeEtat createState() => EcranListeEtat();
  }


class EcranListeEtat extends State<EcranListe> 
{

  @override 
  Widget build(BuildContext context)
  {
    print(widget.message);
    return Scaffold(
          appBar: AppBar(
            title: Text('Liste',
            style: kLabelStyle,
            ),
          ),
          drawer: CustomDrawer(
            profil: widget.profil,
            statusString: widget.statusString,
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
                      print("apuillé");
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
        );
      }
  ); 
  }
}
