import 'package:hotel_app/models/booking.dart';
import 'package:hotel_app/models/room.dart';

class DatabaseService {
  Future<List<Room>> getRooms() async {
    // Simulate a delay and return dummy rooms
    await Future.delayed(const Duration(seconds: 1));
    return [
      // Room(
      //   number: 101,
      //   type: 'Deluxe',
      //   price: 80,
      //   isAvailable: true,
      //   amenities: '2 RestRoom, 2 King size bed, Well maintained,'
      //       'Window city view , fully furnished',
      // ),
      // Room(
      //   number: 102,
      //   type: 'Standard',
      //   price: 30,
      //   isAvailable: true,
      //   amenities: '1 RestRoom,King size bed',
      // ),
      // Room(
      //   number: 103,
      //   type: 'Suite',
      //   price: 50,
      //   isAvailable: false,
      //   amenities: '1 RestRoom,King size bed',
      // ),
      // Room(
      //   number: 104,
      //   type: 'Standard',
      //   price: 5,
      //   isAvailable: true,
      //   amenities: '1 RestRoom,King size bed',
      // ),
      // Room(
      //   number: 105,
      //   type: 'Deluxe',
      //   price: 10,
      //   isAvailable: true,
      //   amenities: '1 RestRoom,King size bed',
      // ),
      // Room(
      //   number: 106,
      //   type: 'Deluxe',
      //   price: 20,
      //   isAvailable: true,
      //   amenities: '2 RestRoom, 2 King size bed, Well maintained'
      //       ',Window city view , fully furnished',
      // ),
      // Room(
      //   number: 107,
      //   type: 'Suite',
      //   price: 200,
      //   isAvailable: false,
      //   amenities: '1 RestRoom,King size bed',
      // ),
      // Room(
      //   number: 108,
      //   type: 'Standard',
      //   price: 50,
      //   isAvailable: true,
      //   amenities: '1 RestRoom,King size bed',
      // ),
      // Room(
      //   number: 109,
      //   type: 'Suit',
      //   price: 100,
      //   isAvailable: true,
      //   amenities: '1 RestRoom,King size bed',
      // ),
      // Room(
      //   number: 110,
      //   type: 'Standard',
      //   price: 80,
      //   isAvailable: true,
      //   amenities: '1 RestRoom,King size bed',
      // ),
      // Room(
      //   number: 111,
      //   type: 'Deluxe',
      //   price: 200,
      //   isAvailable: false,
      //   amenities: '2 RestRoom, 2 King size bed, '
      //       'Well maintained,Window city view , fully furnished',
      // ),
      // Room(
      //   number: 112,
      //   type: 'Suit',
      //   price: 50,
      //   isAvailable: true,
      //   amenities: '1 RestRoom,King size bed',
      // ),
      // Room(
      //   number: 113,
      //   type: 'Standard',
      //   price: 100,
      //   isAvailable: true,
      //   amenities: '1 RestRoom,Double bed',
      // ),
      // Room(
      //   number: 114,
      //   type: 'Standard',
      //   price: 30,
      //   isAvailable: true,
      //   amenities: '1 RestRoom,King size bed',
      // ),
      // Room(
      //   number: 115,
      //   type: 'Suite',
      //   price: 50,
      //   isAvailable: false,
      //   amenities: '1 RestRoom,King size bed',
      // ),
      // Room(
      //   number: 116,
      //   type: 'Deluxe',
      //   price: 20,
      //   isAvailable: true,
      //   amenities: '1 RestRoom,Single bed',
      // ),
      // Room(
      //   number: 117,
      //   type: 'Suit',
      //   price: 20,
      //   isAvailable: true,
      //   amenities: '1 RestRoom,Single bed',
      // ),
    ];
  }

  getBookings() {}
}

class BookingService {
  // Simulate fetching booking data for the current user
  Future<List<Booking>> getUserBookings() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    // Example list of bookings (you can replace this with an API call)
    return [
      Booking(
        id: '1',
        room: Room(
          type: 'Deluxe',
          amenities: '',
        ),
        checkInDate: DateTime(2023, 8, 1),
        checkOutDate: DateTime(2023, 8, 5),
        status: 'completed',
      ),
      Booking(
        id: '2',
        room: Room(
          type: 'Deluxe',
          amenities: '',
        ),
        checkInDate: DateTime(2024, 3, 15),
        checkOutDate: DateTime(2024, 3, 20),
        status: 'upcoming',
      ),
    ];
  }
}
