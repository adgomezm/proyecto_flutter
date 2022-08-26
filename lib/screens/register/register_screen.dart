import 'package:escape_life/components/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:escape_life/screens/register/components/body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({
    this.opcionesSeleccionadas,
  });

  final List<String> opcionesSeleccionadas;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent().buildAppBar(),
      body: Body(opcionesSeleccionadas: opcionesSeleccionadas),
    );
  }
}
