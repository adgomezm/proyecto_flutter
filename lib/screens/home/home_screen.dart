import 'package:escape_life/components/navigation_drawer_widget.dart';
import 'package:escape_life/db/entities/escaperoom.dart';
import 'package:escape_life/screens/edit_profile/edit_profile.dart';
import 'package:escape_life/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:escape_life/screens/home/components/body.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import 'package:escape_life/db/firebase/database.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPage = 0;
  final List<Widget> pageList = [];

  @override
  void initState() {
    pageList.add(Body());
    //pagina de favoritos
    pageList.add(ProfileScreen());
    pageList.add(EditProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Escaperoom>>.value(
      initialData: null,
      value: DatabaseService().escaperooms,
      child: Scaffold(
        appBar: buildAppBar(),
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

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: kPrimaryColor,
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Escape Life',
            style: GoogleFonts.specialElite(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          Image.asset(
            "assets/images/lockt.png",
            width: 40,
            height: 40,
          ),
        ],
      ),
    );
  }
}
