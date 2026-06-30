class CartModel {
  final String id;
  int quantity;
  String title;
  String image;
  double price;

  CartModel({
    required this.id,
    required this.quantity,
    required this.title,
    required this.image,
    required this.price,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'price': price,
    'image': image,
    'quantity': quantity,
  };

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    id: json['id'],
    title: json['title'],
    price: json['price'],
    image: json['image'],
    quantity: json['quantity'],
  );
}