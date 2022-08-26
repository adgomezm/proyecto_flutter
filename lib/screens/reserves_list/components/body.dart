import 'package:escape_life/db/entities/escaperoom.dart';
import 'package:escape_life/db/entities/usuario.dart';
import 'package:escape_life/db/firebase/database.dart';
import 'package:escape_life/screens/reserves_list/components/reserve_info.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

import 'package:escape_life/db/entities/reserve.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
  const Body({
    this.user,
    this.escaperooms,
  });
  final Usuario user;
  final List<Escaperoom> escaperooms;
}

class _BodyState extends State<Body> {
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
              escaperooms: widget.escaperooms,
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
    this.escaperooms,
  });
  final Usuario user;
  final List<Escaperoom> escaperooms;
}

class _ReserveListState extends State<ReserveList> {
  @override
  Widget build(BuildContext context) {
    final reservesDB = Provider.of<List<Reserve>>(context) ?? [];
    Size size = MediaQuery.of(context).size;
    final escaperoomsAdmin = widget.escaperooms
        .where((element) => element.empresa == widget.user.empresa)
        .toList();
    List<Escaperoom> escaperooms =
        widget.user.isAdmin ? escaperoomsAdmin : widget.escaperooms;
    List<Reserve> reserves = [];
    if (widget.user.isAdmin) {
      for (var element in escaperooms) {
        for (var reserve in reservesDB) {
          if (reserve.erId == element.id) {
            reserves.add(reserve);
          }
        }
      }
    } else {
      for (var reserve in reservesDB) {
        if (reserve.userId == widget.user.id) {
          reserves.add(reserve);
        }
      }
    }
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
    Escaperoom escaperoom =
        widget.escaperooms.singleWhere((element) => element.id == reserve.erId);
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
                          escaperoom: escaperoom,
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
                                "${reserve.nombre.toUpperCase()} (${reserve.email})",
                            style: Theme.of(context).textTheme.button),
                        TextSpan(
                          text: "\n".toUpperCase(),
                        ),
                        TextSpan(
                          text: reserve.id.toUpperCase(),
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
