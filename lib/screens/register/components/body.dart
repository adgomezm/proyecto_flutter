// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:escape_life/components/my_divider.dart';
import 'package:escape_life/db/firebase/user_auth.dart';
import 'package:escape_life/components/round_button.dart';
import 'package:escape_life/components/rounded_input_field.dart';
import 'package:escape_life/components/rounded_pass_field.dart';
import 'package:escape_life/components/verifica_cuenta.dart';
import 'package:escape_life/screens/home/home_screen.dart';
import 'package:escape_life/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../constants.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
  const Body({
    this.opcionesSeleccionadas,
  });

  final List<String> opcionesSeleccionadas;
}

class _BodyState extends State<Body> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController empresaController = TextEditingController();

  String nombre = '';
  String email = '';
  String password = '';
  String empresa = '';
  String error = '';
  bool admin = false;
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
              hintText: "Nombre de usuario",
              onChanged: (value) {
                setState(() => nombre = value);
              },
              icon: Icons.person,
            ),
            admin
                ? RoundedInputField(
                    controller: empresaController,
                    hintText: "Empresa",
                    validator: (value) => value.isEmpty
                        ? 'Introduce el nombre de tu empresa'
                        : null,
                    onChanged: (value) {
                      setState(() => empresa = value);
                    },
                    icon: Icons.business,
                  )
                : SizedBox(),
            RoundedInputField(
              controller: emailController,
              hintText: "Correo electrónico",
              validator: (value) => value.isEmpty ? 'Introduce un email' : null,
              onChanged: (value) {
                setState(() => email = value);
              },
              icon: Icons.mail,
            ),
            RoundPassInput(
              controller: passController,
              hintText: "Contraseña",
              validator: (value) => value.length < 6
                  ? 'La contraseña debe de contener más de 6 caracteres'
                  : null,
              onChanged: (value) {
                setState(() => password = value);
              },
            ),
            RoundedButton(
              text: "Registrarse",
              press: () async {
                if (_formKey.currentState.validate()) {
                  dynamic result;
                  if (admin) {
                    result = await _auth.registerWithEmailAndPassword(
                        nombre, email, password,
                        empresa: empresa, isAdmin: admin);
                  } else {
                    result = await _auth.registerWithEmailAndPassword(
                        nombre, email, password,
                        opcionesSeleccionadas: widget.opcionesSeleccionadas);
                  }
                  if (result == null) {
                    setState(() {
                      error = 'Introduce un email valido';
                      debugPrint(error);
                    });
                  } else {
                    if (mounted) {
                      final navigator = Navigator.of(context);
                      await showDialog(
                        context: context,
                        builder: (_) => HomeScreen(),
                      );
                      navigator.pop();
                    }
                  }
                }
              },
            ),
            VerificacionCuenta(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: admin,
                  onChanged: (value) => {
                    setState(() => admin = !admin),
                  },
                ),
                Text(
                  'Cuenta de admin',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
