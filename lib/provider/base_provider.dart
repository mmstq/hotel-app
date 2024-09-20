import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_app/models/room.dart';
import 'package:logger/logger.dart';

class BaseProvider{
  final firestore = FirebaseFirestore.instance;


  Future<List<Room>> getRooms()async{
    final ref = await firestore.collection('rooms').get();
    final rooms = <Room>[];
    for(var i in ref.docs){
      rooms.add(Room.fromJson(i.data()));
    }
    return rooms;
  }

  Future<List<Room>> getRoomsByFilter(String searchBy, String searchValue)async{
    final ref = await firestore.collection('rooms').where(searchBy, isEqualTo: searchValue).get();
    final rooms = <Room>[];
    for(var i in ref.docs){
      rooms.add(Room.fromJson(i.data()));
    }
    return rooms;
  }

  Future<List<Room>> getRoomsByPrice({bool descending = false})async{
    final ref = await firestore.collection('rooms').orderBy('price', descending: descending).get();
    final rooms = <Room>[];
    for(var i in ref.docs){
      rooms.add(Room.fromJson(i.data()));
    }
    return rooms;
  }
}