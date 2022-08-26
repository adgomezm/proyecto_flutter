import 'package:escape_life/db/entities/usuario.dart';
import 'package:flutter/material.dart';
import 'package:escape_life/screens/public_profile/components/body.dart';

import '../../components/app_bar.dart';
import '../../db/entities/escaperoom.dart';

class PublicProfileScreen extends StatelessWidget {
  const PublicProfileScreen({
    this.appbar,
    this.usuario,
    this.escaperooms,
  });
  final int appbar;
  final Usuario usuario;
  final List<Escaperoom> escaperooms;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (appbar == 0) ? AppBarComponent().buildAppBar() : null,
      body: Body(escaperooms: escaperooms, usuario: usuario),
    );
  }
}
