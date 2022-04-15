import 'package:escape_life/components/text_field.dart';
import 'package:flutter/material.dart';

class RoundPassInput extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final Function validator;

  const RoundPassInput({
    Key key,
    this.onChanged,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        validator: validator,
        controller: controller,
        obscureText: true,
        onChanged: onChanged,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "Contraseña",
          hintStyle: TextStyle(color: Colors.white),
          icon: Icon(
            Icons.lock,
            color: Colors.white,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: Colors.white,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
