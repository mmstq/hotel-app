class Room {
  final int number;
  final String type;
  final double price;
  late final bool isAvailable;
  final String imageUrl; // Added field for room image URL

  Room({
    required this.number,
    required this.type,
    required this.price,
    this.isAvailable = true,
    required this.imageUrl, // Initialize the image URL
  });
}
