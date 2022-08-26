import 'package:escape_life/components/app_bar.dart';
import 'package:escape_life/constants.dart';
import 'package:escape_life/db/entities/escaperoom.dart';
import 'package:escape_life/db/entities/reserve.dart';
import 'package:escape_life/db/entities/usuario.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReserveInfo extends StatefulWidget {
  @override
  State<ReserveInfo> createState() => _ReserveInfoState();
  const ReserveInfo({
    this.escaperoom,
    this.reserve,
  });
  final Escaperoom escaperoom;
  final Reserve reserve;
}

class _ReserveInfoState extends State<ReserveInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent().buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: kDefaultPadding * 1.5,
              right: kDefaultPadding * 1.5,
              top: kDefaultPadding * 1.5,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Escaperoom",
                  style: GoogleFonts.ubuntu(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.escaperoom.nombre,
                  style: GoogleFonts.ubuntu(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Usuario",
                  style: GoogleFonts.ubuntu(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "${widget.reserve.nombre} (${widget.reserve.email})\n${widget.reserve.phonenumber}",
                  style: GoogleFonts.ubuntu(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Fecha",
                  style: GoogleFonts.ubuntu(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.reserve.fecha,
                  style: GoogleFonts.ubuntu(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Número de jugadores",
                  style: GoogleFonts.ubuntu(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.reserve.jugadores,
                  style: GoogleFonts.ubuntu(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
