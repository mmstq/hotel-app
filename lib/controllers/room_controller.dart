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
  bool isBooked = false;


  @override
  void onInit() {
    isBooked = Get.arguments?['booked']??false;
    fetchRooms();
    super.onInit();
  }
  Future<void> fetchRooms() async {
    isLoading.value = true;
    rooms.value = await provider.getRooms(isBooked: isBooked);
    isLoading.value = false;
  }
  Future<void> filterRoomsByType(String roomType) async {
    isLoading.value = true;
    if (roomType == 'All') {
      rooms.value = await provider.getRooms(isBooked: isBooked);
    } else {
      rooms.value = await provider.getRoomsByFilter('roomType', roomType, isBooked: isBooked);
    }
    isLoading.value = false;
  }
  Future<void> sortRoomsByPrice({bool descending = false}) async {
    isLoading.value = true;
    rooms.value = await provider.getRoomsByPrice(descending: descending, isBooked: isBooked); // Fetch sorted rooms
    isLoading.value = false;
  }

}
