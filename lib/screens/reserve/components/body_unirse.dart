import 'package:escape_life/db/entities/escaperoom.dart';
import 'package:escape_life/db/entities/usuario.dart';
import 'package:escape_life/db/firebase/database.dart';
import 'package:escape_life/screens/reserve/components/reserve_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

import 'package:escape_life/db/entities/reserve.dart';

class BodyUnirse extends StatefulWidget {
  @override
  State<BodyUnirse> createState() => _BodyState();
  const BodyUnirse({
    this.user,
    this.escaperoom,
  });
  final Usuario user;
  final Escaperoom escaperoom;
}

class _BodyState extends State<BodyUnirse> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Reserve>>.value(
      initialData: null,
      value: DatabaseService().reserves,
      child: SingleChildScrollView(
        child: Row(
          children: <Widget>[
            /*Recoger nombre y datos de cada ER de la DB*/
            ReserveList(
              user: widget.user,
              escaperoom: widget.escaperoom,
            ),
          ],
        ),
      ),
    );
  }
}

class ReserveList extends StatefulWidget {
  @override
  State<ReserveList> createState() => _ReserveListState();
  const ReserveList({
    this.user,
    this.escaperoom,
  });
  final Usuario user;
  final Escaperoom escaperoom;
}

class _ReserveListState extends State<ReserveList> {
  @override
  Widget build(BuildContext context) {
    final reservesDB = Provider.of<List<Reserve>>(context) ?? [];
    Size size = MediaQuery.of(context).size;
    final reserves = reservesDB
        .where((element) => (element.erId == widget.escaperoom.id &&
            element.open &&
            int.parse(widget.escaperoom.jugadoresMax) >
                int.parse(element.jugadores)))
        .toList();

    if (reserves == null || reserves.isEmpty) {
      return Expanded(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Text(
              'No hay reservas',
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
        child: buildContent(reserves),
      );
    }
  }

  Widget buildContent(List<Reserve> reserves) {
    return Container(
      padding: EdgeInsets.only(
        right: kDefaultPadding / 2,
        left: kDefaultPadding / 2,
        top: kDefaultPadding / 2,
      ),
      child: ListView.builder(
        itemCount: reserves.length,
        itemBuilder: (context, index) {
          return buildReserve(context, reserves[index]);
        },
      ),
    );
  }

  Widget buildReserve(
    BuildContext context,
    Reserve reserve,
  ) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: size.height * 0.15,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(
                bottom: kDefaultPadding / 3, left: kDefaultPadding),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReserveInfo(
                          reserve: reserve,
                          escaperoom: widget.escaperoom,
                        ),
                      ),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.ubuntu(
                        fontSize: 20,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text:
                                "Líder del grupo: ${reserve.nombre.toUpperCase()}",
                            style: Theme.of(context).textTheme.button),
                        TextSpan(
                          text: "\n".toUpperCase(),
                        ),
                        TextSpan(
                          text:
                              "${reserve.fecha.toUpperCase()}\nHuecos libres: ${int.parse(widget.escaperoom.jugadoresMax) - int.parse(reserve.jugadores)}",
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
        ],
      ),
    );
  }
}
