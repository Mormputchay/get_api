class ProductReModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Rating rating;

  ProductReModel(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image,
      required this.rating});

  factory ProductReModel.fromJson(Map<String, dynamic> json) {
    return ProductReModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"].toDouble(),
        category: json["category"],
        image: json["image"],
        rating: Rating(
            rate: json['rating']['rate'], count: json['rating']['count']));
  }
}

class Rating {
  final dynamic rate;
  final int count;

  Rating({required this.rate, required this.count});
}
