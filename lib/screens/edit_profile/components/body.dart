import 'package:escape_life/components/button_widget.dart';
import 'package:escape_life/db/entities/usuario.dart';
import 'package:escape_life/screens/edit_profile/components/profile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Usuario>(context);

    return Column(
      children: [
        ProfileWidget(
          // imagePath: user.url_imagen,
          onClicked: () async {},
        ),
        const SizedBox(height: 24),
        buildName(user),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget buildName(Usuario user) => Column(
        children: [
          Text(
            user.nombre,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );
}
