// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/booking_controller.dart';
//
// class GuestManagementScreen extends StatelessWidget {
//   final BookingController bookingController = Get.put(BookingController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Guest Management'),
//       ),
//       body: Obx(() {
//         if (bookingController.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }
//         if (bookingController.bookings.isEmpty) {
//           return Center(child: Text('No guests found'));
//         }
//         return ListView.builder(
//           itemCount: bookingController.bookings.length,
//           itemBuilder: (context, index) {
//             var booking = bookingController.bookings[index];
//             return ListTile(
//               title: Text('Guest: ${booking.user.name}'),
//               subtitle: Text(
//                 'Room ${booking.room.number} - ${booking.room.type}',
//               ),
//               trailing: booking.status == 'checked-in'
//                   ? ElevatedButton(
//                 onPressed: () {
//                   booking.status = 'checked-out';
//                   bookingController.bookings.refresh();
//                   Get.snackbar('Success', 'Guest checked out');
//                 },
//                 child: Text('Check-Out'),
//               )
//                   : ElevatedButton(
//                 onPressed: () {
//                   booking.status = 'checked-in';
//                   bookingController.bookings.refresh();
//                   Get.snackbar('Success', 'Guest checked in');
//                 },
//                 child: Text('Check-In'),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
