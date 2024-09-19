import 'package:get/get.dart';
import 'package:hotel_app/models/room.dart';
import 'package:hotel_app/provider/base_provider.dart';

class RoomController extends GetxController {
  var rooms = <Room>[].obs;
  var filteredRooms = <Room>[].obs;
  var isLoading = true.obs;
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

  void fetchRooms() async {
    isLoading(true);
    provider.getRoomsByPrice(

    ).then((roomsFromFirestore){
      rooms.value = roomsFromFirestore;
      rooms.refresh();
    }).whenComplete(()=>isLoading(false))
    ;
  }

  void bookRoom(Room room) {
    room.isBooked = false;
    rooms.refresh();
    Get.snackbar('Success', 'Room booked successfully');
  }

}
