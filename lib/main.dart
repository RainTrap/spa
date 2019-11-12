import 'package:flutter/material.dart';
import 'login_page.dart';
import 'root_page.dart';

//pantalla principal
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RELAX SPA',
      debugShowCheckedModeBanner: false, // saco la cinta por defecto
      theme: ThemeData(
        primarySwatch: Colors.lime, // le doy un color
        fontFamily: 'Handlee',
      ),
      home: new RootPage(), //llamo a mi pagina de inicio de sesion para ser la primera que se muestre
    );
  }
}
