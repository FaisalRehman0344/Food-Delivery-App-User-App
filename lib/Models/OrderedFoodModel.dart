import 'package:easy_food_service/Models/Product.dart';
import 'package:json_annotation/json_annotation.dart';

part 'OrderedFoodModel.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderedFoodModel {
  String username;
  String firstname;
  String lastname;
  String contact;
  String address;
  String status;
  DateTime dateTime;
  int totalPrice;
  List<Product> cartItem;

  OrderedFoodModel({
    this.username,
    this.firstname,
    this.lastname,
    this.address,
    this.contact,
    this.cartItem,
    this.dateTime,
    this.status,
    this.totalPrice,
  });

  factory OrderedFoodModel.fromJson(Map<String, dynamic> json) =>
      _$OrderedFoodModelFromJson(json);
  Map<String, dynamic> toJson() => _$OrderedFoodModelToJson(this);
}
