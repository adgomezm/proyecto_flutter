import 'package:flutter/material.dart';

import '../constants.dart';

class VerificacionCuenta extends StatelessWidget {
  final bool login;
  final Function press;
  const VerificacionCuenta({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "¿No tienes una cuenta? " : "¿Ya tienes una cuenta? ",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            primary: kPrimaryColor,
          ),
          onPressed: press,
          child: Text(
            login ? "¡Regístrate!" : "¡Inicia sesión!",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
