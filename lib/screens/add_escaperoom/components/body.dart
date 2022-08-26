// ignore_for_file: prefer_const_literals_to_create_immutables
import 'dart:io';

import 'package:escape_life/components/text_field.dart';
import 'package:escape_life/constants.dart';
import 'package:escape_life/db/firebase/database.dart';
import 'package:escape_life/components/round_button.dart';
import 'package:escape_life/components/rounded_input_field.dart';
import 'package:escape_life/db/firebase/storage.dart';
import 'package:escape_life/screens/home/home_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
  const Body({
    this.empresa,
  });

  final String empresa;
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController ciudadController = TextEditingController();
  final TextEditingController precioController = TextEditingController();
  final TextEditingController tiempoController = TextEditingController();
  final TextEditingController dificultadController = TextEditingController();
  final TextEditingController jugadoresMinController = TextEditingController();
  final TextEditingController jugadoresMaxController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController etiquetasController = TextEditingController();

  String nombre = '';
  String ciudad = '';
  String precio = '';
  String imagen = '';
  String tiempo = '';
  String dificultad = '';
  String jugadoresMin = '';
  String jugadoresMax = '';
  String descripcion = '';
  List<String> etiquetas = [];
  String error = '';

  final Storage storage = Storage();

  PlatformFile pickedFile;
  int timestamp = 0;
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  Future uploadFile() async {
    final file = File(pickedFile.path);
    timestamp = DateTime.now().millisecondsSinceEpoch;
    final path = 'assets/$timestamp';
    final ref = storage.storage.ref().child(path);

    ref.putFile(file);
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(value: "Fácil", child: Text("Fácil")),
      DropdownMenuItem(value: "Difícil", child: Text("Difícil")),
    ];
    return menuItems;
  }

  String selectedValue = "Fácil";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: SizedBox(
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RoundedInputField(
                hintText: "Nombre de escape room",
                validator: (value) =>
                    value.isEmpty ? 'Introduzca un nombre' : null,
                onChanged: (value) {
                  setState(() => nombre = value);
                },
                icon: Icons.person,
              ),
              RoundedInputField(
                  controller: ciudadController,
                  hintText: "Introduzca la ciudad",
                  validator: (value) =>
                      value.isEmpty ? 'Introduzca la ciudad' : null,
                  onChanged: (value) {
                    setState(() => ciudad = value);
                  },
                  icon: Icons.location_city),
              RoundedInputField(
                controller: precioController,
                hintText: "Introduzca el precio",
                validator: (value) =>
                    value.isEmpty ? 'Introduzca el precio' : null,
                onChanged: (value) {
                  setState(() => precio = value);
                },
                icon: Icons.monetization_on,
              ),
              RoundedInputField(
                controller: tiempoController,
                hintText: "Tiempo",
                validator: (value) => value.isEmpty
                    ? 'Introduzca el tiempo aprox. para completarlo'
                    : null,
                onChanged: (value) {
                  setState(() => tiempo = value);
                },
                icon: Icons.timer,
              ),
              TextFieldContainer(
                child: DropdownButtonFormField(
                    style: GoogleFonts.ubuntu(color: Colors.white),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.stars,
                        color: Colors.white,
                      ),
                      hintText: "Dificultad",
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    ),
                    validator: (value) =>
                        value.isEmpty ? 'Introduzca la dificultad' : null,
                    dropdownColor: kPrimaryColor,
                    value: selectedValue,
                    onChanged: (String newValue) {
                      setState(() {
                        selectedValue = newValue;
                        dificultad = newValue.toUpperCase();
                      });
                    },
                    items: dropdownItems),
              ),
              RoundedInputField(
                controller: jugadoresMinController,
                hintText: "Min. Jugadores",
                validator: (value) =>
                    value.isEmpty ? 'Introduzca el número de jugadores' : null,
                onChanged: (value) {
                  setState(() => jugadoresMin = value);
                },
                icon: Icons.people,
              ),
              RoundedInputField(
                controller: jugadoresMaxController,
                hintText: "Máx. Jugadores",
                validator: (value) =>
                    value.isEmpty ? 'Introduzca el número de jugadores' : null,
                onChanged: (value) {
                  setState(() => jugadoresMax = value);
                },
                icon: Icons.people,
              ),
              RoundedInputField(
                controller: descripcionController,
                hintText: "Introduzca una descripcion",
                onChanged: (value) {
                  setState(() => descripcion = value);
                },
                icon: Icons.text_snippet,
              ),
              RoundedInputField(
                controller: etiquetasController,
                hintText: "Introduzca las etiquetas",
                onChanged: (value) {
                  setState(() => etiquetas = value.toUpperCase().split(", "));
                },
                icon: Icons.tag,
              ),
              RoundedButton(
                  text: "Añadir imagen",
                  textColor: kSecondaryColor,
                  color: kPrimaryLightColor,
                  press: () async {
                    await selectFile();
                    await uploadFile();
                  }),
              RoundedButton(
                text: "Enviar",
                press: () async {
                  if (_formKey.currentState.validate()) {
                    dynamic result;
                    result = DatabaseService().addEscaperoomData(
                        nombre,
                        ciudad,
                        widget.empresa,
                        precio,
                        tiempo,
                        dificultad,
                        jugadoresMin,
                        jugadoresMax,
                        timestamp.toString(),
                        descripcion,
                        etiquetas);

                    if (result == null) {
                      setState(() {
                        error = 'Ha habido un error';
                        debugPrint(error);
                      });
                    } else {
                      final navigator = Navigator.of(context);
                      await showDialog(
                        context: context,
                        builder: (_) => HomeScreen(),
                      );
                      navigator.pop();
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
