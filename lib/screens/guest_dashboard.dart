import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_app/components/button.dart';
import 'package:hotel_app/screens/account.dart';
import '../controllers/room_controller.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final RoomController roomController = Get.put(RoomController());
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _selectedIndex == 0
            ? const Text('Find Your Room')
            : const Text('Account'),
        actions: _selectedIndex == 0
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
      body: _selectedIndex == 0 ? _buildRoomList() : AccountScreen(),
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
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: _selectedIndex == 0
                    ? const Icon(CupertinoIcons.bed_double_fill)
                    : const Icon(CupertinoIcons.bed_double),
                label: 'Rooms',
              ),
              BottomNavigationBarItem(
                icon: _selectedIndex == 1
                    ? const Icon(CupertinoIcons.person_alt_circle_fill)
                    : const Icon(CupertinoIcons.person_alt_circle),
                label: 'Account',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoomList() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (roomController.isLoading.value) {
                return const Center(
                  child: CupertinoActivityIndicator(
                    radius: 20,
                  ),
                );
              }
              if (roomController.filteredRooms.isEmpty) {
                return const Center(child: Text('No rooms found'));
              }
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.9,
                ),
                itemCount: roomController.filteredRooms.length,
                itemBuilder: (context, index) {
                  var room = roomController.filteredRooms[index];
                  return _buildRoomCard(room);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomCard(room) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.2,
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
              height: MediaQuery.sizeOf(context).height * 0.1,
              child:Image.asset(
                'assets/room_icon.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              '${room.type}',
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
                color: Get.theme.textTheme.displaySmall!.color?.withOpacity(0.6),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: InputButton(
              label: 'Book Now',
              height: 40,
              onPressed: () {
                Navigator.pushNamed(context, '/book-room', arguments: room);
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
                        roomController.filterRoomsByType('All');
                        Get.back();
                      },
                      selected: roomController.selectedFilter.value == 'All',
                    ),
                    ListTile(
                      title: const Text('Deluxe'),
                      onTap: () {
                        roomController.filterRoomsByType('Deluxe');
                        Get.back();
                      },
                    ),
                    ListTile(
                      title: const Text('Suite'),
                      onTap: () {
                        roomController.filterRoomsByType('Suite');
                        Get.back();
                      },
                    ),
                    ListTile(
                      title: const Text('Standard'),
                      onTap: () {
                        roomController.filterRoomsByType('Standard');
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
                        roomController.sortRoomsByPrice('LowToHigh');
                        Get.back();
                      },
                    ),
                    ListTile(
                      title: const Text('High to Low'),
                      onTap: () {
                        roomController.sortRoomsByPrice('HighToLow');
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
