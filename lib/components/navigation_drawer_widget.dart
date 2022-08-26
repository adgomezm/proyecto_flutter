import 'package:escape_life/components/profile_image.dart';
import 'package:escape_life/constants.dart';
import 'package:escape_life/db/entities/usuario.dart';
import 'package:escape_life/db/firebase/user_auth.dart';
import 'package:escape_life/screens/about/about.dart';
import 'package:escape_life/screens/grid_escaperooms/grid_escaperooms.dart';
import 'package:escape_life/screens/login/login_screen.dart';
import 'package:escape_life/screens/public_profile/profile_screen.dart';
import 'package:escape_life/screens/reserves_list/reserves_list.dart';
import 'package:escape_life/screens/users_ranking/users_ranking.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../db/entities/escaperoom.dart';

class NavigationDrawerWidget extends StatefulWidget {
  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final AuthService _auth = AuthService();

  final padding = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    final escaperooms = Provider.of<List<Escaperoom>>(context);
    final usuarios = Provider.of<List<Usuario>>(context) ?? [];
    final usuario = Provider.of<Usuario>(context);
    final Usuario user =
        usuarios.singleWhere((i) => i.id == usuario.id, orElse: () => null);

    return Drawer(
      child: Material(
        color: kPrimaryColor,
        child: ListView(
          children: <Widget>[
            buildHeader(user, onClicked: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PublicProfileScreen(
                    appbar: 0,
                    escaperooms: escaperooms,
                    usuario: user,
                  ),
                ),
              );
            }),
            Container(
              padding: padding,
              child: Column(
                children: [
                  !user.isAdmin ? const SizedBox(height: 12) : SizedBox(),
                  !user.isAdmin
                      ? buildMenuItem(
                          text: 'Ranking',
                          icon: Icons.people,
                          onClicked: () =>
                              selectedItem(context, 0, escaperooms, user),
                        )
                      : SizedBox(),
                  !user.isAdmin ? const SizedBox(height: 16) : SizedBox(),
                  !user.isAdmin
                      ? buildMenuItem(
                          text: 'Favoritos',
                          icon: Icons.favorite_border,
                          onClicked: () =>
                              selectedItem(context, 1, escaperooms, user),
                        )
                      : buildMenuItem(
                          text: 'Lista de reservas',
                          icon: Icons.list,
                          onClicked: () =>
                              selectedItem(context, 5, escaperooms, user),
                        ),
                  const SizedBox(height: 24),
                  !user.isAdmin
                      ? buildMenuItem(
                          text: 'Mis reservas',
                          icon: Icons.library_books_rounded,
                          onClicked: () =>
                              selectedItem(context, 2, escaperooms, user),
                        )
                      : SizedBox(),
                  Divider(color: Colors.white70),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Acerca de',
                    icon: Icons.info,
                    onClicked: () =>
                        selectedItem(context, 3, escaperooms, user),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Cerrar sesión',
                    icon: Icons.logout,
                    onClicked: () {
                      _auth.signOut();
                      selectedItem(context, 4, escaperooms, user);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(Usuario user, {VoidCallback onClicked}) {
    return InkWell(
      onTap: onClicked,
      child: Container(
        padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
        child: Row(
          children: [
            ProfileImage(
              imagePath: user.urlImagen,
              radius: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.nombre ?? "",
                  style: GoogleFonts.ubuntu(fontSize: 20, color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  user.email ?? "",
                  style: GoogleFonts.ubuntu(fontSize: 13, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    String text,
    IconData icon,
    VoidCallback onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: GoogleFonts.ubuntu(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index,
      List<Escaperoom> escaperooms, Usuario user) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => UsersRanking(
            escaperooms: escaperooms,
          ),
        ));
        break;
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => GridEscaperooms(
            appbar: 0,
            escaperoomSearch: const [],
            escaperooms: escaperooms,
            user: user,
            filtro: "favoritas",
            preferencias: false,
          ),
        ));
        break;
      case 2:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ReservesList(
            user: user,
            escaperooms: escaperooms,
          ),
        ));
        break;
      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => About(),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ReservesList(
            user: user,
            escaperooms: escaperooms,
          ),
        ));
        break;
    }
  }
}
