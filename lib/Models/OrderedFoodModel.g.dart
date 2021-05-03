// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderedFoodModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderedFoodModel _$OrderedFoodModelFromJson(Map<String, dynamic> json) {
  return OrderedFoodModel(
    username: json['username'] as String,
    firstname: json['firstname'] as String,
    lastname: json['lastname'] as String,
    address: json['address'] as String,
    contact: json['contact'] as String,
    cartItem: (json['cartItem'] as List)
        ?.map((e) =>
            e == null ? null : Product.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    dateTime: json['dateTime'] == null
        ? null
        : DateTime.parse(json['dateTime'] as String),
    status: json['status'] as String,
    totalPrice: json['totalPrice'] as int,
  );
}

Map<String, dynamic> _$OrderedFoodModelToJson(OrderedFoodModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'contact': instance.contact,
      'address': instance.address,
      'status': instance.status,
      'dateTime': instance.dateTime?.toIso8601String(),
      'totalPrice': instance.totalPrice,
      'cartItem': instance.cartItem?.map((e) => e?.toJson())?.toList(),
    };
