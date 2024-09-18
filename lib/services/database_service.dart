import 'package:hotel_app/models/room.dart';

class DatabaseService {
  Future<List<Room>> getRooms() async {
    // Simulate a delay and return dummy rooms
    await Future.delayed(const Duration(seconds: 1));
    return [
      Room(
        number: 101,
        type: 'Deluxe',
        price: 80,
        isAvailable: true,
        imageUrl: 'assets/hotel_room_1.jpg',
        amenities: '2 RestRoom, 2 King size bed, Well maintained,'
            'Window city view , fully furnished',
      ),
      Room(
        number: 102,
        type: 'Standard',
        price: 30,
        isAvailable: true,
        imageUrl: 'assets/hotel_room_2.jpg',
        amenities: '1 RestRoom,King size bed',
      ),
      Room(
        number: 103,
        type: 'Suite',
        price: 50,
        isAvailable: false,
        imageUrl: 'assets/hotel_room_3.jpg',
        amenities: '1 RestRoom,King size bed',
      ),
      Room(
        number: 104,
        type: 'Standard',
        price: 5,
        isAvailable: true,
        imageUrl: 'assets/hotel_room_4.jpg',
        amenities: '1 RestRoom,King size bed',
      ),
      Room(
        number: 105,
        type: 'Deluxe',
        price: 10,
        isAvailable: true,
        imageUrl: 'assets/hotel_room_5.jpg',
        amenities: '1 RestRoom,King size bed',
      ),
      Room(
        number: 106,
        type: 'Deluxe',
        price: 20,
        isAvailable: true,
        imageUrl: 'assets/hotel_room_6.jpg',
        amenities: '2 RestRoom, 2 King size bed, Well maintained'
            ',Window city view , fully furnished',
      ),
      Room(
        number: 107,
        type: 'Suite',
        price: 200,
        isAvailable: false,
        imageUrl: 'assets/hotel_room_7.jpg',
        amenities: '1 RestRoom,King size bed',
      ),
      Room(
        number: 108,
        type: 'Standard',
        price: 50,
        isAvailable: true,
        imageUrl: 'assets/room_1.jpg',
        amenities: '1 RestRoom,King size bed',
      ),
      Room(
        number: 109,
        type: 'Suit',
        price: 100,
        isAvailable: true,
        imageUrl: 'assets/room_2.jpg',
        amenities: '1 RestRoom,King size bed',
      ),
      Room(
        number: 110,
        type: 'Standard',
        price: 80,
        isAvailable: true,
        imageUrl: 'assets/room_3.jpg',
        amenities: '1 RestRoom,King size bed',
      ),
      Room(
        number: 111,
        type: 'Deluxe',
        price: 200,
        isAvailable: false,
        imageUrl: 'assets/room_4.jpg',
        amenities:'2 RestRoom, 2 King size bed, '
            'Well maintained,Window city view , fully furnished',
      ),
      Room(
        number: 112,
        type: 'Suit',
        price: 50,
        isAvailable: true,
        imageUrl: 'assets/room_5.jpg',
        amenities: '1 RestRoom,King size bed',
      ),
      Room(
        number: 113,
        type: 'Standard',
        price: 100,
        isAvailable: true,
        imageUrl: 'assets/room_6.jpg',
        amenities: '1 RestRoom,Double bed',
      ),
      Room(
        number: 114,
        type: 'Standard',
        price: 30,
        isAvailable: true,
        imageUrl: 'assets/room_7.jpg',
        amenities: '1 RestRoom,King size bed',
      ),
      Room(
        number: 115,
        type: 'Suite',
        price: 50,
        isAvailable: false,
        imageUrl: 'assets/room_8.jpg',
        amenities: '1 RestRoom,King size bed',
      ),
      Room(
        number: 116,
        type: 'Deluxe',
        price: 20,
        isAvailable: true,
        imageUrl: 'assets/room_9.jpg',
        amenities: '1 RestRoom,Single bed',
      ),
      Room(
        number: 117,
        type: 'Suit',
        price: 20,
        isAvailable: true,
        imageUrl: 'assets/room_10.jpg',
        amenities: '1 RestRoom,Single bed',
      ),
    ];
  }

  getBookings() {}
}
