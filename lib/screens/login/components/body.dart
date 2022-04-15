// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:escape_life/components/my_divider.dart';
import 'package:escape_life/components/or_divider.dart';
import 'package:escape_life/db/firebase/user_auth.dart';
import 'package:escape_life/components/round_button.dart';
import 'package:escape_life/components/rounded_input_field.dart';
import 'package:escape_life/components/rounded_pass_field.dart';
import 'package:escape_life/components/verifica_cuenta.dart';
import 'package:escape_life/screens/home/home_screen.dart';
import 'package:escape_life/screens/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  String nombre = '';
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      left: kDefaultPadding, right: kDefaultPadding, top: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/images/lockt.png",
                        width: 70,
                        height: 70,
                      ),
                      Text('Escape Life',
                          style: GoogleFonts.specialElite(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ],
            ),
            MyDivider(),
            RoundedInputField(
              controller: emailController,
              hintText: "Correo electrónico",
              validator: (value) => value.isEmpty ? 'Enter an email' : null,
              onChanged: (value) {
                setState(() => email = value);
              },
              icon: Icons.mail,
            ),
            RoundPassInput(
              controller: passController,
              validator: (value) =>
                  value.length < 6 ? 'Enter a password' : null,
              onChanged: (value) {
                setState(() => password = value);
              },
            ),
            RoundedButton(
              text: "Iniciar sesion",
              press: () async {
                if (_formKey.currentState.validate()) {
                  dynamic result =
                      await _auth.signInWithEmailAndPassword(email, password);
                  if (result == null) {
                    setState(() {
                      error = 'Could not sign in with those credentials';
                    });
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  }
                }
              },
            ),
            VerificacionCuenta(
              login: true,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterScreen(),
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.facebook,
                  color: Colors.white,
                ),
                Icon(
                  Icons.facebook,
                  color: Colors.white,
                ),
                Icon(
                  Icons.facebook,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
