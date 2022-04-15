import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:escape_life/db/firebase/storage.dart';

import '../../../constants.dart';
import 'icon_card.dart';

class ImageAndIcons extends StatefulWidget {
  const ImageAndIcons({
    Key key,
    this.size,
    this.image,
  }) : super(key: key);
  final Size size;
  final String image;
  @override
  _ImageAndIconsState createState() => _ImageAndIconsState();
}

class _ImageAndIconsState extends State<ImageAndIcons> {
  @override
  void initState() {
    super.initState();
    // Get reference to an already opened box
  }

  final Storage storage = Storage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding * 0.9),
      child: SizedBox(
        height: widget.size.height * 0.85,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: kDefaultPadding * 1.3),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Spacer(),
                    IconCard(icon: Icons.timer),
                    Text(
                      "60-90 min",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    IconCard(icon: Icons.graphic_eq),
                    Text(
                      "Nivel medio",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    IconCard(icon: Icons.people),
                    Text(
                      "2-6 jugadores",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    IconCard(icon: Icons.location_on),
                    Text(
                      "Ubicación",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder(
              future: storage.downloadURL(widget.image),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Container(
                    height: widget.size.height * 0.8,
                    width: widget.size.width * 0.75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(63),
                        bottomLeft: Radius.circular(63),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 60,
                          color: kPrimaryColor.withOpacity(0.29),
                        ),
                      ],
                      image: DecorationImage(
                        alignment: Alignment.center,
                        fit: BoxFit.fitHeight,
                        image: NetworkImage(snapshot.data),
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
            ),
          ],
        ),
      ),
    );
  }
}
