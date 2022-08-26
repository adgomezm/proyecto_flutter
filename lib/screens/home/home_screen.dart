import 'package:escape_life/components/app_bar.dart';
import 'package:escape_life/components/navigation_drawer_widget.dart';
import 'package:escape_life/db/entities/escaperoom.dart';
import 'package:escape_life/db/entities/reserve.dart';
import 'package:escape_life/db/entities/usuario.dart';
import 'package:escape_life/screens/profile/profile.dart';
import 'package:escape_life/screens/public_profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:escape_life/screens/home/components/body.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import 'package:escape_life/db/firebase/database.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPage = 0;
  final List<Widget> pageList = [];

  @override
  void initState() {
    pageList.add(Body());
    //pagina de favoritos
    pageList.add(PublicProfileScreen(
      escaperooms: const [],
    ));
    pageList.add(Profile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<Escaperoom>>.value(
          initialData: null,
          value: DatabaseService().escaperooms,
        ),
        StreamProvider<List<Usuario>>.value(
          initialData: null,
          value: DatabaseService().usuarios,
        ),
        StreamProvider<List<Reserve>>.value(
          initialData: null,
          value: DatabaseService().reserves,
        ),
      ],
      child: Scaffold(
        appBar: AppBarComponent().buildAppBar(),
        drawer: NavigationDrawerWidget(),
        body: IndexedStack(
          index: _selectedPage,
          children: pageList,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.lock, color: kSecondaryColor),
              icon: Icon(Icons.lock_outline, color: kSecondaryColor),
              label: "Inicio",
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.star, color: kSecondaryColor),
              icon: Icon(Icons.star_outline, color: kSecondaryColor),
              label: "Favoritos",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, color: kSecondaryColor),
              activeIcon: Icon(Icons.person, color: kSecondaryColor),
              label: "Perfil",
            ),
          ],
          currentIndex: _selectedPage,
          onTap: (int index) {
            setState(() {
              _selectedPage = index;
            });
          },
        ),
      ),
    );
  }
}
