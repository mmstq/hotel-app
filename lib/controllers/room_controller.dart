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


  @override
  void onInit() {
    fetchRooms();
    super.onInit();
  }
  Future<void> fetchRooms() async {
    isLoading.value = true;
    rooms.value = await provider.getRooms();
    isLoading.value = false;
  }
  Future<void> filterRoomsByType(String roomType) async {
    isLoading.value = true;
    if (roomType == 'All') {
      rooms.value = await provider.getRooms();
    } else {
      rooms.value = await provider.getRoomsByFilter('roomType', roomType);
    }
    isLoading.value = false;
  }
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
