import 'package:flutter/material.dart';

final kHintTextStyle = TextStyle(
  color: Colors.white70,
  fontFamily: 'Kufam',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
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