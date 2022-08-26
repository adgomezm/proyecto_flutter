import 'package:escape_life/components/profile_image.dart';
import 'package:escape_life/db/entities/usuario.dart';
import 'package:escape_life/db/firebase/database.dart';
import 'package:escape_life/screens/public_profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import 'package:escape_life/db/firebase/storage.dart';

import '../../../db/entities/escaperoom.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
  const Body({
    this.escaperooms,
  });
  final List<Escaperoom> escaperooms;
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Usuario>>.value(
      initialData: null,
      value: DatabaseService().usuarios,
      child: SingleChildScrollView(
        child: Row(
          children: <Widget>[
            /*Recoger nombre y datos de cada ER de la DB*/
            UsersList(escaperooms: widget.escaperooms),
          ],
        ),
      ),
    );
  }
}

class UsersList extends StatefulWidget {
  @override
  State<UsersList> createState() => _UsersListState();
  const UsersList({
    this.escaperooms,
  });
  final List<Escaperoom> escaperooms;
}

class _UsersListState extends State<UsersList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<Usuario>>(context) ?? [];
    final usuarios = users.where((user) => user.isAdmin == false).toList();
    Size size = MediaQuery.of(context).size;

    if (usuarios == null || usuarios.isEmpty) {
      return Expanded(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Text(
              'No hay usuarios',
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
        child: buildContent(usuarios),
      );
    }
  }

  Widget buildContent(List<Usuario> usuarios) {
    return Container(
      padding: EdgeInsets.only(
        right: kDefaultPadding / 2,
        left: kDefaultPadding / 2,
        top: kDefaultPadding / 2,
      ),
      child: ListView.builder(
        itemCount: usuarios.length,
        itemBuilder: (context, index) {
          return buildUsuario(
              context, usuarios[index], widget.escaperooms, index + 1);
        },
      ),
    );
  }

  Widget buildUsuario(BuildContext context, Usuario usuario,
      List<Escaperoom> escaperooms, int index) {
    final Storage storage = Storage();
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: size.height * 0.15,
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(bottom: kDefaultPadding / 3),
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
            child: FutureBuilder(
              future: storage.downloadURL(usuario.urlImagen),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  return Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PublicProfileScreen(
                                appbar: 0,
                                usuario: usuario,
                                escaperooms: widget.escaperooms,
                              ),
                            ),
                          );
                        },
                        child: ProfileImage(
                          imagePath: usuario.urlImagen,
                          radius: 40,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PublicProfileScreen(
                                appbar: 0,
                                usuario: usuario,
                                escaperooms: widget.escaperooms,
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
                                  text: usuario.nombre.toUpperCase(),
                                  style: Theme.of(context).textTheme.button),
                              TextSpan(
                                text: "\n".toUpperCase(),
                              ),
                              TextSpan(
                                text: usuario.email.toUpperCase(),
                                style: GoogleFonts.ubuntu(
                                  color: kSecondaryColor,
                                ),
                              ),
                              TextSpan(
                                text: "\n".toUpperCase(),
                              ),
                              TextSpan(
                                text: "Nº $index en el ranking",
                                style: GoogleFonts.ubuntu(
                                  color: kTerciaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting &&
                    !snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}
