import 'package:escape_life/db/entities/escaperoom.dart';
import 'package:escape_life/db/entities/usuario.dart';
import 'package:flutter/material.dart';
import 'package:escape_life/screens/details/details_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import 'package:escape_life/db/firebase/storage.dart';

class RecomendsEscaperooms extends StatefulWidget {
  @override
  State<RecomendsEscaperooms> createState() => _RecomendsEscaperoomsState();
  const RecomendsEscaperooms({
    Key key,
    this.user,
    this.preferencias,
  }) : super(key: key);

  final Usuario user;
  final bool preferencias;
}

class _RecomendsEscaperoomsState extends State<RecomendsEscaperooms> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          /*Recoger nombre y datos de cada ER de la DB*/
          RecomendERCard(
            user: widget.user,
            preferencias: widget.preferencias,
          ),
        ],
      ),
    );
  }
}

class RecomendERCard extends StatefulWidget {
  @override
  State<RecomendERCard> createState() => _RecomendERCardState();
  const RecomendERCard({
    Key key,
    this.user,
    this.preferencias,
  }) : super(key: key);

  final Usuario user;
  final bool preferencias;
}

class _RecomendERCardState extends State<RecomendERCard> {
  @override
  Widget build(BuildContext context) {
    final escaperoomsDB = Provider.of<List<Escaperoom>>(context);
    List<Escaperoom> escaperooms = widget.user.isAdmin
        ? escaperoomsDB.where((i) => i.empresa == widget.user.empresa).toList()
        : escaperoomsDB;

    if (escaperooms.isEmpty || escaperooms == null) {
      return Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            'No hay escaperooms',
            style: GoogleFonts.specialElite(
              fontSize: 20,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 50,
          ),
        ],
      );
    } else {
      return SizedBox(
        height: 300.0,
        child: buildContent(escaperooms),
      );
    }
  }

  Widget buildContent(List<Escaperoom> escaperooms) {
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

    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: escaperoomF.length,
      itemBuilder: (BuildContext context, int index) {
        final escaperoom = escaperoomF[index];

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
                      width: 300,
                      height: size.height * 0.25,
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
                        style: GoogleFonts.ubuntu(
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
