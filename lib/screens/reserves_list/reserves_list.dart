import 'package:escape_life/components/app_bar.dart';
import 'package:escape_life/db/entities/escaperoom.dart';
import 'package:escape_life/db/entities/usuario.dart';
import 'package:flutter/material.dart';
import 'package:escape_life/screens/reserves_list/components/body.dart';

class ReservesList extends StatelessWidget {
  const ReservesList({
    this.user,
    this.escaperooms,
  });
  final Usuario user;
  final List<Escaperoom> escaperooms;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent().buildAppBar(),
      body: Body(
        user: user,
        escaperooms: escaperooms,
      ),
    );
  }
}
