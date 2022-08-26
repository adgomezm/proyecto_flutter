import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Usuario {
  String id;
  String uid;
  String nombre;
  String email;
  String urlImagen;
  String empresa;
  List<String> opcionesSeleccionadas;
  List<String> favoritas;
  List<String> completadas;
  bool isAdmin;
  Usuario({
    @required this.id,
    @required this.nombre,
    @required this.email,
    this.urlImagen,
    this.opcionesSeleccionadas,
    this.favoritas,
    this.completadas,
    this.isAdmin,
    this.empresa,
    this.uid,
  });

  factory Usuario.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();

    return Usuario(
      uid: doc.id,
      nombre: data['nombre'] ?? '',
      email: data['email'] ?? '',
      id: data['id'] ?? 0,
      urlImagen: data['urlImagen'] ?? '',
      empresa: data['empresa'] ?? '',
      isAdmin: data['isAdmin'] ?? '',
      opcionesSeleccionadas: data['opcionesSeleccionadas'].cast<String>() ?? [],
      favoritas: data['favoritas'].cast<String>() ?? [],
      completadas: data['completadas'].cast<String>() ?? [],
    );
  }
}
