class Product {
  final num price;
  final String name;
  final String image;
  final List<String> addOns;

  Product(
      {required this.name,
      required this.price,
      required this.image,
      required this.addOns});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      name: json['name'],
      price: json['price'],
      image: json['image'],
      addOns: List<String>.from(json['addOns'] ?? []));

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'image': image,
        'addOns': addOns.map((e) => e).toList()
      };
}
