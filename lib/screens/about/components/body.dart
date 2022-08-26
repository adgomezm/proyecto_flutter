import 'package:escape_life/components/app_bar.dart';
import 'package:escape_life/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBarComponent().buildAppBar(),
        Container(
          padding: EdgeInsets.only(
            left: kDefaultPadding * 1.5,
            right: kDefaultPadding * 1.5,
            top: kDefaultPadding * 1.5,
          ),
          child: Column(
            children: [
              Text(
                "Escape Life es el principal buscador de Escape Rooms en España, un proyecto empezado en 2021, a partir de un trabajo de fin de grado y que busca facilitar a todos los fans de los Escape Rooms un sitio donde encontrarlos todos de forma fácil y sencilla",
                style: GoogleFonts.ubuntu(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Esta aplicación ha sido desarrollada por Adam Gómez Mouti, un estudiante de Ingeniería Informática en Tecnologías de la Información en la UMH",
                style: GoogleFonts.ubuntu(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'App powered by Flutter',
                    style: GoogleFonts.ubuntu(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  FlutterLogo(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
