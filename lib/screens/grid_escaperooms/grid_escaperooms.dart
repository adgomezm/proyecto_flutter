import 'package:escape_life/db/entities/escaperoom.dart';
import 'package:flutter/material.dart';
import 'package:escape_life/screens/grid_escaperooms/components/body.dart';

import '../../components/app_bar.dart';
import '../../db/entities/usuario.dart';

class GridEscaperooms extends StatelessWidget {
  const GridEscaperooms({
    this.escaperoomSearch,
    this.appbar,
    this.escaperooms,
    this.user,
    this.filtro,
    this.preferencias,
  });
  final bool preferencias;
  final String filtro;
  final Usuario user;
  final int appbar;
  final List<Escaperoom> escaperoomSearch;
  final List<Escaperoom> escaperooms;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (appbar == 0) ? AppBarComponent().buildAppBar() : null,
      body: Body(
        escaperoomSearch: escaperoomSearch,
        escaperooms: escaperooms,
        user: user,
        filtro: filtro,
        preferencias: preferencias,
      ),
    );
  }
}
