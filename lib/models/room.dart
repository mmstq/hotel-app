class Room {
  final int? number;
  final String type;
  final double? price;
  late final bool isAvailable;
  final String? imageUrl;// Added field for room image URL
  final String? amenities;

  Room({
     this.number,
     required this.type,
     this.price,
    this.isAvailable = true,
     this.imageUrl, // Initialize the image URL
    this.amenities,
  });
}
