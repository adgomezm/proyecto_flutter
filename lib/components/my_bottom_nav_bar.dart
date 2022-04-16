import 'package:escape_life/screens/edit_profile/edit_profile.dart';
import 'package:escape_life/screens/home/home_screen.dart';
import 'package:escape_life/screens/profile/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class MyBottomNavBar extends StatefulWidget {
  @override
  _MyBottomNavBarState createState() => _MyBottomNavBarState();
}

@override
class _MyBottomNavBarState extends State<MyBottomNavBar> {
  bool pressedLock = false;
  bool pressedFav = false;
  bool pressedProfile = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: kDefaultPadding * 2,
        right: kDefaultPadding * 2,
      ),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -10),
            blurRadius: 35,
            color: kPrimaryColor.withOpacity(0.38),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
              icon: pressedLock
                  ? Icon(Icons.lock_outline, color: kSecondaryColor)
                  : Icon(Icons.lock, color: kSecondaryColor),
              onPressed: () {
                setState(() => pressedLock = !pressedLock);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              }),
          IconButton(
              icon: pressedFav
                  ? Icon(Icons.star, color: kSecondaryColor)
                  : Icon(Icons.star_border, color: kSecondaryColor),
              onPressed: () {
                if (pressedFav == true) {
                } else {
                  setState(() => pressedFav = !pressedFav);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ),
                  );
                }
              }),
          IconButton(
              icon: pressedProfile
                  ? Icon(Icons.person, color: kSecondaryColor)
                  : Icon(Icons.person_outline, color: kSecondaryColor),
              onPressed: () {
                setState(() => pressedProfile = !pressedProfile);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfile(),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
