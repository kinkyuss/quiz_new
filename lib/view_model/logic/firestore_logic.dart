import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreLogic {
  final _instance = FirebaseFirestore.instance;

  readStream(String collection, String doc, ) {
    var reference = _instance.collection(collection).doc(doc);
    final stream = reference
        .snapshots();

    return stream;
  }

  write(String collection, String doc, String field, var content) async {
    await _instance.collection(collection).doc(doc).set({field: content},SetOptions(merge : true));
  }
}
