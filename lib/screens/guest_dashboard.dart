import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_app/components/button.dart';
import 'package:hotel_app/models/room.dart';
import 'package:hotel_app/screens/account.dart';
import '../controllers/room_controller.dart';

class DashboardScreen extends GetView<RoomController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: controller.selectedIndex.value == 0
                ? const Text('Find Your Room')
                : const Text('Account'),
            actions: controller.selectedIndex.value == 0
                ? [
                    IconButton(
                      icon: const Icon(Icons.filter_list),
                      onPressed: () {
                        _showFilterDialog(context);
                      },
                    ),
                  ]
                : [],
          ),
          body: controller.selectedIndex.value == 0
              ? _buildRoomList()
              : AccountScreen(),
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              splashFactory: NoSplash.splashFactory, // Disable ripple effect
              highlightColor: Colors.transparent, // Remove highlight on tap
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    width: 1,
                    color: Get.theme.dividerColor.withOpacity(0.5),
                  ),
                ),
              ),
              child: BottomNavigationBar(
                showUnselectedLabels: false,
                currentIndex: controller.selectedIndex.value,
                onTap: (index) {
                  controller.selectedIndex.value = index;
                },
                items: [
                  BottomNavigationBarItem(
                    icon: controller.selectedIndex.value == 0
                        ? const Icon(Icons.bed)
                        : const Icon(Icons.bed_outlined),
                    label: 'Rooms',
                  ),
                  BottomNavigationBarItem(
                    icon: controller.selectedIndex.value == 1
                        ? const Icon(Icons.person_2)
                        : const Icon(Icons.person_2_outlined),
                    label: 'Account',
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildRoomList() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CupertinoActivityIndicator(
                    radius: 20,
                  ),
                );
              }
              if (controller.rooms.isEmpty) {
                return const Center(child: Text('No rooms found'));
              }
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                ),
                itemCount: controller.rooms.length,
                itemBuilder: (context, index) {
                  var room = controller.rooms[index];
                  return _buildRoomCard(room);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomCard(Room room) {
    return Container(
      height: Get.height * 0.2,
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Get.theme.dividerColor.withOpacity(0.2), // Shadow color
            spreadRadius: 1, // Spread radius
            blurRadius: 4, // Blur radius
            offset: const Offset(0, 4),
          ), // Shadow position (horizontal, vertical)
        ],
      ),
      margin: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            child: SizedBox(
              height: Get.height * 0.1,
              child: Image.asset(
                'assets/room_icon.png',
                fit: BoxFit.cover,
                color: Get.theme.dividerColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              '${room.roomType}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('\$${room.price} / night'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '${room.amenities}',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color:
                    Get.theme.textTheme.displaySmall!.color?.withOpacity(0.6),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: InputButton(
              label: Text(
                'Book Now',
                style: Get.theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              height: 40,
              onPressed: () {
                Get.toNamed('/book-room', arguments: room);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Filter and Sort Rooms'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Expansion tile for room types
                ExpansionTile(
                  title: const Text("Filter by Type"),
                  children: [
                    ListTile(
                      title: const Text('All Rooms'),
                      onTap: () {
                        controller.filterRoomsByType('All');
                        Get.back();
                      },
                    ),
                    ListTile(
                      title: const Text('Deluxe'),
                      onTap: () {
                        controller.filterRoomsByType('Deluxe');
                        Get.back();
                      },
                    ),
                    ListTile(
                      title: const Text('Suite'),
                      onTap: () {
                        controller.filterRoomsByType('Suite');
                        Get.back();
                      },
                    ),
                    ListTile(
                      title: const Text('Standard'),
                      onTap: () {
                        controller.filterRoomsByType('Standard');
                        Get.back();
                      },
                    ),
                  ],
                ),
                // Expansion tile for sorting
                ExpansionTile(
                  title: const Text("Sort by Price"),
                  children: [
                    ListTile(
                      title: const Text('Low to High'),
                      onTap: () {
                        controller.sortRoomsByPrice(descending: false);
                        Get.back();
                      },
                    ),
                    ListTile(
                      title: const Text('High to Low'),
                      onTap: () {
                        controller.sortRoomsByPrice(descending: true);
                        Get.back();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
