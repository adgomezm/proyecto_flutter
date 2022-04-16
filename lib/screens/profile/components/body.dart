import 'package:escape_life/db/entities/usuario.dart';
import 'package:flutter/material.dart';
import 'package:escape_life/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Usuario>(context);

    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: size.height * 0.3,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: constraints.maxHeight * 0.65,
                          width: constraints.maxWidth,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(29),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 40,
                              ),
                              Text(
                                user.nombre ?? "",
                                style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  color: kSecondaryColor,
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        "Completados",
                                        style: GoogleFonts.roboto(
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "10",
                                        style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          color: kSecondaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Container(
                                      height: 30,
                                      width: 5,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: kSecondaryColor),
                                    ),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        "Favoritos",
                                        style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "4",
                                        style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          color: kSecondaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Container(
                                      height: 30,
                                      width: 5,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: kSecondaryColor),
                                    ),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        "Rango",
                                        style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "1",
                                        style: GoogleFonts.roboto(
                                          fontSize: 15,
                                          color: kSecondaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: SizedBox(
                            width: constraints.maxWidth * 0.3,
                            child: Image.asset(
                              "assets/images/d90.png",
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: size.height * 0.4,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(29),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: kDefaultPadding,
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Salas favoritas",
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      color: kSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            // Meter foto de perfil  HeaderWithSearchBox(size: size),
            // Meter datos de usuario TitleWithMoreBtn(title: "Cerca de ti", press: () {}),
            // Meter botones de opciones para el usuario RecomendsEscaperooms(),
            //  TitleWithMoreBtn(title: "Las más votadas", press: () {}),
            //  FeaturedEscaperooms(),
            SizedBox(height: kDefaultPadding),
          ],
        ),
      ),
    );
  }
}
