import 'dart:convert';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:skill_check/Ecran/DrawerFile/ecranProfil.dart';
import 'package:skill_check/Utilitaires/constantes.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class ProfileModifier extends StatefulWidget
{

  final Map<String, dynamic> profil;
  final String status;

  ProfileModifier({Key key, @required this.profil, this.status }) : super(key: key);

  @override
  ProfilModifierEtat createState() => ProfilModifierEtat();
}

class ProfilModifierEtat extends State<ProfileModifier>
{
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController;

  bool valide;
  bool aImage = false;

  File _image;
  final selection = ImagePicker();
    @override
 
  void initState() {
    super.initState();
    
    emailController = TextEditingController(text: widget.profil["email"]);
    nameController = TextEditingController(text: widget.profil["nomPrenom"]);
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
            title: Text(
            'Modification du profil',
            style: kDrawerTitle,
            ),
          ),
          body:Stack(
            children: <Widget>[
              colorGradient,
              ListView(
            children: <Widget>[
              SizedBox(height : 20),
              constructeurIcone(),
              constructeurIconeBoutton(),
              SizedBox(height : 50),
              constructeurEmail(),
              SizedBox(height: 30,),
              constructeurNomPrenom(),
              SizedBox(height : 30),
              bouttonModifierCompte(),
            ],

            
          ),

            ],
          )         
    );
  }

    Widget constructeurIconeBoutton()
    {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
            width: MediaQuery. of(context). size. width / 2,
            child: RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
              elevation: 5.0,
              onPressed: () {
                uploaderImage();
                  },
              padding: EdgeInsets.all(15.0),
              color: Colors.cyan[900],
              child:Text(
                'Uploader',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Kufam',
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
            width: MediaQuery. of(context). size. width / 2,
            child: RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
              elevation: 5.0,
              onPressed: () {
                choixImage();
                  },
              padding: EdgeInsets.all(15.0),
              color: Colors.cyan[900],
              child:Text(
                'Choisir',
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Kufam',
                ),
              ),
            ),
          )
        ]
      );
    }
    Widget constructeurEmail(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left : 11),
          child : Text(
          'Email',
          style: kLabelStyle,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left : 10, right : 10),
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
               fontFamily: 'Kufam',
               fontSize: 13.0
               ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 18.0),
                prefixIcon: Icon(
                  Icons.email, 
                  color: Colors.white,
                ),
                hintText: 'Entrez votre adresse ici',
                hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget constructeurNomPrenom()
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left : 11),
          child : Text(
          'Nom Prénom',
          style: kLabelStyle,
          ),
        ),
        Container(
          margin: EdgeInsets.only(left : 10, right : 10),
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller:nameController,
            keyboardType: TextInputType.name,
            style: TextStyle(
              color: Colors.white,
               fontFamily: 'Kufam',
               fontSize: 13.0
               ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 18.0),
                prefixIcon: Icon(
                  Icons.account_box, 
                  color: Colors.white,
                ),
                hintText: 'Entrez votre nom et votre prénom ici',
                hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget constructeurIcone()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Visibility(
            visible: !aImage,
            child: CircleAvatar(
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
                backgroundImage: _image == null? null :new FileImage(_image),
              ),
            ),
          ),
        ],
    );
  }

  Widget bouttonModifierCompte()
  {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          modifier();
            },
        padding: EdgeInsets.all(15.0),
        color: Colors.cyan[900],
        child:Text(
          'Valider les changements',
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

  void constructeurDialogue(String text)
  {
    showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("l'entrée " + text + " est vide, veuillez la remplir"),
        actions: <Widget>[
          FlatButton(
           child: Text("Ok"),
           onPressed: () { Navigator.of(context).pop(); },
           ),
        ],
      );
    },
    );
  }

  Future choixImage() async
  {
    var imageChoisie = await selection.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(imageChoisie.path);      
    });
      String dir = path.dirname(_image.path);
      String newPath = path.join(dir, widget.profil['id'] + ".jpg");
      _image = await File(imageChoisie.path).copy(newPath);

      _image == null? aImage = false : aImage = true;
  }

  Future uploaderImage() async
  {
    if (_image!= null){
    final ProgressDialog pr =  ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
      pr.style(
      message: 'Modifications en cours...',
      borderRadius: 20.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 50.0,
      insetAnimCurve: Curves.easeInOut,
      messageTextStyle: TextStyle(
        color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600
        )
      );
        await pr.show();
        var url = 'https://flagrant-amusements.000webhostapp.com/imageUploader.php';

        var request = http.MultipartRequest('POST', Uri.parse(url));

        request.fields['id'] = widget.profil["id"];

        var img = await http.MultipartFile.fromPath("image", _image.path);
        request.files.add(img);

        var response = await request.send();
        await pr.hide();
        if (response.statusCode == 200)
        {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("Image chargée!"),
                actions: <Widget>[
                  FlatButton(
                  child: Text("Ok"),
                  onPressed: () { Navigator.of(context).pop(); },
                  ),
                ],
              );
            },
          );
        }
        else showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: new Text("erreur de chargement d'image"),
                actions: <Widget>[
                  FlatButton(
                  child: Text("Ok"),
                  onPressed: () { Navigator.of(context).pop(); },
                  ),
                ],
              );
            },
          );
  }
}
  
  Future modifier() async
  {
    String email = emailController.text;
    String name = nameController.text;

    if (email.isEmpty && name.isEmpty)
      constructeurDialogue("Email et votre Nom et Prenom");
    else if (email.isEmpty)
      constructeurDialogue("Email");
    else if (name.isEmpty)
      constructeurDialogue("Nom et Prenom");

    else{
      final ProgressDialog pr =  ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
      pr.style(
      message: 'Modifications en cours...',
      borderRadius: 20.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 50.0,
      insetAnimCurve: Curves.easeInOut,
      messageTextStyle: TextStyle(
        color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600
        )
      );
    await pr.show();
    var url = 'https://flagrant-amusements.000webhostapp.com/modifyer.php';

    int id = int.parse(widget.profil['id']);
    var data = {'email': email, 'nomPrenom' : name, 'id' : id};
  
    var response = await http.post(url, body: json.encode(data));
  
    // Getting Server response into variable.
    var message;
    message = jsonDecode(response.body);

    await pr.hide();

    if (message == "1")
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("cet Email est déjà existant"),
            actions: <Widget>[
              FlatButton(
              child: Text("Ok"),
              onPressed: () { Navigator.of(context).pop(); },
              ),
            ],
          );
        },
      );
    else if(message != "-1")
      {
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EcranProfil(
                                                             status : widget.status,
                                                             profil: message,
                                                             )
                                                          )
      );        
    }
    else
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text("Une erreur est survenue lors de la communication."),
            actions: <Widget>[
              FlatButton(
              child: Text("Ok"),
              onPressed: () { Navigator.of(context).pop(); },
              ),
            ],
          );
        },
      );
    }
  }
}