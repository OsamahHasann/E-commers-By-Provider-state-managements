class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String image;
  bool isFavorite;
  bool isAddedToCart = false;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    this.isFavorite = false,
    this.isAddedToCart = false,
  });
}