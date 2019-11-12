import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spa/display.dart';
import 'package:spa/home.dart';
import 'auth.dart';

//Pantalla Inicio sesiòn

class LoginPage extends StatefulWidget {
  static String tag = 'tag-p';
  @override
  _LoginPageState createState() => new _LoginPageState();
}



class _LoginPageState extends State<LoginPage> {
  final formKey = new GlobalKey<FormState>();

  String _correo;
  String _contrasenia;

  bool validateAndSave(){
    final form = formKey.currentState;
    if (form.validate()){
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        String userId = await widget.auth.signWithEmailAndPassword(_correo, _contrasenia);
        print('Inicio Sesión: $userId');
        widget.onSignedIn();
      }on PlatformException catch (e){
        String error = e.code;
        Map<String, String> errors = {
          "ERROR_INVALID_EMAIL": "Ingrese un correo electronico válido.",
          "ERROR_USER_NOT_FOUND":
          "El correo ingresado no pertenece a un usuario",
          "ERROR_WRONG_PASSWORD": "La contraseña es incorrecta"
        };
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("!Oh no!"),
            content: Text(errors[error]),
          ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 100.0,
        child: Image.asset('images/logo.png'),
      ),
    );
    Container(
        padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Correo Electronico',
                  labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
                validator: (value) =>
                value.isEmpty ? 'Completar campo' : null,
                onSaved: (value) => _correo = value,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                ),
                keyboardType: TextInputType.text,
                obscureText: true,
                validator: (value) =>
                value.isEmpty ? 'Completar campo' : null,
                onSaved: (value) => _contrasenia = value,
              ),
              SizedBox(height: 5.0),
              Container(
                alignment: Alignment(1.0, 0.0),
                padding: EdgeInsets.only(top: 15.0, left: 20.0),
                child: InkWell(
                  child: Text(
                    '¿Olvidó su contraseña?',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.0),
              Container(
                height: 55.0,
                child: Material(
                  borderRadius: BorderRadius.circular(40.0),
                  shadowColor: Colors.greenAccent,
                  color: Colors.green,
                  elevation: 5.0,
                  child: RaisedButton(
                    onPressed: validateAndSubmit,
                    child: Center(
                      child: Text(
                        'Ingresar',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
    SizedBox(
    height: 30.0,
    );
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    Text(
    '¿No tienes cuenta?',
    style: TextStyle(
    fontFamily: 'Montserrat',
    ),
    ),
    SizedBox(
    width: 5.0,
    ),
    InkWell(
    onTap: () {
    Navigator.of(context).push(MaterialPageRoute(
    builder: (BuildContext context) =>
    Formu (auth: widget.auth)));
    },
    child: Text(
    'Registrar',
    style: TextStyle(
    color: Colors.green,
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
    ),
    ),
    )
    ],
    );
    SizedBox(height: 30.0);
  }
}
