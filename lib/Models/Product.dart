import 'package:json_annotation/json_annotation.dart';
part 'Product.g.dart';

@JsonSerializable()
class Product {
  String name;

  String imgUrl;
  String price;
  int quantity;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  Product.quantity(Product p, int q) {
    this.name = p.name;
    this.imgUrl = p.imgUrl;
    this.price = p.price;
    this.quantity = q;
  }

  bool compere(Product product) {
    if (this.name == product.name) {
      return true;
    } else
      return false;
  }

  Product.set(this.name, this.imgUrl, this.price, this.quantity);

  Product({this.name, this.imgUrl, this.price, this.quantity});
}
