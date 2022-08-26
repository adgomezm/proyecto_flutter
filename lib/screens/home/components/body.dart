// ignore_for_file: unrelated_type_equality_checks

import 'package:escape_life/components/round_button.dart';
import 'package:escape_life/db/entities/escaperoom.dart';
import 'package:escape_life/db/entities/usuario.dart';
import 'package:escape_life/db/firebase/database.dart';
import 'package:escape_life/screens/add_escaperoom/add_escaperoom.dart';
import 'package:escape_life/screens/grid_escaperooms/grid_escaperooms.dart';
import 'package:flutter/material.dart';
import 'package:escape_life/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'recomend_escaperooms.dart';
import 'title_with_more_bbtn.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Escaperoom> escaperoomSearch;
  TextEditingController myController;
//TO DO: conseguir recoger los datos del usuario correctamente

  @override
  void initState() {
    escaperoomSearch = [];
    super.initState();
  }

  bool addEscaperoom = false;
  void callSetState() {
    setState(() {
      addEscaperoom = !addEscaperoom;
    }); // it can be called without parameters. It will redraw based on changes done in _SecondWidgetState
  }

  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    final dbService = DatabaseService();
    Usuario user;
    final escaperooms = Provider.of<List<Escaperoom>>(context);
    final usuarios = Provider.of<List<Usuario>>(context, listen: false) ?? [];
    final usuario = Provider.of<Usuario>(context, listen: false);
    setState(() {
      user =
          usuarios.singleWhere((i) => i.id == usuario.id, orElse: () => null);
    });
    // it enable scrolling on small device
    return user.isAdmin
        ? adminHomeScreen(user, size, addEscaperoom)
        : userHomeScreen(size, dbService, escaperooms, user);
  }

  Column adminHomeScreen(Usuario user, Size size, bool addEscaperoom) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          // It will cover 20% of our total height
          height: addEscaperoom ? size.height * 0.10 : size.height * 0.20,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  bottom: kDefaultPadding,
                ),
                height: size.height * 0.20,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(29),
                    bottomRight: Radius.circular(29),
                  ),
                ),
              ),
              Positioned(
                bottom: addEscaperoom ? 40 : 100,
                left: 20,
                width: size.width * 0.9,
                child: Text(
                  "Hola ${user.nombre}",
                  style: GoogleFonts.ubuntu(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              !addEscaperoom
                  ? Positioned(
                      bottom: 5,
                      left: 5,
                      right: 5,
                      child: RoundedButton(
                          text: "Añadir Escaperoom",
                          textColor: kSecondaryColor,
                          color: kPrimaryLightColor,
                          press: () {
                            callSetState();
                          }),
                    )
                  : SizedBox(),
            ],
          ),
        ),
        Expanded(
          child: addEscaperoom
              ? AddEscaperoom(empresa: user.empresa)
              : DefaultHomeScreen(
                  user: user,
                ),
        )
      ],
    );
  }

  Column userHomeScreen(Size size, DatabaseService dbService,
      List<Escaperoom> escaperooms, Usuario user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          // It will cover 20% of our total height
          height: size.height * 0.22,
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  bottom: kDefaultPadding,
                ),
                height: size.height * 0.25 - 27,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(36),
                    bottomRight: Radius.circular(36),
                  ),
                ),
              ),
              Positioned(
                bottom: 120,
                left: 20,
                width: size.width * 0.9,
                child: Text(
                  "Tu buscador de Escape Rooms en España",
                  style: GoogleFonts.ubuntu(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  height: 54,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              escaperoomSearch =
                                  dbService.setSearchParam(value, escaperooms);
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Search",
                            hintStyle: GoogleFonts.ubuntu(
                              color: kPrimaryColor.withOpacity(0.5),
                            ),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            // surffix isn't working properly  with SVG
                            // thats why we use row
                            // suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: escaperoomSearch.isEmpty
              ? DefaultHomeScreen(
                  user: user,
                )
              : GridEscaperooms(
                  escaperoomSearch: escaperoomSearch,
                  appbar: 1,
                  user: user,
                  preferencias: false,
                ),
        ),
      ],
    );
  }
}

class DefaultHomeScreen extends StatelessWidget {
  const DefaultHomeScreen({
    Key key,
    this.user,
  }) : super(key: key);

  final Usuario user;

  @override
  Widget build(BuildContext context) {
    final escaperooms = Provider.of<List<Escaperoom>>(context);

    return SizedBox(
      child: SingleChildScrollView(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            user.isAdmin
                ? Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding, vertical: kDefaultPadding),
                    child: TitleWithCustomUnderline(text: "Tus Escaperooms"),
                  )
                : TitleWithMoreBtn(
                    title: "Las mejor valoradas",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GridEscaperooms(
                            appbar: 0,
                            escaperoomSearch: const [],
                            escaperooms: escaperooms,
                            user: user,
                            preferencias: false,
                          ),
                        ),
                      );
                    },
                  ),
            RecomendsEscaperooms(
              user: user,
              preferencias: false,
            ),
            user.isAdmin
                ? SizedBox()
                : TitleWithMoreBtn(
                    title: "Según tus preferencias",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GridEscaperooms(
                            appbar: 0,
                            escaperoomSearch: const [],
                            escaperooms: escaperooms,
                            user: user,
                            preferencias: true,
                          ),
                        ),
                      );
                    },
                  ),
            user.isAdmin
                ? SizedBox()
                : RecomendsEscaperooms(
                    user: user,
                    preferencias: true,
                  ),
            SizedBox(height: kDefaultPadding),
          ],
        ),
      ),
    );
  }
}
