import 'dart:io';
import 'package:escape_life/components/profile_image.dart';
import 'package:escape_life/db/entities/usuario.dart';
import 'package:escape_life/db/firebase/database.dart';
import 'package:escape_life/db/firebase/storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class ProfileWidget extends StatefulWidget {
  @override
  State<ProfileWidget> createState() => _BodyState();
  const ProfileWidget({
    Key key,
    this.onClicked,
    this.user,
  }) : super(key: key);
  final Usuario user;
  final VoidCallback onClicked;
}

class _BodyState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    const color = kSecondaryColor;

    return Center(
      child: Stack(
        children: [
          SizedBox(
            height: 20,
          ),
          ProfileImage(
            imagePath: widget.user.urlImagen,
            radius: 50,
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildEditIcon(Color color) {
    final Storage storage = Storage();

    PlatformFile pickedFile;
    Future selectFile() async {
      final result = await FilePicker.platform.pickFiles();
      if (result == null) return;
      setState(() {
        pickedFile = result.files.first;
      });
    }

//a ver si carga bien la imagen tras cambiarla
    Future uploadFile() async {
      final file = File(pickedFile.path);
      int timestamp = DateTime.now().millisecondsSinceEpoch;
      final path = 'assets/$timestamp';
      final ref = storage.storage.ref().child(path);

      ref.putFile(file);
      DatabaseService()
          .updateProfileImage(timestamp.toString(), widget.user.uid);
    }

    return buildCircle(
      color: Colors.white,
      all: 1,
      child: buildCircle(
        color: color,
        all: 1,
        child: IconButton(
            splashRadius: 1,
            icon: Icon(
              Icons.edit,
              color: Colors.white,
              size: 15,
            ),
            onPressed: () async {
              await selectFile();
              await uploadFile();
            }),
      ),
    );
  }

  Widget buildCircle({
    Widget child,
    double all,
    Color color,
  }) =>
      ClipOval(
        child: Container(
          width: 40,
          height: 40,
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
