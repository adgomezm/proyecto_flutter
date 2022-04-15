import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(
        top: size.height * 0.05,
        bottom: size.height * 0.03,
      ),
      width: size.width * 0.8,
      child: Row(
        children: <Widget>[
          buildDivider(),
        ],
      ),
    );
  }

  Expanded buildDivider() {
    return Expanded(
      child: Divider(
        color: Colors.white,
        height: 1.5,
      ),
    );
  }
}
