import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key key,
    this.icon,
    this.text,
    this.onClicked,
  }) : super(key: key);
  final IconData icon;
  final String text;
  final VoidCallback onClicked;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
        top: kDefaultPadding / 2,
      ),
      width: size.width * 0.8,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(kSecondaryColor),
          padding: MaterialStateProperty.all(EdgeInsets.all(20)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: kSecondaryColor,
              ),
            ),
          ),
        ),
        onPressed: onClicked,
        child: buildContent(),
      ),
    );
  }

  Widget buildContent() {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          textDirection: TextDirection.ltr,
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.all(15),
        ),
        Text(
          text,
          style: GoogleFonts.ubuntu(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
