import 'package:flutter/material.dart';
import 'package:escape_life/screens/login/components/body.dart';

import '../../components/app_bar.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent().buildAppBar(),
      body: Body(),
    );
  }
}
