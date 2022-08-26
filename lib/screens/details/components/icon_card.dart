import 'package:flutter/material.dart';

import '../../../constants.dart';

class IconCard extends StatelessWidget {
  const IconCard({
    Key key,
    this.icon,
    this.onPressed,
  }) : super(key: key);
  final Function() onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.03),
      padding: EdgeInsets.all(kDefaultPadding / 4),
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 15),
            blurRadius: 22,
            color: kPrimaryColor.withOpacity(0.22),
          ),
          BoxShadow(
            offset: Offset(-15, -15),
            blurRadius: 20,
            color: kSecondaryColor,
          ),
        ],
      ),
      child: IconButton(
        splashRadius: 1,
        icon: Icon(icon, color: kSecondaryColor),
        color: kSecondaryColor,
        onPressed: onPressed,
      ),
    );
  }
}
