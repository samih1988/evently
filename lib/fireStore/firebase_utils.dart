import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/model/my_user.dart';

import '../model/event.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventCollection() {
    return FirebaseFirestore.instance
        .collection(Event.collectionName)
        .withConverter<Event>(
          fromFirestore: (snapshot, options) =>
              Event.fromJson(snapshot.data()!),
          toFirestore: (event, options) => event.toJson(),
        );
  }

  static Future<void> addEventToFireStore(Event event) {
    CollectionReference<Event> collectionRef = getEventCollection();
    DocumentReference<Event> docRef = collectionRef.doc();
    event.id = docRef.id;
    return docRef.set(event);
  }

  static Stream<List<Event>> getFilteredEvents({required int selectedIndex}) {
    return FirebaseUtils.getEventCollection().where(
        "event_cat_index", isEqualTo: selectedIndex).orderBy(
        "event_date"
    ).snapshots().map((snapshots) {
      return snapshots.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  static Stream<List<Event>> getAllEvents() {
    return FirebaseUtils.getEventCollection().orderBy(
        "event_date"
    ).snapshots().map((snapshots) {
      return snapshots.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  static Future<void> updateIsFavourite(Event event) {
    return getEventCollection().doc(event.id).update({
      "is_favorite": !event.isFavorite
    });
  }

  static Stream<List<Event>> getAllIsFavourite() {
    return getEventCollection().
    where("is_favorite", isEqualTo: true)
        .orderBy("event_date")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  // static Stream<List<Event>> getSearchFavourite({required String eventName}){
  //   return getEventCollection().
  //   where("event_name",isEqualTo:eventName)
  //       .orderBy( "event_date")
  //       .snapshots()
  //       .map((snapshot){
  //     return snapshot.docs.map((doc){
  //       return doc.data();
  //     }).toList();
  //   });
  // }

  static Stream<List<Event>> getSearchFavourite({required String eventName}) {
    return getEventCollection()
        .orderBy("event_date")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map(
              (doc) {
            return doc.data();
          }).where((event) {
        // تحويل النص المخزن ونص البحث كلاهما إلى حروف صغيرة للمقارنة
        final nameInDb = event.eventName.toLowerCase();
        final searchInput = eventName.toLowerCase();

        return nameInDb.contains(searchInput); // يبحث حتى لو كت
      })
          .toList();
    });
  }

  //////////////////////////////////////////////////////////
  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter(
      fromFirestore: (snapshot, options) => MyUser.formJson(snapshot.data()!),
      toFirestore: (user, options) => user.toJson(),
    );
  }

//////////////// add user to fire store
  static Future<void> addUserTOFireStore(MyUser user) {
    return getUserCollection().doc(user.id).set(user);
  }

  static Future<MyUser?> getUser(String userId) async {
    var userRef = await getUserCollection().doc(userId).get();
    return userRef.data();
  }
}

