// class Product {
//   final int? id;
//   final String description;
//   final double price;
//   final String? imagePath;

//   Product({
//     this.id,
//     required this.description,
//     required this.price,
//     this.imagePath,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'description': description,
//       'price': price,
//       'image': imagePath,
//     };
//   }

//   static Product fromMap(Map<String, dynamic> map) {
//     return Product(
//       id: map['id'] as int?,
//       description: map['description'] as String,
//       price: map['price'] as double,
//       imagePath: map['image'] as String?,
//     );
//   }
// }

class Product {
  final int? id;
  final String description;
  final double price;
  final String? image;

  Product({
    this.id,
    required this.description,
    required this.price,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'description': description,
      'price': price,
      'image': image,
    };
  }

  static Product fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      description: map['description'],
      price: map['price'],
      image: map['image'],
    );
  }
}
