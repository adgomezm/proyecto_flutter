import 'package:flutter/material.dart';
import 'package:escape_life/screens/users_ranking/components/body.dart';

import '../../components/app_bar.dart';
import '../../db/entities/escaperoom.dart';

class UsersRanking extends StatelessWidget {
  const UsersRanking({
    this.escaperooms,
  });
  final List<Escaperoom> escaperooms;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent().buildAppBar(),
      body: Body(
        escaperooms: escaperooms,
      ),
    );
  }
}
