import 'package:escape_life/components/text_field.dart';
import 'package:escape_life/constants.dart';
import 'package:flutter/material.dart';

class RoundPassInput extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final Function validator;
  final String hintText;

  const RoundPassInput({
    Key key,
    this.onChanged,
    this.controller,
    this.validator,
    this.hintText,
  }) : super(key: key);

  @override
  State<RoundPassInput> createState() => _RoundPassInputState();
}

class _RoundPassInputState extends State<RoundPassInput> {
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  bool _passwordVisible;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        obscureText: !_passwordVisible,
        onChanged: widget.onChanged,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.white),
          icon: Icon(
            Icons.lock,
            color: Colors.white,
          ),
          suffixIcon: IconButton(
            splashRadius: 1,
            icon: Icon(
              // Based on passwordVisible state choose the icon
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: kSecondaryColor,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
