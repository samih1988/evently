import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUtils {
  static addEventToFireStore() {
    FirebaseFirestore.instance.collection("event");
  }
}
