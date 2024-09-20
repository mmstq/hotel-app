import 'package:get/get.dart';
import 'package:hotel_app/models/room.dart';
import 'package:hotel_app/provider/base_provider.dart';

class RoomController extends GetxController {
  var rooms = <Room>[].obs;
  var filteredRooms = <Room>[].obs;
  var isLoading = false.obs;
  var selectedFilter = 'All'.obs;
  RxInt selectedIndex = 0.obs;
  final provider = Get.find<BaseProvider>();
  String? search;
  String? value;

  final roomImages = [
    'https://images.pexels.com/photos/164595/pexels-photo-164595.jpeg',
    'https://media.istockphoto.com/id/492189224/photo/seaview-bedroom.jpg?s=612x612&w=0&k=20&c=tSL5OoSdxW3l7WzdBGU2_NnGNjDH88twjNZTTkll2jY=',
    'https://media.istockphoto.com/id/1390233984/photo/modern-luxury-bedroom.jpg?s=612x612&w=0&k=20&c=po91poqYoQTbHUpO1LD1HcxCFZVpRG-loAMWZT7YRe4=',
    'https://t3.ftcdn.net/jpg/02/71/08/28/360_F_271082810_CtbTjpnOU3vx43ngAKqpCPUBx25udBrg.jpg',
    'https://plus.unsplash.com/premium_photo-1661879252375-7c1db1932572?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8aG90ZWwlMjBiZWRyb29tfGVufDB8fDB8fHww',
    'https://t3.ftcdn.net/jpg/06/39/88/70/360_F_639887058_HCisflmW1CTF4EoNBv2CADRdf0RftNoR.jpg',
    'https://media.istockphoto.com/id/492189224/photo/seaview-bedroom.jpg?s=612x612&w=0&k=20&c=tSL5OoSdxW3l7WzdBGU2_NnGNjDH88twjNZTTkll2jY=',
    'https://media.istockphoto.com/id/1390233984/photo/modern-luxury-bedroom.jpg?s=612x612&w=0&k=20&c=po91poqYoQTbHUpO1LD1HcxCFZVpRG-loAMWZT7YRe4=',
    'https://t3.ftcdn.net/jpg/02/71/08/28/360_F_271082810_CtbTjpnOU3vx43ngAKqpCPUBx25udBrg.jpg',
    'https://plus.unsplash.com/premium_photo-1661879252375-7c1db1932572?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8aG90ZWwlMjBiZWRyb29tfGVufDB8fDB8fHww',
    'https://t3.ftcdn.net/jpg/06/39/88/70/360_F_639887058_HCisflmW1CTF4EoNBv2CADRdf0RftNoR.jpg',
  ];

  @override
  void onInit() {
    fetchRooms();
    super.onInit();
  }

  // Fetch all rooms
  Future<void> fetchRooms() async {
    isLoading.value = true;
    rooms.value = await provider.getRooms(); // Call provider to get all rooms
    isLoading.value = false;
  }

  // Filter rooms by type
  Future<void> filterRoomsByType(String roomType) async {
    isLoading.value = true;
    if (roomType == 'All') {
      rooms.value = await provider.getRooms(); // Fetch all rooms if filter is 'All'
    } else {
      rooms.value = await provider.getRoomsByFilter('roomType', roomType); // Fetch filtered rooms
    }
    isLoading.value = false;
  }

  // Sort rooms by price
  Future<void> sortRoomsByPrice({bool descending = false}) async {
    isLoading.value = true;
    rooms.value = await provider.getRoomsByPrice(descending: descending); // Fetch sorted rooms
    isLoading.value = false;
  }

  void bookRoom(Room room) {
    room.isBooked = false;
    rooms.refresh();
    Get.snackbar('Success', 'Room booked successfully');
  }
}
