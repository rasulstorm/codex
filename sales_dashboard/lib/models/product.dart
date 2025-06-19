class Product {
  final int id;
  final String title;
  final String description;
  final num price;

  Product({required this.id, required this.title, required this.description, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        price: json['price'] as num,
      );
}
