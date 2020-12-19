import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

final kHintTextStyle = TextStyle(
  color: Colors.white70,
  fontFamily: 'Kufam',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'Kufam',
);

final ktitlelist = TextStyle(
  color: Colors.cyan[50],
  fontWeight: FontWeight.bold,
  fontFamily: 'Kufam',
); 

final kOptionStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontFamily: 'Kufam',
);

final kDrawerTitle = TextStyle(
  color: Colors.cyan[700],
  fontWeight: FontWeight.bold,
  fontFamily: 'Kufam',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xbd7a05),
  borderRadius: BorderRadius.circular(11.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final klistItem = TextStyle(
  color: Colors.white,
  fontFamily: 'Kufam',
  fontSize: 14,
);

final colorGradient = Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.cyan[300],
                Colors.cyan[400],
                Colors.cyan,
                Colors.cyan[600],
            ],
            ),
          ),
        ); 


progressdial(BuildContext context, String message)
{
  ProgressDialog pr =  ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
  pr.style(
    message: 'Connection en cours...',
    borderRadius: 20.0,
    backgroundColor: Colors.white,
    progressWidget: CircularProgressIndicator(),
    elevation: 50.0,
    insetAnimCurve: Curves.easeInOut,
    messageTextStyle: TextStyle(
     color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
  );

  return pr;
}

popdial(BuildContext context, String message)
{
  return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(message),
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
