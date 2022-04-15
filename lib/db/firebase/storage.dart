import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Storage {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<String> downloadURL(String img) async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref('assets/$img.png')
        .getDownloadURL();
    return downloadURL;
  }
}
