import 'package:escape_life/components/text_field.dart';
import 'package:escape_life/db/entities/escaperoom.dart';
import 'package:escape_life/db/entities/usuario.dart';
import 'package:escape_life/db/firebase/database.dart';
import 'package:escape_life/components/round_button.dart';
import 'package:escape_life/components/rounded_input_field.dart';
import 'package:escape_life/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BodyReserva extends StatefulWidget {
  @override
  State<BodyReserva> createState() => _BodyState();
  const BodyReserva({
    this.escaperoom,
    this.user,
  });
  final Usuario user;
  final Escaperoom escaperoom;
}

class _BodyState extends State<BodyReserva> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();
  final TextEditingController fechaController = TextEditingController();
  final TextEditingController jugadoresController = TextEditingController();
  String nombre = '';
  String email = '';
  String phonenumber = '';
  String jugadores = '';
  String fecha = '';
  String error = '';
  bool open = false;

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
              Text(
                "\nReservar en '${widget.escaperoom.nombre}'\n",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              RoundedInputField(
                hintText: "Nombre y apellidos",
                validator: (value) =>
                    value.isEmpty ? 'Introduzca su nombre y apellidos' : null,
                onChanged: (value) {
                  setState(() => nombre = value);
                },
                icon: Icons.person,
              ),
              TextFieldContainer(
                child: TextFormField(
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Introduzca un email"),
                    EmailValidator(errorText: "Introduzca un email válido"),
                  ]),
                  controller: emailController,
                  onChanged: (value) {
                    setState(() => email = value);
                  },
                  style: GoogleFonts.ubuntu(color: Colors.white),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    hintText: "Introduzca su email",
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
              ),
              RoundedInputField(
                controller: phonenumberController,
                hintText: "Introduzca un numero de telefono",
                validator: (value) =>
                    value.isEmpty ? 'Introduzca un número de teléfono' : null,
                onChanged: (value) {
                  setState(() => phonenumber = value);
                },
                icon: Icons.phone,
              ),
              RoundedInputField(
                controller: jugadoresController,
                hintText: "Jugadores",
                validator: (value) => value.isEmpty
                    ? 'Introduzca el número de jugadores'
                    : (int.parse(value) >
                            int.parse(widget.escaperoom.jugadoresMax)
                        ? 'El número máximo de jugadores es ${widget.escaperoom.jugadoresMax}'
                        : int.parse(value) <
                                int.parse(widget.escaperoom.jugadoresMin)
                            ? 'El número mínimo de jugadores es ${widget.escaperoom.jugadoresMin}'
                            : null),
                onChanged: (value) {
                  setState(() => jugadores = value);
                },
                icon: Icons.people,
              ),
              TextFieldContainer(
                child: TextFormField(
                    readOnly: true,
                    validator: (value) =>
                        value.isEmpty ? 'Introduzca una fecha' : null,
                    controller: fechaController,
                    style: GoogleFonts.ubuntu(color: Colors.white),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.date_range,
                        color: Colors.white,
                      ),
                      hintText: "Introduzca una fecha",
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    ),
                    onTap: () async {
                      DateTime pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2100));

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('dd-MM-yyyy').format(pickedDate);
                        setState(() {
                          fechaController.text = formattedDate;
                          fecha = formattedDate;
                        });
                      }
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: open,
                    onChanged: (value) => {
                      setState(() => open = !open),
                    },
                  ),
                  Text(
                    'Permitir a la gente unirse',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              RoundedButton(
                text: "Enviar",
                press: () async {
                  if (_formKey.currentState.validate()) {
                    dynamic result;
                    result = DatabaseService().addReserve(
                      widget.user.id,
                      widget.escaperoom.id,
                      nombre,
                      phonenumber,
                      email,
                      fecha,
                      jugadores,
                      open,
                    );

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
