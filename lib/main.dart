import 'package:flutter/material.dart';
import 'package:my_son_birthday/screens/home.dart';
import 'package:my_son_birthday/screens/newRegister.dart';
import 'package:my_son_birthday/screens/editRegister.dart';


void main() => runApp(new MaterialApp(
      title: "Recordatorio Cumpleaños",
      theme: ThemeData(primaryColor: Colors.blueAccent[400]),
      home: new HomeScreen(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new HomeScreen(),
        '/register': (BuildContext context) => new NewRegisterScreen(),
        '/edit': (BuildContext context) => new EditRegisterScreen(null)
      },
    ));
