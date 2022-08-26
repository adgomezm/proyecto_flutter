import 'package:escape_life/db/entities/usuario.dart';
import 'package:escape_life/prueba/onboarding_page.dart';
import 'package:escape_life/screens/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:escape_life/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'db/firebase/user_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Usuario>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Escape Life',
        theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          primaryColor: kPrimaryColor,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(
          useLoader: false,
          seconds: 3,
          image: Image.asset(
            "assets/images/lockt.png",
            width: 600,
            height: 600,
          ),
          title: Text('Escape Life',
              style: GoogleFonts.specialElite(
                fontSize: 40,
                color: Colors.white,
              ),
              textAlign: TextAlign.center),
          backgroundColor: kBackgroundColor,
          photoSize: 100,
          navigateAfterSeconds: AuthenticationWrapper(),
        ),
      ),
    );
  }
  /* void getUserData() async{
    var firebaseUser = AuthService.user;
    FirebaseFirestore.instance.collection("users").docs(firebaseUser.uid).get().then((value){
      print(value.data);
    });
  }*/
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Usuario>(context);
    // return either the Home or Authenticate widget
    if (user == null) {
      return OnBoardingPage();
    } else {
      return HomeScreen();
    }
  }
}
