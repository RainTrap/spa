// Este archivo define si va a ir a la pantalla de inicio de sesion o a la pagina principal

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'login_page.dart';
import 'home.dart';
import 'auth.dart';

class RootPage extends StatefulWidget {
  final BaseAuth auth = new Auth();

  @override
  State createState() => new RootPageState();
}

enum AuthStatus {
  notSignedIn, //Enumera el status del usuario no autentificado
  signedIn //Enumera el status del usuario autentificado
}

class RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;

  initState() {
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        authStatus =
        userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn(){
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut(){
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return new LoginPage(
          auth: widget.auth,
          onSignedIn: _signedIn,
        );
      case AuthStatus.signedIn:
        return new Home(
          auth: widget.auth,
          onSignedOut: _signedOut,
        );
    }
  }
}
