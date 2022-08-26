import 'package:escape_life/components/app_bar.dart';
import 'package:escape_life/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Descripcion extends StatefulWidget {
  @override
  State<Descripcion> createState() => _DescripcionState();
  const Descripcion({
    this.descripcion,
  });
  final String descripcion;
}

class _DescripcionState extends State<Descripcion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarComponent().buildAppBar(),
          Container(
            padding: EdgeInsets.only(
              left: kDefaultPadding * 1.5,
              right: kDefaultPadding * 1.5,
              top: kDefaultPadding * 1.5,
            ),
            child: Text(
              widget.descripcion,
              style: GoogleFonts.ubuntu(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
