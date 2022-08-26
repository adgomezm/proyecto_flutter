import 'package:escape_life/constants.dart';
import 'package:escape_life/db/entities/escaperoom.dart';
import 'package:escape_life/db/entities/usuario.dart';
import 'package:escape_life/screens/reserve/components/body_unirse.dart';
import 'package:flutter/material.dart';
import 'package:escape_life/screens/reserve/components/body_reserva.dart';
import 'package:google_fonts/google_fonts.dart';

class Reserves extends StatelessWidget {
  const Reserves({
    this.escaperoom,
    this.user,
  });
  final Usuario user;
  final Escaperoom escaperoom;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Escape Life',
                style: GoogleFonts.specialElite(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              Image.asset(
                "assets/images/lockt.png",
                width: 40,
                height: 40,
              ),
            ],
          ),
          bottom: TabBar(
            tabs: const [
              Tab(
                text: 'Reservar',
              ),
              Tab(
                text: 'Unirse',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            BodyReserva(
              user: user,
              escaperoom: escaperoom,
            ),
            BodyUnirse(
              user: user,
              escaperoom: escaperoom,
            ),
          ],
        ),
      ),
    );
  }
}
