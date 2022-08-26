import 'package:escape_life/components/profile_image.dart';
import 'package:escape_life/db/entities/escaperoom.dart';
import 'package:escape_life/db/entities/usuario.dart';
import 'package:escape_life/db/firebase/storage.dart';
import 'package:escape_life/screens/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:escape_life/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  const Body({
    this.escaperooms,
    this.usuario,
  });
  final Usuario usuario;
  final List<Escaperoom> escaperooms;

  @override
  Widget build(BuildContext context) {
    final usuarios = this.escaperooms.isEmpty
        ? Provider.of<List<Usuario>>(context) ?? []
        : [];
    final usuario = Provider.of<Usuario>(context);
    final Usuario user = this.usuario ??
        usuarios.singleWhere((i) => i.id == usuario.id, orElse: () => null);

    Size size = MediaQuery.of(context).size;
    final escaperoomsDB = this.escaperooms.isEmpty
        ? Provider.of<List<Escaperoom>>(context)
        : this.escaperooms;

    final List<Escaperoom> escaperooms = escaperoomsDB
        .where((element) => user.favoritas.contains(element.id))
        .toList();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: size.height,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: constraints.maxHeight * 0.9,
                          width: constraints.maxWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(29),
                              topLeft: Radius.circular(29),
                            ),
                            color: Colors.white,
                          ),
                          child: Container(
                            width: constraints.maxWidth * 0.9,
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 40,
                                ),
                                Text(
                                  user.nombre ?? "",
                                  style: GoogleFonts.roboto(
                                    fontSize: 20,
                                    color: kSecondaryColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          "Completados",
                                          style: GoogleFonts.roboto(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          user.completadas.length.toString(),
                                          style: GoogleFonts.roboto(
                                            fontSize: 15,
                                            color: kSecondaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Container(
                                        height: 30,
                                        width: 5,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: kSecondaryColor),
                                      ),
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          "Favoritos",
                                          style: GoogleFonts.roboto(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          user.favoritas.length.toString(),
                                          style: GoogleFonts.roboto(
                                            fontSize: 15,
                                            color: kSecondaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Container(
                                        height: 30,
                                        width: 5,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: kSecondaryColor),
                                      ),
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Text(
                                          "Rango",
                                          style: GoogleFonts.roboto(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          "1",
                                          style: GoogleFonts.roboto(
                                            fontSize: 15,
                                            color: kSecondaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        "Salas favoritas",
                                        style: GoogleFonts.roboto(
                                          fontSize: 20,
                                          color: kSecondaryColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Flexible(
                                        child: Column(
                                          children: escaperooms.isEmpty
                                              ? [
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 100,
                                                        ),
                                                        Text(
                                                          'Sin favoritos',
                                                          style: GoogleFonts
                                                              .specialElite(
                                                            fontSize: 20,
                                                            color: Colors.black,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ]
                                              : escaperooms
                                                  .map(
                                                    (escaperoom) =>
                                                        buildEscapeRoom(context,
                                                            escaperoom, user),
                                                  )
                                                  .toList(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: SizedBox(
                              width: constraints.maxWidth * 0.3,
                              child: ProfileImage(
                                imagePath: user.urlImagen,
                                radius: 50,
                              )),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEscapeRoom(
    BuildContext context,
    Escaperoom escaperoom,
    Usuario user,
  ) {
    final Storage storage = Storage();

    return Expanded(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Flexible(
            child: FutureBuilder(
              future: storage.downloadURL(escaperoom.imagen),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return SizedBox(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                                escaperoom: escaperoom, user: user),
                          ),
                        );
                      },
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Image.network(
                          snapshot.data,
                          width: 300,
                          fit: BoxFit.fill,
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
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    escaperoom: escaperoom,
                    user: user,
                  ),
                ),
              );
            },
            child: Container(
              clipBehavior: Clip.hardEdge,
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
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: escaperoom.nombre.toUpperCase(),
                              style: Theme.of(context).textTheme.button),
                          TextSpan(
                            text: "\n".toUpperCase(),
                          ),
                          TextSpan(
                            text: escaperoom.ciudad.toUpperCase(),
                            style: GoogleFonts.ubuntu(
                              color: kSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
