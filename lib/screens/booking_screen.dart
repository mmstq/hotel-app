import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_app/models/room.dart';
import 'package:hotel_app/models/user.dart';
import '../controllers/booking_controller.dart';
import '../models/booking.dart';

class BookingScreen extends StatelessWidget {
  final Room room;
  final BookingController bookingController = Get.put(BookingController());

  BookingScreen({super.key, required this.room});

  final _checkInDateController = TextEditingController();
  final _checkOutDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Room ${room.number}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Room Type: ${room.type}'),
            Text('Price: \$${room.price} per night'),
            TextField(
              controller: _checkInDateController,
              decoration: const InputDecoration(labelText: 'Check-In Date'),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (picked != null) {
                  _checkInDateController.text = picked.toString();
                }
              },
            ),
            TextField(
              controller: _checkOutDateController,
              decoration: const InputDecoration(labelText: 'Check-Out Date'),
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (picked != null) {
                  _checkOutDateController.text = picked.toString();
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                User user = User(id: '1', name: 'John Doe', email: 'john@example.com', role: 'guest'); // Example user
                Booking booking = Booking(
                  id: DateTime.now().toString(),
                  room: room,
                  user: user,
                  checkInDate: DateTime.parse(_checkInDateController.text),
                  checkOutDate: DateTime.parse(_checkOutDateController.text),
                );
                bookingController.createBooking(booking);
                Get.back();
              },
              child: const Text('Book Now'),
            ),
          ],
        ),
      ),
    );
  }
}
