import 'package:get/get.dart';
import 'package:hotel_app/models/room.dart';
import '../services/database_service.dart';

class RoomController extends GetxController {
  var rooms = <Room>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRooms();
  }

  void fetchRooms() async {
    isLoading(true);
    try {
      var roomList = await DatabaseService().getRooms();
      rooms.value = roomList;
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
    var availableRooms = rooms.where((room) => room.isAvailable!).toList();
    rooms.value = availableRooms;
  }
}
