// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    name: json['name'] as String,
    imgUrl: json['imgUrl'] as String,
    price: json['price'] as String,
    quantity: json['quantity'] as int,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'name': instance.name,
      'imgUrl': instance.imgUrl,
      'price': instance.price,
      'quantity': instance.quantity,
    };
