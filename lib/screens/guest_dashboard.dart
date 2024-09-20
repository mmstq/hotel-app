import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_app/components/button.dart';
import 'package:hotel_app/components/helper_functions.dart';
import 'package:hotel_app/models/room.dart';
import 'package:hotel_app/screens/account.dart';
import 'package:text_scroll/text_scroll.dart';
import '../controllers/room_controller.dart';

class DashboardScreen extends GetView<RoomController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: controller.selectedIndex.value == 0 ? const Text('Find Your Room') : const Text('Account'),
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
          body: controller.selectedIndex.value == 0 ? _buildRoomList() : AccountScreen(),
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              splashFactory: NoSplash.splashFactory,
              highlightColor: Colors.transparent,
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
                backgroundColor: Get.theme.cardColor,
                selectedItemColor: Colors.blue,
                currentIndex: controller.selectedIndex.value,
                onTap: (index) {
                  controller.selectedIndex.value = index;
                },
                items: [
                  BottomNavigationBarItem(
                    icon: controller.selectedIndex.value == 0
                        ? const Icon(
                            Icons.bed,
                            color: Colors.blue,
                          )
                        : const Icon(Icons.bed_outlined),
                    label: 'Rooms',
                  ),
                  BottomNavigationBarItem(
                    icon: controller.selectedIndex.value == 1
                        ? const Icon(
                            Icons.person,
                            color: Colors.blue,
                          )
                        : const Icon(Icons.person_outlined),
                    label: 'Account',
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildRoomList() {
    return Column(
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
                childAspectRatio: 0.75,
              ),
              itemCount: controller.rooms.length,
              itemBuilder: (context, index) {
                var room = controller.rooms[index];
                return _buildRoomCard(room, index);
              },
            );
          }),
        ),
      ],
    );
  }

  Widget _buildRoomCard(Room room, int index) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Get.theme.dividerColor.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(1, 1),
          ), // Shadow position (horizontal, vertical)
        ],
      ),
      margin: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: room.image!,
            width: 200,
            height: 120,
            fit: BoxFit.fill,
            placeholder: (context, url) => const SizedBox(
              height: 24,
              width: 24,
              child: Center(
                child: CircularProgressIndicator(), // Show a loader while loading
              ),
            ),
            errorWidget: (context, url, error) => const Center(
              child: Icon(
                Icons.error, // Show an error icon if image fails to load
                color: Colors.red,
                size: 40.0,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      '${room.roomType}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('₹${room.price} / night'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextScroll(
                      room.amenities!.join(' | '),
                      velocity: const Velocity(pixelsPerSecond: Offset(30, 0)),
                      delayBefore: const Duration(milliseconds: 500),
                      mode: TextScrollMode.bouncing,
                      pauseBetween: const Duration(milliseconds: 50),
                      style: TextStyle(
                        color: Get.theme.textTheme.displaySmall!.color?.withOpacity(0.6),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InputButton(
                      label: Text(
                        controller.isBooked?'Un-Book Now':'Book Now',
                        style: Get.theme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      height: 32,
                      onPressed: () async{
                        if(controller.isBooked){
                          FirebaseFirestore.instance.collection('rooms').doc(room.id).update({'isBooked':false});
                          controller.fetchRooms();
                          return;
                        }else {
                          roomAsArgument = room;
                          Get.toNamed('/book-room', arguments: {'room': room});
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
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
