import 'package:flutter/material.dart';
import 'package:my_son_birthday/screens/home.dart';
import 'package:my_son_birthday/screens/newRegister.dart';
import 'package:my_son_birthday/screens/editRegister.dart';


void main() => runApp(new MaterialApp(
      title: "Recordatorio Cumpleaños",
      home: new HomeScreen(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new HomeScreen(),
        '/form': (BuildContext context) => new NewRegisterScreen(),
        '/edit': (BuildContext context) => new EditRegisterScreen(null)
      },
    ));
