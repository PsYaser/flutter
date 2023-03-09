import 'package:practica2/screenDawer/screenInfinita/guardados.dart';

import 'home.dart';
import 'package:flutter/material.dart';
import 'screenDawer/screenInfinita/infinita.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
    //Mapeo
    routes: <String, WidgetBuilder>{
      Infinita.routename: (BuildContext context) => Infinita(),
      Guardados.routename: (BuildContext context) => Guardados(),
    },
  ));
}
