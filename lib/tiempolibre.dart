import 'package:flutter/material.dart';
import 'package:spa/guardadoYLectura.dart';

//screen de turnos
List<String> _hora = [
  //horas de turnos
  '00',
  '01',
  '02',
  '03',
  '04',
  '05',
  '06',
  '07',
  '08',
  '09',
  '10',
  '11',
  '12',
  '13',
  '14',
  '15',
  '16',
  '17',
  '18',
  '19',
  '20',
  '21',
  '22',
  '23'
];

List<String> _minuto = [
  //minutos de turnos
  '00',
  '30',
];
List<String> _dia = [
  'Lunes',
  'Martes',
  'Miércoles',
  'Jueves',
  'Viernes'
]; //dia disponibles de turnos

String _libreDia,
    _libreDesde = '',
    _horaDesde,
    _minutoDesde; //declaracion string
//_libreHasta = '',
//_horaHasta,
//_minutoHasta;

List _tiemposLibres = [];

TextStyle _estilosFuente() {
  //estilo de fuente
  //tamaño fuente
  return TextStyle(
    fontSize: 20,
  );
}

class TiempoLibre extends StatefulWidget {
  @override
  _TiempoLibreState createState() => _TiempoLibreState();
}

class _TiempoLibreState extends State<TiempoLibre> {
  //clase tuempo libre
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    try {
      //lee los valores
      leerHorarios().then((onValue) {
        _tiemposLibres = onValue;
      });
      _crearListTiles(_tiemposLibres); //crea la lista
    } catch (e) {
      print("L");
    }
    return Container(
        /*  decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [Colors.blue],
        /*  stops: [0.1, 0.9], */
        begin: FractionalOffset.bottomCenter,
        end: FractionalOffset.topCenter,
      )), */
        child: Scaffold(
            backgroundColor: Colors.transparent, //fondo
            body: ListView(
                padding: const EdgeInsets.fromLTRB(10, 10, 10,
                    70), //direcciones cardinales, donde van a ir ubicados los objetos dentro del cuadro
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        15, 10, 15, 30), //direcciones cardinales del paddding
                    child: Center(
                      child: Text(
                        //nombre
                        '-Turnos -',
                        style: TextStyle(
                            //estilo del texto
                            fontSize: 25, //tamaño letra
                            letterSpacing: 3, //espacio de las letras
                            color: Colors.white), //color letra
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Card(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 5, right: 10),
                                      child:
                                          Text('Día:', style: _estilosFuente()),
                                    ),
                                    DropdownButton<String>(
                                      items: _dia.map((String opcionMostrada) {
                                        return DropdownMenuItem<String>(
                                          value: opcionMostrada,
                                          child: Text(opcionMostrada),
                                        );
                                      }).toList(),
                                      onChanged: (opcionSeleccionada) {
                                        setState(() {
                                          _libreDia = opcionSeleccionada;
                                        });
                                      },
                                      value: _libreDia,
                                      hint: Text('Día'),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Text(
                                          '*',
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: _libreDia == null
                                                  ? Colors.red
                                                  : Colors.transparent),
                                        )),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 5, right: 10),
                                      child: Text('Hora:',
                                          style: _estilosFuente()),
                                    ),

                                    /* DESDE */
                                    DropdownButton<String>(
                                      items: _hora.map((String opcionMostrada) {
                                        return DropdownMenuItem<String>(
                                          value: opcionMostrada,
                                          child: Text(opcionMostrada),
                                        );
                                      }).toList(),
                                      onChanged: (opcionSeleccionada) {
                                        setState(() {
                                          _horaDesde = opcionSeleccionada;
                                          _establecerDesde();
                                        });
                                      },
                                      value: _horaDesde,
                                      hint: Text('HH'),
                                    ),
                                    Text(':'),
                                    DropdownButton<String>(
                                      items:
                                          _minuto.map((String opcionMostrada) {
                                        return DropdownMenuItem<String>(
                                          value: opcionMostrada,
                                          child: Text(opcionMostrada),
                                        );
                                      }).toList(),
                                      onChanged: (opcionSeleccionada) {
                                        setState(() {
                                          _minutoDesde = opcionSeleccionada;
                                          _establecerDesde();
                                        });
                                      },
                                      value: _minutoDesde,
                                      hint: Text('MM'),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Text(
                                          '*',
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: _horaDesde == null ||
                                                      _minutoDesde == null
                                                  ? Colors.red
                                                  : Colors.transparent),
                                        )),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    /* HASTA */

                                    Padding(
                                      padding: EdgeInsets.only(top: 30),
                                      child: RaisedButton(
                                          child: Text(
                                            'Guardar',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color: Colors.green,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          onPressed: () {
                                            setState(() {
                                              if (_libreDia == null ||
                                                  _horaDesde == null ||
                                                  _minutoDesde == null) {
                                                Scaffold.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Por favor, ingrese sus horarios.'),
                                                  backgroundColor: Colors.red,
                                                ));
                                              } else {
                                                if (!_tiemposLibres.contains(
                                                    '$_libreDia, a $_libreDesde ')) {
                                                  _tiemposLibres.add(
                                                      '$_libreDia, a $_libreDesde ');
                                                  Scaffold.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content:
                                                        Text('Solicitado.'),
                                                    backgroundColor:
                                                        Colors.green,
                                                  ));
                                                  guardarHorarios(
                                                      _tiemposLibres);
                                                } else {
                                                  Scaffold.of(context)
                                                      .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'El horario ingresado ya existe.'),
                                                    backgroundColor: Colors.red,
                                                  ));
                                                }
                                              }
                                            });
                                          }),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 30),
                                      child: RaisedButton(
                                          child: Text(
                                            'Reiniciar horas',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          color: Colors.red,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          onPressed: () {
                                            setState(() {
                                              _libreDia = null;
                                              _horaDesde = null;
                                              _minutoDesde = null;
                                              //  _horaHasta = null;
                                              // _minutoHasta = null;
                                            });
                                          }),
                                    ),
                                    FlatButton.icon(
                                      color: Color.fromARGB(0, 0, 0, 0),

                                      label: Text(
                                        'Ver Turnos Pedidos',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      icon: ((!visible)
                                          ? Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.white,
                                            )
                                          : Icon(
                                              Icons.keyboard_arrow_up,
                                              color: Colors.white,
                                            )), //`Icon` to display//`Text` to display
                                      onPressed: () {
                                        setState(() {
                                          visible = !visible;
                                        });
                                      },
                                    ),
                                    visible
                                        ? Padding(
                                            padding: EdgeInsets.all(2),
                                            child:
                                                _crearListTiles(_tiemposLibres))
                                        : SizedBox(),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ]))
                ])));
  }

  void _establecerDesde() {
    if (_horaDesde == null && _minutoDesde != null) {
      _horaDesde = '00';
    }
    if (_minutoDesde == null && _horaDesde != null) {
      _minutoDesde = '00';
    }
    _libreDesde = '$_horaDesde:$_minutoDesde';
  }

  // void _establecerHasta() {
  // if (_horaHasta == null && _minutoHasta != null) {
  // _horaHasta = '00';
  // }
  //if (_minutoHasta == null && _horaHasta != null) {
  // _minutoHasta = '00';
  // }
  //_libreHasta = '$_horaHasta:$_minutoHasta';
  // }

  Column _crearListTiles(List _tiemposLibres) {
    return Column(
      children: _tiemposLibres
          .map((_tiempoLibre) => Card(
                  child: ListTile(
                title: Text('$_tiempoLibre'),
                leading: Icon(Icons.access_time),
                trailing: IconButton(
                  icon: Icon(Icons.delete_outline),
                  onPressed: () {
                    setState(() {
                      int indice = _tiemposLibres.indexOf(_tiempoLibre);
                      _tiemposLibres.removeAt(indice);
                      guardarHorarios(_tiemposLibres);
                    });
                  },
                ),
              )))
          .toList(),
    );
  }
}
