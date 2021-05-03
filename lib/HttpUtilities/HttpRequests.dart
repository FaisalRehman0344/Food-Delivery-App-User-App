import 'dart:convert';

import 'package:easy_food_service/LoginSystem/LoginRequest.dart';
import 'package:easy_food_service/Models/OrderedFoodModel.dart';
import 'package:easy_food_service/Models/ProductModel.dart';
import 'package:easy_food_service/Models/SignupUser.dart';
import 'package:easy_food_service/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpRequests extends ChangeNotifier {
  Future<int> foodOrdered(OrderedFoodModel orderedFoodModel) async {
    Uri uri = Uri.http('localhost:8080', '/user/orderFood');
    Map<String, dynamic> map = {
      "username": orderedFoodModel.username,
      "firstname": orderedFoodModel.firstname,
      "lastname": orderedFoodModel.lastname,
      "contact": orderedFoodModel.contact,
      "address": orderedFoodModel.address,
      "status": orderedFoodModel.status,
      "dateTime": orderedFoodModel.dateTime.toString(),
      "totalPrice": orderedFoodModel.totalPrice,
      "cartItem": orderedFoodModel.cartItem
    };
    var res =
        await http.post(uri, body: jsonEncode(map), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      "Authorization": LoginRequest.token,
    });
    notifyListeners();
    return res.statusCode;
  }

  Future<List<ProductModel>> listProducts() async {
    List<ProductModel> _list = [];
    var res = await http.get(
        Uri.http("localhost:8080", "/user/getAllAvailableFoods"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": LoginRequest.token,
        });
    if (res.statusCode == 200) {
      var jsonData = jsonDecode(res.body);
      for (var value in jsonData) {
        _list.add(ProductModel.formFactory(value));
      }
    }
    return _list;
  }

  Future<List<OrderedFoodModel>> getOrderedFoodDate(String username) async {
    List<OrderedFoodModel> _list = [];
    Uri uri = Uri.http("localhost:8080", "/user/getOrderedFood/$username");
    var res = await http.get(
      uri,
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "Authorization": LoginRequest.token
      },
    );

    var data = jsonDecode(res.body);
    for (var value in data) {
      _list.add(OrderedFoodModel.fromJson(value));
    }
    return _list;
  }

  void updateUser(SignupUser user, BuildContext context) async {
    if (user.contact.length > 12 ||
        user.contact.length < 12 ||
        !user.contact.startsWith("92")) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid Contact")));
    } else {
      Uri uri = Uri.http("localhost:8080", "/user/updateUser");
      Map<String, dynamic> map = {
        "username": LoginRequest.user.username,
        "firstname": user.firstname,
        "lastname": user.lastname,
        "contact": user.contact,
        "address": user.address,
      };
      var res = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': LoginRequest.token
        },
        body: jsonEncode(map),
      );

      String message = jsonDecode(res.body)["message"];
      SnackBar snackBar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      int status = jsonDecode(res.body)['status'];
      if (status == 200) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MyHomePage()));
      }
    }
  }

  void deleteOrder(OrderedFoodModel deleteOrder, BuildContext context) async {
    Uri uri = Uri.http("localhost:8080", "/user/deleteOrder");
    Map<String, dynamic> map = {
      "username" : deleteOrder.username,
      "firstname": deleteOrder.firstname,
      "lastname": deleteOrder.lastname,
      "contact": deleteOrder.contact,
      "address": deleteOrder.address,
      "status": deleteOrder.status,
      "dateTime": deleteOrder.dateTime.toString(),
      "totalPrice": deleteOrder.totalPrice,
      "cartItem": deleteOrder.cartItem
    };
    var res = await http.delete(
      uri,
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "Authorization": LoginRequest.token,
      },
      body: jsonEncode(map),
    );
    if (res.statusCode == 200) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Order Deleted")));
    }
    notifyListeners();
  }
}
