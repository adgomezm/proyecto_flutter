// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:escape_life/components/app_bar.dart';
import 'package:escape_life/components/my_divider.dart';
import 'package:escape_life/components/rounded_pass_field.dart';
import 'package:escape_life/db/entities/usuario.dart';
import 'package:escape_life/components/round_button.dart';
import 'package:escape_life/components/rounded_input_field.dart';
import 'package:escape_life/db/firebase/database.dart';
import 'package:escape_life/db/firebase/user_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

class Ajustes extends StatefulWidget {
  @override
  State<Ajustes> createState() => _AjustesState();
  const Ajustes({
    this.user,
  });
  final Usuario user;
}

class _AjustesState extends State<Ajustes> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController passConfController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AuthService auth = AuthService();
  String nombre = '';
  String password = '';
  String passwordConf = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent().buildAppBar(),
      body: StreamProvider<Usuario>.value(
        initialData: null,
        value: AuthService().user,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: kDefaultPadding * 2,
                  horizontal: kDefaultPadding * 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Ajustes de usuario',
                      style: GoogleFonts.ubuntu(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center),
                  MyDivider(),
                  RoundedInputField(
                    hintText: "Nombre de usuario",
                    onChanged: (value) {
                      setState(() => nombre = value);
                    },
                    icon: Icons.person,
                  ),
                  RoundPassInput(
                    controller: passController,
                    hintText: "Contraseña",
                    validator: (value) => value.length == 0
                        ? null
                        : (value.length < 6
                            ? 'La contraseña debe de contener más de 6 caracteres'
                            : null),
                    onChanged: (value) {
                      setState(() => password = value);
                    },
                  ),
                  RoundPassInput(
                    controller: passConfController,
                    hintText: "Confirmacion de contraseña",
                    validator: (value) => password.isEmpty
                        ? null
                        : (value.length < 6
                            ? 'La contraseña debe de contener más de 6 caracteres'
                            : (password != passwordConf)
                                ? 'Las contraseñas deben coincidir'
                                : null),
                    onChanged: (value) {
                      setState(() => passwordConf = value);
                    },
                  ),
                  RoundedButton(
                    text: "Confirmar",
                    press: () async {
                      if (_formKey.currentState.validate()) {
                        dynamic result;
                        result = auth.changePassword(passwordConf);
                        nombre.isEmpty
                            ? null
                            : DatabaseService()
                                .changeUsername(nombre, widget.user.uid);
                        if (result == null) {
                          setState(() {
                            error = 'Ha habido un error';
                            debugPrint(error);
                          });
                        } else {
                          if (mounted) {
                            final navigator = Navigator.of(context);
                            navigator.pop();
                          }
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
