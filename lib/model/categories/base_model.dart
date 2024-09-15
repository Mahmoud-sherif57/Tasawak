class BaseModel {
  final num id;
  final String imageUrl;
  final String name;
  final num price;
  final num review;
  final num star;
  num? value;

  BaseModel({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.review,
    required this.star,
    required this.value,
  });
}
