import 'package:escape_life/db/entities/escaperoom.dart';
import 'package:escape_life/db/entities/usuario.dart';
import 'package:escape_life/functions/useful_functions.dart';
import 'package:escape_life/screens/details/components/descripcion.dart';
import 'package:escape_life/screens/reserve/reserve.dart';
import 'package:flutter/material.dart';
import 'package:escape_life/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'image_and_icons.dart';
import 'title_and_price.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
    this.escaperoom,
    this.user,
  }) : super(key: key);
  final Usuario user;
  final Escaperoom escaperoom;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ImageAndIcons(
            size: size,
            image: widget.escaperoom.imagen,
            escaperoom: widget.escaperoom,
            user: widget.user,
          ),
          TitleAndPrice(
              title: widget.escaperoom.nombre,
              country: capitalizeOnlyFirstLater(widget.escaperoom.ciudad),
              price: widget.escaperoom.precio),
          Row(
            children: <Widget>[
              SizedBox(
                width: size.width / 2,
                height: 84,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                      ),
                    ),
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Reserves(
                            user: widget.user, escaperoom: widget.escaperoom),
                      ),
                    );
                  },
                  child: Text(
                    "Reservar",
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: size.width / 2,
                height: 84,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    primary: Colors.white,
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Descripcion(
                            descripcion: widget.escaperoom.descripcion),
                      ),
                    );
                  },
                  child: Text(
                    "Descripción",
                    style: GoogleFonts.ubuntu(
                      color: kSecondaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
