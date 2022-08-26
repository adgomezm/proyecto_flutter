import 'package:escape_life/db/entities/escaperoom.dart';
import 'package:escape_life/db/entities/usuario.dart';
import 'package:escape_life/db/firebase/database.dart';
import 'package:escape_life/functions/useful_functions.dart';
import 'package:flutter/material.dart';
import 'package:escape_life/db/firebase/storage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants.dart';
import 'icon_card.dart';

class ImageAndIcons extends StatefulWidget {
  const ImageAndIcons({
    this.size,
    this.image,
    this.escaperoom,
    this.user,
  });
  final Usuario user;
  final Size size;
  final String image;
  final Escaperoom escaperoom;
  @override
  State<ImageAndIcons> createState() => _ImageAndIconsState();
}

class _ImageAndIconsState extends State<ImageAndIcons> {
  bool pressed;
  @override
  void initState() {
    super.initState();
    pressed =
        widget.user.favoritas.contains(widget.escaperoom.id) ? true : false;
  }

  final Storage storage = Storage();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding * 0.9),
      child: SizedBox(
        height: widget.size.height * 0.81,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconCard(icon: Icons.timer),
                  Text(
                    widget.escaperoom.tiempo,
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  IconCard(icon: Icons.graphic_eq),
                  Text(
                    capitalizeOnlyFirstLater(widget.escaperoom.dificultad),
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  IconCard(icon: Icons.people),
                  Text(
                    "${widget.escaperoom.jugadoresMin} - ${widget.escaperoom.jugadoresMax}",
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  IconCard(icon: Icons.location_on),
                  Text(
                    capitalizeOnlyFirstLater(widget.escaperoom.ciudad),
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  IconCard(
                    icon: pressed ? Icons.star : Icons.star_border,
                    onPressed: () {
                      setState(() {
                        pressed = !pressed;
                      });
                      pressed
                          ? DatabaseService().addArrayData("favoritas",
                              widget.escaperoom.id, widget.user.uid)
                          : DatabaseService().removeArrayData("favoritas",
                              widget.escaperoom.id, widget.user.uid);
                    },
                  ),
                  Text(
                    !pressed ? "Añadir a favoritos" : "Quitar de favoritos",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder(
              future: storage.downloadURL(widget.image),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Container(
                    height: widget.size.height * 0.8,
                    width: widget.size.width * 0.75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(63),
                        bottomLeft: Radius.circular(63),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 60,
                          color: kPrimaryColor.withOpacity(0.29),
                        ),
                      ],
                      image: DecorationImage(
                        alignment: Alignment.center,
                        fit: BoxFit.fitHeight,
                        image: NetworkImage(snapshot.data),
                      ),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting &&
                    !snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
