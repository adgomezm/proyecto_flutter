import 'package:escape_life/db/entities/escaperoom.dart';
import 'package:escape_life/db/firebase/database.dart';
import 'package:flutter/material.dart';
import 'package:escape_life/screens/details/details_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import 'package:escape_life/db/firebase/storage.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Escaperoom>>.value(
      initialData: null,
      value: DatabaseService().escaperooms,
      child: SingleChildScrollView(
        child: Row(
          children: <Widget>[
            /*Recoger nombre y datos de cada ER de la DB*/
            RecomendERCard(),
          ],
        ),
      ),
    );
  }
}

class RecomendERCard extends StatefulWidget {
  @override
  _RecomendERCardState createState() => _RecomendERCardState();
}

class _RecomendERCardState extends State<RecomendERCard> {
  @override
  Widget build(BuildContext context) {
    final escaperooms = Provider.of<List<Escaperoom>>(context);
    Size size = MediaQuery.of(context).size;

    if (escaperooms == null) {
      return SizedBox(
        height: 400.0,
        child: Text(
          'No escaperooms yet!',
          style: GoogleFonts.specialElite(
            fontSize: 20,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      );
    } else {
      return SizedBox(
        height: size.height,
        width: size.width,
        child: buildContent(escaperooms),
      );
    }
  }

  Widget buildContent(List<Escaperoom> escaperooms) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: escaperooms.length,
      itemBuilder: (BuildContext context, int index) {
        final escaperoom = escaperooms[index];

        return buildEscapeRoom(context, escaperoom);
      },
    );
  }

  Widget buildEscapeRoom(
    BuildContext context,
    Escaperoom escaperoom,
  ) {
    final Storage storage = Storage();

    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        FutureBuilder(
          future: storage.downloadURL(escaperoom.imagen),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return Container(
                margin: EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  top: kDefaultPadding / 2,
                ),
                width: 300,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          title: escaperoom.nombre,
                          country: escaperoom.ciudad,
                          price: escaperoom.precio,
                          image: escaperoom.imagen,
                        ),
                      ),
                    );
                  },
                  child: Image.network(
                    snapshot.data,
                    width: 300,
                    height: size.height * 0.25,
                    fit: BoxFit.fill,
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
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(
                  title: escaperoom.nombre,
                  country: escaperoom.ciudad,
                  price: escaperoom.precio,
                  image: escaperoom.imagen,
                ),
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(kDefaultPadding / 2),
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 50,
                  color: kPrimaryColor.withOpacity(0.23),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: escaperoom.nombre.toUpperCase(),
                          style: Theme.of(context).textTheme.button),
                      TextSpan(
                        text: "\n".toUpperCase(),
                      ),
                      TextSpan(
                        text: escaperoom.ciudad.toUpperCase(),
                        style: TextStyle(
                          color: kSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
