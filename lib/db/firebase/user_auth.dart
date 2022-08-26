import 'package:escape_life/db/entities/usuario.dart';
import 'package:escape_life/db/firebase/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  Usuario _userFromFirebaseUser(User user) {
    return user != null
        ? Usuario(
            id: user.uid,
            email: user.email,
            nombre: user.displayName,
            urlImagen: 'imagenDefault.png',
          )
        : null;
  }

  // auth change user stream
  Stream<Usuario> get user {
    return _auth
        .authStateChanges()
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      return user;
    } catch (error) {
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(
      String nombre, String email, String password,
      {List<String> opcionesSeleccionadas,
      bool isAdmin,
      String empresa}) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      if (isAdmin == null) {
        await DatabaseService().addUserData(user.uid, nombre, email,
            opcionesSeleccionadas: opcionesSeleccionadas,
            isAdmin: false,
            empresa: null);
      } else {
        await DatabaseService().addUserData(user.uid, nombre, email,
            isAdmin: isAdmin, empresa: empresa, opcionesSeleccionadas: []);
      }

      await updateUserName(nombre, user);
      return _userFromFirebaseUser(user);
    } catch (error) {
      return null;
    }
  }

  Future updateUserName(String name, User currentUser) async {
    await currentUser.updateDisplayName(name);
    await currentUser.reload();
  }

  Future<String> changePassword(String newPassword) async {
    User user = FirebaseAuth.instance.currentUser;

    Map<String, String> codeResponses = {
      // Re-auth responses
      "user-mismatch": null,
      "user-not-found": null,
      "invalid-credential": null,
      "invalid-email": null,
      "wrong-password": null,
      "invalid-verification-code": null,
      "invalid-verification-id": null,
      // Update password error codes
      "weak-password": null,
      "requires-recent-login": null
    };

    try {
      await user.updatePassword(newPassword);
      return null;
    } on FirebaseAuthException catch (error) {
      return codeResponses[error.code] ?? "Unknown";
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      return null;
    }
  }
}
