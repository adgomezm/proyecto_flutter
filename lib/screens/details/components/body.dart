import 'package:flutter/material.dart';
import 'package:escape_life/constants.dart';

import 'image_and_icons.dart';
import 'title_and_price.dart';

class Body extends StatefulWidget {
  const Body({Key key, this.title, this.country, this.price, this.image})
      : super(key: key);

  final String title, country, image;
  final int price;
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ImageAndIcons(
            size: size,
            image: widget.image,
          ),
          TitleAndPrice(
              title: widget.title,
              country: widget.country,
              price: widget.price),
          Row(
            children: <Widget>[
              SizedBox(
                width: size.width / 2,
                height: 84,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                      ),
                    ),
                    primary: Colors.white,
                  ),
                  onPressed: () {},
                  child: Text(
                    "Reservar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: size.width / 2,
                height: 84,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    primary: Colors.white,
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {},
                  child: Text(
                    "Descripción",
                    style: TextStyle(
                      color: kSecondaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
