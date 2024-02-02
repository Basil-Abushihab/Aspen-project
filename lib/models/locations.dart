import 'package:cloud_firestore/cloud_firestore.dart';
class LocationsModel {
  late String title;
  late int reviews;
  late double ratings;
  late String description;
  late bool isLiked;
  late int price;
  late String id;
  late String src;
  late String type;
  late String duration;

  LocationsModel({required this.title,
    required this.reviews,
    required this.ratings,
    required this.description,
    required this.price,
    required this.id,
    required this.src,
    required this.type,
    required this.duration,
    required this.isLiked
  });


  factory LocationsModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return LocationsModel(title: data["Title"],
        reviews: data["Reviews"],
        ratings: data["Ratings"],
        description: data["Description"],
        price: data["Price"],
        id: data["ID"],
        src: data["Src"],
        type: data["Type"],
        duration: data["Duration"],
        isLiked:data["isLiked"]);
  }
}
