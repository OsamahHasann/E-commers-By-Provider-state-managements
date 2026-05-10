class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image;
  final String category;
  bool isFavorite;
  bool isAddedToCart = false;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.category,
    this.isFavorite = false,
    this.isAddedToCart = false,
  });
}