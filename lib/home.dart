import 'package:flutter/material.dart';
import 'package:spa/perfil.dart';
import 'package:spa/tiempolibre.dart';
import 'List.dart';
import 'tiempolibre.dart';
import 'auth.dart';

//Pantalla de mi barra de navegacion
class Home extends StatefulWidget {
  State<StatefulWidget> createState() => _HomeState(); //0*71
}

abstract class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    //lista de como van a ir mis objetos
    ExpansionTileSample(), //muestra pantalla de informacion
    TiempoLibre(), //muestra pantalla de tratamientos
    PerfilPage(), //muestra pantalla del perfil
  ];

  Home({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text ('Relax Spa', textAlign: TextAlign.center),
        automaticallyImplyLeading: false,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        //creo mi barra de navegacion
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        fixedColor: Colors.lime,
       type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          //defino lo que va a ir en el
          BottomNavigationBarItem(
            //primera pantalla
            icon: Icon(Icons.info),
            title: Text('InformaciÓn'),
          ),
          BottomNavigationBarItem(
            //segunda pantalla
            icon: Icon(Icons.calendar_today),
            title: Text('Turnos'),
          ),
          BottomNavigationBarItem(
            //tercera pantalla
            icon: Icon(Icons.account_circle),
            title: Text('Perfil'),
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
