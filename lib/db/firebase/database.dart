// ignore_for_file: avoid_print, await_only_futures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escape_life/db/entities/reserve.dart';
import 'package:escape_life/db/entities/usuario.dart';
import 'package:escape_life/db/entities/escaperoom.dart';

class DatabaseService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference erCollection =
      FirebaseFirestore.instance.collection('escaperooms');
  final CollectionReference reserveCollection =
      FirebaseFirestore.instance.collection('reserves');

  Future<void> addUserData(String id, String nombre, String email,
      {List<String> opcionesSeleccionadas, bool isAdmin, String empresa}) {
    return userCollection
        .add({
          'id': id,
          'nombre': nombre,
          'email': email,
          'urlImagen': 'imagenDefault.png',
          'isAdmin': isAdmin,
          'empresa': empresa,
          'opcionesSeleccionadas': opcionesSeleccionadas,
          'favoritas': [],
          'completadas': [],
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Stream<List<Usuario>> get usuarios {
    return userCollection.snapshots().map(
        (list) => list.docs.map((doc) => Usuario.fromFirestore(doc)).toList());
  }

  Future<void> addReserve(
    String userId,
    String erId,
    String nombre,
    String phonenumber,
    String email,
    String fecha,
    String jugadores,
    bool open,
  ) {
    return reserveCollection
        .add({
          'userId': userId,
          'erId': erId,
          'nombre': nombre,
          'phonenumber': phonenumber,
          'email': email,
          'jugadores': jugadores,
          'fecha': fecha,
          'open': open,
        })
        .then((value) => print("Reserve done"))
        .catchError((error) => print("Failed to add escaperoom: $error"));
  }

  List<Reserve> _reserveListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Reserve(
        id: doc.id,
        userId: doc.get('userId') ?? '',
        erId: doc.get('erId') ?? '',
        nombre: doc.get('nombre') ?? '',
        email: doc.get('email') ?? '',
        phonenumber: doc.get('phonenumber') ?? '',
        fecha: doc.get('fecha') ?? '',
        jugadores: doc.get('jugadores') ?? '',
        open: doc.get('open') ?? false,
      );
    }).toList();
  }

  Stream<List<Reserve>> get reserves {
    return reserveCollection.snapshots().map(_reserveListFromSnapshot);
  }

  Future<void> addEscaperoomData(
      String nombre,
      String ciudad,
      String empresa,
      String precio,
      String tiempo,
      String dificultad,
      String jugadoresMin,
      String jugadoresMax,
      String imagen,
      String descripcion,
      List<String> etiquetas) {
    return erCollection
        .add({
          'nombre': nombre,
          'ciudad': ciudad,
          'empresa': empresa,
          'precio': precio,
          'tiempo': tiempo,
          'dificultad': dificultad,
          'jugadoresMin': jugadoresMin,
          'jugadoresMax': jugadoresMax,
          'imagen': imagen,
          'descripcion': descripcion,
          'etiquetas': etiquetas,
        })
        .then((value) => print("Escaperoom Added"))
        .catchError((error) => print("Failed to add escaperoom: $error"));
  }

  List<Escaperoom> _escaperoomListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Escaperoom(
        id: doc.id,
        nombre: doc.get('nombre') ?? '',
        ciudad: doc.get('ciudad') ?? '',
        empresa: doc.get('empresa') ?? '',
        precio: doc.get('precio') ?? '',
        imagen: doc.get('imagen') ?? '',
        dificultad: doc.get('dificultad') ?? '',
        jugadoresMin: doc.get('jugadoresMin') ?? '',
        jugadoresMax: doc.get('jugadoresMax') ?? '',
        tiempo: doc.get('tiempo') ?? '',
        descripcion: doc.get('descripcion') ?? '',
        etiquetas: doc.get('etiquetas').cast<String>() ?? [],
      );
    }).toList();
  }

  Stream<List<Escaperoom>> get escaperooms {
    return erCollection.snapshots().map(_escaperoomListFromSnapshot);
  }

  setSearchParam(String value, List<Escaperoom> escaperooms) {
    List<Escaperoom> escaperoomSearchList = [];
    if (value.isEmpty) {
      escaperoomSearchList = [];
    } else {
      escaperoomSearchList = escaperooms
          .where((e) =>
              e.ciudad.toLowerCase().contains(value.toLowerCase()) ||
              e.nombre.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }

    for (var key in escaperoomSearchList) {
      print("${key.ciudad} ${key.nombre} ${key.empresa}");
    }
    return escaperoomSearchList;
  }

//ver como guardar en db los favoritos completados etc
  addArrayData(String array, String data, String uid) async {
    userCollection.doc(uid).update({
      array: FieldValue.arrayUnion([data]),
    });
  }

  removeArrayData(String array, String data, String uid) async {
    userCollection.doc(uid).update({
      array: FieldValue.arrayRemove([data]),
    });
  }

  updateProfileImage(String data, String uid) async {
    userCollection.doc(uid).update({
      'urlImagen': data,
    });
  }

  changeUsername(String data, String uid) async {
    userCollection.doc(uid).update({
      'nombre': data,
    });
  }

  joinParty(String data, String uid) async {
    reserveCollection.doc(uid).update({
      'jugadores': data,
    });
  }
}
