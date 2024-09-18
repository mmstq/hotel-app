import 'package:get/get.dart';
import 'package:hotel_app/models/room.dart';
import '../services/database_service.dart';

class RoomController extends GetxController {
  var rooms = <Room>[].obs;
  var filteredRooms = <Room>[].obs;
  var isLoading = true.obs;
  var selectedFilter = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRooms();
  }

  void fetchRooms() async {
    isLoading(true);
    try {
      var roomList = await DatabaseService().getRooms();
      rooms.value = roomList;        // Set the original list
      filteredRooms.value = roomList; // Initially, show all rooms
        } finally {
      isLoading(false);
    }
  }

  void bookRoom(Room room) {
    room.isAvailable = false;
    rooms.refresh();
    Get.snackbar('Success', 'Room booked successfully');
  }

  void filterRoomsByAvailability() {
    var availableRooms = rooms.where((room) => room.isAvailable).toList();
    rooms.value = availableRooms;
  }
  // Filter rooms by a specific type
  void filterRoomsByType(String type) {
    selectedFilter.value = type;  // Update the selected filter

    if (type == 'All') {
      filteredRooms.value = rooms;  // Show all rooms if no filter is applied
    } else {
      filteredRooms.value = rooms.where((room) => room.type == type).toList();
    }
  }

  // Sorting rooms by price
  void sortRoomsByPrice(String sortOrder) {
    if (sortOrder == 'LowToHigh') {
      rooms.sort((a, b) => a.price!.compareTo(b.price as num)); // Ascending order
    } else if (sortOrder == 'HighToLow') {
      rooms.sort((a, b) => b.price!.compareTo(a.price as num)); // Descending order
    }
  }
}
