import 'package:flutter/material.dart';
import 'package:escape_life/db/firebase/storage.dart';

import '../../../constants.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    this.imagePath,
    this.radius,
  });
  final String imagePath;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();

    return FutureBuilder(
      future: storage.downloadURL(imagePath),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return Container(
            margin: EdgeInsets.only(
              top: kDefaultPadding / 2,
            ),
            width: 100,
            child: CircleAvatar(
              radius: radius,
              backgroundColor: kBackgroundColor,
              child: ClipOval(
                child: Image.network(
                  snapshot.data,
                ),
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting &&
            !snapshot.hasData) {
          return CircularProgressIndicator();
        }
        return Container();
      },
    );
  }
}
