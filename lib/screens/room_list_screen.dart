// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/room_controller.dart';
//
// class RoomListScreen extends StatelessWidget {
//   final RoomController roomController = Get.put(RoomController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Available Rooms'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.filter_list),
//             onPressed: roomController.filterRoomsByAvailability,
//           ),
//         ],
//       ),
//       body: Obx(() {
//         if (roomController.isLoading.value) {
//           return Center(
//               child: CupertinoActivityIndicator.partiallyRevealed(
//             color: Colors.blueAccent.shade700,
//             radius: 15,
//           ));
//         }
//         return GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2),
//           itemCount: roomController.rooms.length,
//           itemBuilder: (context, index) {
//             var room = roomController.rooms[index];
//             return ListTile(
//               title: Text('Room ${room.number} - ${room.type}'),
//               subtitle: Text('${room.price} per night'),
//               trailing: room.isAvailable
//                   ? ElevatedButton(
//                       onPressed: () {
//                         roomController.bookRoom(room);
//                       },
//                       child: Text('Book'),
//                     )
//                   : Text('Booked', style: TextStyle(color: Colors.red)),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
