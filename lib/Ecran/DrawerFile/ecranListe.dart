import 'package:flutter/material.dart';

import 'package:skill_check/Utilitaires/constantes.dart';
import 'package:skill_check/Utilitaires/drawer.dart';

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
            colorGradient,
            constructeurList(),
          ],
        ),
      );
  }
    Widget constructeurList(){
    return ListView.builder(
      itemCount: widget.message.length,
      itemBuilder: (BuildContext context, int index){
        return Container(
          height: 50,
          child : Center(
            child: Text('${widget.message[index]["0"]}')
          )
        );
      }
  ); 
  }
}
