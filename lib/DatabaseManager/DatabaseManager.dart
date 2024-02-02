import 'package:aspenproject/models/locations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseManager{

final _db=FirebaseFirestore.instance;

Future<List<LocationsModel>> getLocations(String type,String id) async{
  var snapShot= _db.collection("Locations").where("ID", isEqualTo: id);
  snapShot=snapShot.where("Type", isEqualTo: type);
  final query=await snapShot.get();
  final loc=query.docs.map((e)=>LocationsModel.fromSnapshot(e)).toList();
  return loc;

}

}