import 'package:flutter/material.dart';

import 'package:skill_check/Utilitaires/constantes.dart';
import 'package:skill_check/Utilitaires/drawer.dart';
import 'package:skill_check/Ecran/DrawerFile/ecranCompetences.dart';

class EcranListe extends StatefulWidget {

  final List<dynamic> message;
  final String id;
  final String name;
  final String email;
  final String password;
  final String status;

  EcranListe({Key key, @required this.id, this.name, this.email, this.password, this.status, this.message}) : super(key: key);

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
          drawer: CustomDrawer(id : widget.id,
                                name: widget.name,
                                email: widget.email,
                                password: widget.password,
                                status: widget.status),
           body: Stack(children: <Widget>[
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.red,
                    Colors.orange,
                    Colors.orangeAccent,
                    Colors.deepOrange,
                ],
                stops: [0.1,0.4,0.7,0.9],
                ),
              ),
            ),
            constructeurList(),
          ],
        ),
      );
  }
    Widget constructeurList(){
    return ListView.builder(
      itemCount: widget.message.length,
      itemBuilder: (BuildContext context, int index){
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
        );
      }
    ); 
    }
}
