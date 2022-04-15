import 'package:flutter/material.dart';
import 'package:escape_life/screens/details/components/body.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen(
      {Key key, this.title, this.country, this.price, this.image})
      : super(key: key);

  final String title, country, image;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(
        price: price,
        country: country,
        title: title,
        image: image,
      ),
    );
  }
}
