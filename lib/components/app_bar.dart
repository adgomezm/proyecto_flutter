import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';

class AppBarComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buildAppBar();
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: kPrimaryColor,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Escape Life',
            style: GoogleFonts.specialElite(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          Image.asset(
            "assets/images/lockt.png",
            width: 40,
            height: 40,
          ),
        ],
      ),
    );
  }
}
