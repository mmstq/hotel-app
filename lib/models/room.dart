class Room {
  final int number;
  final String type;
  final double price;
  bool isAvailable;

  Room({
    required this.number,
    required this.type,
    required this.price,
    this.isAvailable = true,
  });
}
