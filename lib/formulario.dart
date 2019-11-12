import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spa/perfil.dart';

//import 'package:spa/home.dart';
//Pantalla de formulario

class Formulario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Relax Spa',
      theme: new ThemeData(
        primarySwatch: Colors.lime, //color
      ),
      home: new MyHomePage(title: 'Relax Spa'), //titulo
    );
  }
}

//creo la clase en la que declaro las variables que usare mas adelante
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey =
      new GlobalKey<FormState>(); //llave global

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              //creo el formulario
              key: _formKey,
              autovalidate: true,
              child: new ListView(
                //orden de los objetos que apareceran en la pantalla
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  new TextFormField(
                    //primer campo de formulario=> nombre
                    decoration: const InputDecoration(
                      icon: const Icon(Icons
                          .person), //le pongo un icon de persona, para que se identifique
                      hintText:
                          'Escriba su primer y segundo nombre', //en este campo ira informacion sobre su nombre
                      labelText: 'Nombre',
                    ),
                  ),
                  new TextFormField(
                    // segundo campo de formulario => fecha nac
                    //
                    decoration: const InputDecoration(
                      icon: const Icon(Icons
                          .calendar_today), //le pongo el icon para que se identifique, en este caso de un candelario
                      hintText:
                          'Escriba su fecha de nacimiento', //informacion sobre su fecha de nacimiento
                      labelText: 'Fecha de nacimiento',
                    ),
                    keyboardType: TextInputType
                        .datetime, //se mostrara un teclado con numeros para que ponga la fecha
                  ),
                  new TextFormField(
                    //tercer campo => num telefonico
                    decoration: const InputDecoration(
                      icon: const Icon(Icons
                          .phone), //icon telefono ya que pide un numero celular
                      hintText: 'Escriba su numero de telefono',
                      labelText: 'Telefono',
                    ),
                    keyboardType: TextInputType
                        .phone, //teclado con numeros para que ponga el numero telefonico
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                  ),
                  new TextFormField(
                    //cuarto campo => email
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.email), //icon de email
                      hintText: 'Escriba su correo electronico', //
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType
                        .emailAddress, //tendra un telcado correspondiente para poner el email
                  ),
                  new Container(
                      //creo mi boton para registrarlo
                      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: new RaisedButton(
                        child: const Text('Guardar'),
                        color: Colors.lime,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PerfilPage(),
                            ),
                          );
                        },
                      )),
                ],
              ))),
    );
  }
}
