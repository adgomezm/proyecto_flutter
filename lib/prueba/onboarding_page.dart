import 'package:escape_life/components/round_button.dart';
import 'package:escape_life/constants.dart';
import 'package:escape_life/db/entities/usuario.dart';
import 'package:escape_life/screens/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:escape_life/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class OnBoardingPage extends StatelessWidget {
  final List<String> opcionesSeleccionadas = [];
  bool pressed = false;
  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: '¿Quieres pasar miedo o prefieres una buena aventura?',
              bodyWidget: Column(
                children: <Widget>[
                  RoundedButton(
                    text: "Terror",
                    press: () {
                      if (opcionesSeleccionadas.contains("AVENTURA") ||
                          !opcionesSeleccionadas.contains("TERROR")) {
                        opcionesSeleccionadas.remove("AVENTURA");
                        opcionesSeleccionadas.add('TERROR');
                      } else if (opcionesSeleccionadas.contains("TERROR")) {
                        opcionesSeleccionadas.remove("TERROR");
                      }
                    },
                  ),
                  RoundedButton(
                    text: "Aventura",
                    press: () {
                      if (opcionesSeleccionadas.contains("TERROR") ||
                          !opcionesSeleccionadas.contains("AVENTURA")) {
                        opcionesSeleccionadas.remove("TERROR");
                        opcionesSeleccionadas.add('AVENTURA');
                      } else if (opcionesSeleccionadas.contains("AVENTURA")) {
                        opcionesSeleccionadas.remove("AVENTURA");
                      }
                    },
                  )
                ],
              ),
              image: Row(children: [
                SizedBox(width: 10),
                buildImage('assets/images/terror.png'),
                buildImage('assets/images/aventura.png'),
                SizedBox(width: 10),
              ]),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: '¿Quieres una experiencia tranquila o prefieres un reto?',
              bodyWidget: Column(
                children: <Widget>[
                  RoundedButton(
                    text: "Facil",
                    press: () {
                      if (opcionesSeleccionadas.contains("DIFICIL") ||
                          !opcionesSeleccionadas.contains("FACIL")) {
                        opcionesSeleccionadas.remove("DIFICIL");
                        opcionesSeleccionadas.add('FACIL');
                      } else if (opcionesSeleccionadas.contains("FACIL")) {
                        opcionesSeleccionadas.remove("FACIL");
                      }
                    },
                  ),
                  RoundedButton(
                    text: "Dificil",
                    press: () {
                      if (opcionesSeleccionadas.contains("FACIL") ||
                          !opcionesSeleccionadas.contains("DIFICIL")) {
                        opcionesSeleccionadas.remove("FACIL");
                        opcionesSeleccionadas.add('DIFICIL');
                      } else if (opcionesSeleccionadas.contains("DIFICIL")) {
                        opcionesSeleccionadas.remove("DIFICIL");
                      }
                    },
                  )
                ],
              ),
              image: Row(children: [
                SizedBox(width: 10),
                buildImage('assets/images/Facil.png'),
                buildImage('assets/images/dificil.png'),
                SizedBox(width: 10),
              ]),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: '¿Prefieres la fantasia o la ciencia ficcion?',
              bodyWidget: Column(
                children: <Widget>[
                  RoundedButton(
                    text: "Fantasia",
                    press: () {
                      if (opcionesSeleccionadas.contains("SCIFI") ||
                          !opcionesSeleccionadas.contains("FANTASIA")) {
                        opcionesSeleccionadas.remove("SCIFI");
                        opcionesSeleccionadas.add('FANTASIA');
                      } else if (opcionesSeleccionadas.contains("FANTASIA")) {
                        opcionesSeleccionadas.remove("FANTASIA");
                      }
                    },
                  ),
                  RoundedButton(
                    text: "SciFi",
                    press: () {
                      if (opcionesSeleccionadas.contains("FANTASIA") ||
                          !opcionesSeleccionadas.contains("SCIFI")) {
                        opcionesSeleccionadas.remove("FANTASIA");
                        opcionesSeleccionadas.add('SCIFI');
                      } else if (opcionesSeleccionadas.contains("SCIFI")) {
                        opcionesSeleccionadas.remove("SCIFI");
                      }
                    },
                  )
                ],
              ),
              image: Row(children: [
                SizedBox(width: 10),
                buildImage('assets/images/Fantasia.png'),
                buildImage('assets/images/scifi.png'),
                SizedBox(width: 10),
              ]),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: '¿Prefieres tu experiencia al aire libre o en interior?',
              bodyWidget: Column(
                children: <Widget>[
                  RoundedButton(
                    text: "Exterior",
                    press: () {
                      if (opcionesSeleccionadas.contains("INTERIOR") ||
                          !opcionesSeleccionadas.contains("EXTERIOR")) {
                        opcionesSeleccionadas.remove("INTERIOR");
                        opcionesSeleccionadas.add('EXTERIOR');
                      } else if (opcionesSeleccionadas.contains("EXTERIOR")) {
                        opcionesSeleccionadas.remove("EXTERIOR");
                      }
                    },
                  ),
                  RoundedButton(
                    text: "Interior",
                    press: () {
                      if (opcionesSeleccionadas.contains("EXTERIOR") ||
                          !opcionesSeleccionadas.contains("INTERIOR")) {
                        opcionesSeleccionadas.remove("EXTERIOR");
                        opcionesSeleccionadas.add('INTERIOR');
                      } else if (opcionesSeleccionadas.contains("INTERIOR")) {
                        opcionesSeleccionadas.remove("INTERIOR");
                      }
                    },
                  )
                ],
              ),
              image: Row(children: [
                SizedBox(width: 10),
                buildImage('assets/images/exterior.png'),
                buildImage('assets/images/interior.png'),
                SizedBox(width: 10),
              ]),
              decoration: getPageDecoration(),
            ),
          ],
          done: Text('Finalizar',
              style: GoogleFonts.ubuntu(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              )),
          onDone: () => {goToHome(context, opcionesSeleccionadas)},
          showSkipButton: true,
          skip: Text(
            'Saltar',
            style: GoogleFonts.ubuntu(
              color: Colors.white,
            ),
          ),
          onSkip: () => goToHome(context, opcionesSeleccionadas),
          next: Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
          dotsDecorator: getDotDecoration(),

          globalBackgroundColor: kBackgroundColor,
          skipOrBackFlex: 0,
          nextFlex: 0,
          // isProgressTap: false,
          // isProgress: false,
          // showNextButton: false,
          // freeze: true,
          // animationDuration: 1000,
        ),
      );

  void goToHome(context, opcionesSeleccionadas) =>
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) {
          final firebaseUser = context.watch<Usuario>();

          if (firebaseUser != null) {
            return HomeScreen();
          }
          return RegisterScreen(opcionesSeleccionadas: opcionesSeleccionadas);
        }),
      );

  Widget buildImage(String path) => Expanded(
          child: Image.asset(
        path,
        width: 100,
      ));

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: kSecondaryColor,
        activeColor: kSecondaryColor,
        //activeColor: Colors.orange,
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: GoogleFonts.specialElite(
          fontSize: 20,
          color: Colors.white,
        ),
        bodyTextStyle: GoogleFonts.specialElite(
          fontSize: 20,
          color: Colors.white,
        ),
        bodyFlex: 0,
        pageColor: kBackgroundColor,
      );
}
