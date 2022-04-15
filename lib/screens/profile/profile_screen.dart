import 'package:flutter/material.dart';
import 'package:escape_life/screens/profile/components/body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key key,
    this.nombre,
  }) : super(key: key);
  final String nombre;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        nombre: nombre,
      ),
    );
  }
}
