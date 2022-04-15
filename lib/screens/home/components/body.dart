import 'package:escape_life/screens/grid_escaperooms/grid_escaperooms.dart';
import 'package:flutter/material.dart';
import 'package:escape_life/constants.dart';
import 'featurred_escaperooms.dart';
import 'header_with_seachbox.dart';
import 'recomend_escaperooms.dart';
import 'title_with_more_bbtn.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        HeaderWithSearchBox(size: size),
        Expanded(
          child: SingleChildScrollView(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                TitleWithMoreBtn(
                  title: "Las más votadas",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GridEscaperooms(),
                      ),
                    );
                  },
                ),
                RecomendsEscaperooms(),
                TitleWithMoreBtn(
                  title: "Cerca de ti",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GridEscaperooms(),
                      ),
                    );
                  },
                ),
                FeaturedEscaperooms(),
                SizedBox(height: kDefaultPadding),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
