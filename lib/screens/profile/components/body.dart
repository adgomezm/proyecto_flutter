import 'package:escape_life/components/button_widget.dart';
import 'package:escape_life/db/entities/usuario.dart';
import 'package:escape_life/screens/profile/components/ajustes_usuario.dart';
import 'package:escape_life/screens/profile/components/profile_widget.dart';
import 'package:escape_life/screens/grid_escaperooms/grid_escaperooms.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../db/entities/escaperoom.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final escaperooms = Provider.of<List<Escaperoom>>(context);
    final usuarios = Provider.of<List<Usuario>>(context) ?? [];
    final usuario = Provider.of<Usuario>(context);
    final Usuario user =
        usuarios.singleWhere((i) => i.id == usuario.id, orElse: () => null);

    return Column(
      children: [
        ProfileWidget(
          user: user,
        ),
        const SizedBox(height: 14),
        buildName(user),
        const SizedBox(height: 34),
        ButtonWidget(
          text: 'Salas favoritas',
          icon: Icons.favorite,
          onClicked: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => GridEscaperooms(
                appbar: 0,
                escaperoomSearch: const [],
                escaperooms: escaperooms,
                user: user,
                filtro: "favoritas",
                preferencias: false,
              ),
            ));
          },
        ),
        ButtonWidget(
          text: 'Completadas',
          icon: Icons.check,
          onClicked: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => GridEscaperooms(
                appbar: 0,
                escaperoomSearch: const [],
                escaperooms: escaperooms,
                user: user,
                filtro: "completadas",
                preferencias: false,
              ),
            ));
          },
        ),
        //Crear formulario de ajustes de usuario y pagina de detalles de reserva
        ButtonWidget(
          text: 'Ajustes',
          icon: Icons.settings,
          onClicked: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Ajustes(
                  user: user,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget buildName(Usuario user) => Column(
        children: [
          Text(
            user.nombre,
            style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: GoogleFonts.ubuntu(color: Colors.grey),
          )
        ],
      );
}
