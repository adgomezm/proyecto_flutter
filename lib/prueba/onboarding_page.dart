import 'package:escape_life/components/round_button.dart';
import 'package:escape_life/constants.dart';
import 'package:escape_life/db/entities/usuario.dart';
import 'package:escape_life/screens/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:escape_life/screens/home/home_screen.dart';
import 'package:provider/src/provider.dart';

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: '¿Qué te consideras?',
              bodyWidget: Column(
                children: <Widget>[
                  RoundedButton(
                    text: "Aventurero",
                    press: () {},
                  ),
                  RoundedButton(
                    text: "Investigador",
                    press: () {},
                  )
                ],
              ),
              image: buildImage('assets/images/castle.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Entre una nave espacial y un castillo. ¿Cuál escogerías?',
              bodyWidget: Column(
                children: <Widget>[
                  RoundedButton(
                    text: "Nave espacial",
                    press: () {},
                  ),
                  RoundedButton(
                    text: "Castillo",
                    press: () {},
                  )
                ],
              ),
              image: buildImage('assets/images/castleovni.png'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Vivo en tus paredes',
              bodyWidget: Column(
                children: <Widget>[
                  RoundedButton(
                    text: "Vivo en tus paredes",
                    press: () {},
                  ),
                  RoundedButton(
                    text: "Vivo en tus paredes",
                    press: () {},
                  )
                ],
              ),
              image: buildImage('assets/images/ola.jpg'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Si tuvieras que elegir. ¿Cuál escogerías?',
              bodyWidget: Column(
                children: <Widget>[
                  RoundedButton(
                    text: "PagMan",
                    press: () {},
                  ),
                  RoundedButton(
                    text: "PagMan",
                    press: () {},
                  )
                ],
              ),
              image: buildImage('assets/images/d90.png'),
              decoration: getPageDecoration(),
            ),
          ],
          done: Text('Finalizar',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              )),
          onDone: () => goToHome(context),
          showSkipButton: true,
          skip: Text(
            'Saltar',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onSkip: () => goToHome(context),
          next: Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
          dotsDecorator: getDotDecoration(),

          globalBackgroundColor: Theme.of(context).primaryColor,
          skipFlex: 0,
          nextFlex: 0,
          // isProgressTap: false,
          // isProgress: false,
          // showNextButton: false,
          // freeze: true,
          // animationDuration: 1000,
        ),
      );

  void goToHome(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) {
          final firebaseUser = context.watch<Usuario>();

          if (firebaseUser != null) {
            return HomeScreen();
          }
          return RegisterScreen();
        }),
      );

  Widget buildImage(String path) => Center(
          child: Image.asset(
        path,
        width: 350,
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
