import 'package:flutter/material.dart';
import 'package:spa/formulario.dart';
import 'package:spa/login_page.dart';

class PerfilPage extends StatefulWidget {
  static String tag = 'tag-p';
  @override
  _Perfil createState() => new _Perfil();
}

class _Perfil extends State<PerfilPage> {
  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 100.0,
        child: Image.asset('images/guru-icon.png'),
      ),
    );

    final exitButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.white,
        elevation: 5.0,
        child: MaterialButton(
          color: Colors.lime.shade400,
          child: Text('Cerrar Sesion', style: TextStyle(color: Colors.black)),
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
        ),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Editar',
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Formulario()));
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.8, right: 24.0),
          children: <Widget>[
            logo,
            forgotLabel,
            exitButton,
          ],
        ),
      ),
    );
    //return new Container();
  }
}
