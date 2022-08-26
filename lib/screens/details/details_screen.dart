import 'package:escape_life/components/app_bar.dart';
import 'package:escape_life/db/entities/escaperoom.dart';
import 'package:escape_life/db/entities/usuario.dart';
import 'package:flutter/material.dart';
import 'package:escape_life/screens/details/components/body.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    Key key,
    this.escaperoom,
    this.user,
  }) : super(key: key);
  final Usuario user;

  final Escaperoom escaperoom;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent().buildAppBar(),
      body: Body(
        escaperoom: escaperoom,
        user: user,
      ),
    );
  }
}
