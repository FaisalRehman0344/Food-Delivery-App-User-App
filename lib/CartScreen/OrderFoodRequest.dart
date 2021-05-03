import 'package:easy_food_service/HttpUtilities/HttpRequests.dart';
import 'package:easy_food_service/LoginSystem/LoginRequest.dart';
import 'package:easy_food_service/Models/OrderedFoodModel.dart';
import 'package:easy_food_service/Models/PriceModel.dart';
import 'package:easy_food_service/Models/Product.dart';
import 'package:easy_food_service/Models/User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'CartDatabase.dart';

class OrderFoodRequest {
  static void saveToDatabase(BuildContext context) async {
    List<Product> _foodOrdered = [];
    User user = LoginRequest.user;
    CartDatabase db = CartDatabase.getInstance();
    db.getProducts().forEach((element) {
      _foodOrdered.add(element);
    });
    OrderedFoodModel orderedFoodModel = OrderedFoodModel(
        username: user.username,
        firstname: user.firstname,
        lastname: user.lastname,
        contact: user.contact,
        address: user.address,
        dateTime: DateTime.now(),
        status: "Under process",
        totalPrice: Provider.of<PriceModel>(context, listen: false).getPrice(),
        cartItem: _foodOrdered);
    int statusCode = await Provider.of<HttpRequests>(context, listen: false)
        .foodOrdered(orderedFoodModel);
    if (statusCode == 200) {
      Provider.of<CartDatabase>(context, listen: false).deleteAll();
      Provider.of<PriceModel>(context, listen: false).setPrice(context);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Order Placed")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to place order please try again")));
    }
  }
}
