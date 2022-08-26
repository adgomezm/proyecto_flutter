import 'package:escape_life/db/entities/escaperoom.dart';
import 'package:escape_life/db/entities/usuario.dart';
import 'package:escape_life/db/firebase/database.dart';
import 'package:flutter/material.dart';
import 'package:escape_life/screens/details/details_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import 'package:escape_life/db/firebase/storage.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
  const Body({
    this.escaperoomSearch,
    this.escaperooms,
    this.user,
    this.filtro,
    this.preferencias,
  });
  final bool preferencias;
  final String filtro;
  final Usuario user;
  final List<Escaperoom> escaperooms;
  final List<Escaperoom> escaperoomSearch;
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Escaperoom> escaperooms = widget.escaperoomSearch.isEmpty
        ? widget.escaperooms
        : widget.escaperoomSearch;

    List<Escaperoom> escaperoomPR = [];
    for (var element in widget.user.opcionesSeleccionadas) {
      for (var escaperoom in escaperooms) {
        if ((escaperoom.etiquetas.contains(element) ||
                element == escaperoom.dificultad) &&
            !escaperoomPR.contains(escaperoom)) {
          escaperoomPR.add(escaperoom);
        }
      }
    }
    List<Escaperoom> escaperoomF =
        widget.preferencias ? escaperoomPR : escaperooms;

    return Provider<List<Escaperoom>>.value(
      value: escaperoomF,
      child: SingleChildScrollView(
        child: Row(
          children: <Widget>[
            /*Recoger nombre y datos de cada ER de la DB*/
            RecomendERCard(user: widget.user, filtro: widget.filtro),
          ],
        ),
      ),
    );
  }
}

class RecomendERCard extends StatefulWidget {
  @override
  State<RecomendERCard> createState() => _RecomendERCardState();
  const RecomendERCard({
    this.user,
    this.filtro,
  });
  final String filtro;
  final Usuario user;
}

class _RecomendERCardState extends State<RecomendERCard> {
  @override
  Widget build(BuildContext context) {
    final escaperoomsDB = Provider.of<List<Escaperoom>>(context);
    List<Escaperoom> escaperooms;
    bool existe;
    switch (widget.filtro) {
      case "completadas":
        for (var element in widget.user.completadas) {
          for (var escaperoom in escaperoomsDB) {
            if (escaperoom.id == element) {
              existe = true;
              break;
            }
          }
          !existe
              ? DatabaseService()
                  .removeArrayData("completadas", element, widget.user.uid)
              : null;
          existe = false;
        }
        escaperooms = escaperoomsDB
            .where((element) => widget.user.completadas.contains(element.id))
            .toList();

        break;
      case "favoritas":
        for (var element in widget.user.favoritas) {
          existe = false;
          for (var escaperoom in escaperoomsDB) {
            if (escaperoom.id == element) {
              existe = true;
              break;
            }
          }
          !existe
              ? DatabaseService()
                  .removeArrayData("favoritas", element, widget.user.uid)
              : null;
        }
        escaperooms = escaperoomsDB
            .where((element) => widget.user.favoritas.contains(element.id))
            .toList();
        break;
      default:
        escaperooms = escaperoomsDB;
    }

    Size size = MediaQuery.of(context).size;

    if (escaperooms == null || escaperooms.isEmpty) {
      return Expanded(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Text(
              'No hay escaperooms',
              style: GoogleFonts.specialElite(
                fontSize: 20,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
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
    return Container(
      padding: EdgeInsets.only(
        right: kDefaultPadding / 2,
        left: kDefaultPadding / 2,
        top: kDefaultPadding / 2,
      ),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        shrinkWrap: true,
        children: escaperooms
            .map(
              (escaperoom) => buildEscapeRoom(context, escaperoom),
            )
            .toList(),
      ),
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
        Flexible(
          child: FutureBuilder(
            future: storage.downloadURL(escaperoom.imagen),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return SizedBox(
                  width: 300,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            escaperoom: escaperoom,
                            user: widget.user,
                          ),
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
                        width: 200,
                        height: size.height * 0.2,
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
                  user: widget.user,
                ),
              ),
            );
          },
          child: Container(
            clipBehavior: Clip.hardEdge,
            padding: EdgeInsets.all(kDefaultPadding / 2),
            width: 200,
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
    );
  }
}
