import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreLogic {
  final _instance = FirebaseFirestore.instance;

  readStream(String collection, String doc, ) {
    print('readStreamに入った');
    var reference = _instance.collection(collection).doc(doc);

    final stream = reference
        .snapshots();
        // .map((snapshot){ snapshot.data()![field] ?? exception;});

    return stream;
  }

  write(String collection, String doc, String field, var content) async {
    await _instance.collection(collection).doc(doc).set({field: content},SetOptions(merge : true));
  }
}
