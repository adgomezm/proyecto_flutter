import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:escape_life/db/entities/usuario.dart';
import 'package:escape_life/db/entities/escaperoom.dart';

class DatabaseService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference erCollection =
      FirebaseFirestore.instance.collection('escaperooms');
  Future<void> addUserData(String id, String nombre, String email) {
    return userCollection
        .add({
          'id': id,
          'nombre': nombre,
          'email': email,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  List<Usuario> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Usuario(
        nombre: doc.get('nombre') ?? '',
        email: doc.get('email') ?? '',
        id: doc.get('id') ?? 0,
      );
    }).toList();
  }

  Usuario _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return Usuario(
      nombre: snapshot.get('nombre') ?? '',
      email: snapshot.get('email') ?? '',
      id: snapshot.get('id') ?? '',
    );
  }

  Stream<List<Usuario>> get usuarios {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }

  Future getUser(String uid) async {
    return await userCollection.doc(uid).snapshots().map((doc) {
      _userDataFromSnapshot(doc);
    });
  }

  Future<void> addEscaperoomData(
      String nombre, String ciudad, String empresa, int precio, String imagen) {
    return erCollection
        .add({
          'nombre': nombre,
          'ciudad': ciudad,
          'empresa': empresa,
          'precio': precio,
          'imagen': imagen
        })
        .then((value) => print("Escaperoom Added"))
        .catchError((error) => print("Failed to add escaperoom: $error"));
  }

  List<Escaperoom> _escaperoomListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Escaperoom(
        nombre: doc.get('nombre') ?? '',
        ciudad: doc.get('ciudad') ?? '',
        empresa: doc.get('empresa') ?? '',
        precio: doc.get('precio') ?? 0,
        imagen: doc.get('imagen') ?? '',
      );
    }).toList();
  }

  Stream<List<Escaperoom>> get escaperooms {
    return erCollection.snapshots().map(_escaperoomListFromSnapshot);
  }
}
