import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  static const collectionName = 'Events';
  String id;
  String eventImage;
  String eventName;
  int eventCatIndex;
  String eventTitle;
  String eventDescription;
  DateTime eventDate;
  bool isFavorite;

  Event({
    this.id = '',
    required this.eventImage,
    required this.eventName,
    required this.eventCatIndex,
    required this.eventTitle,
    required this.eventDescription,
    required this.eventDate,
    this.isFavorite = false,
  });

  //todo: from json to object
  Event.fromJson(Map<String, dynamic> data)
    : this(
        id: data['id'],
        eventImage: data['event_image'],
        eventName: data['event_name'],
        eventCatIndex: data['event_cat_index'],
        eventTitle: data['event_title'],
        eventDescription: data['event_description'],
        eventDate: (data['event_date'] as Timestamp).toDate(),
        isFavorite: data['is_favorite'],
      );

  //todo:from object to json
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "event_image": eventImage,
      "event_name": eventName,
      "event_cat_index": eventCatIndex,
      "event_title": eventTitle,
      "event_description": eventDescription,
      "event_date": eventDate,
      "is_favorite": isFavorite,
    };
  }
}
