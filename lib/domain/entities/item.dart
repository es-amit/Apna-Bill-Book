class Item {
  final int id;
  final String name;
  final int price;
  final String category;
  bool isFavorite = false;

  Item({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
  });
}
