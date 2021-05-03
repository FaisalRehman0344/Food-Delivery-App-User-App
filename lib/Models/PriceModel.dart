import 'package:easy_food_service/CartScreen/CartDatabase.dart';
import 'package:easy_food_service/Models/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PriceModel extends ChangeNotifier {
  int _totalPrice;

  PriceModel() {
    _totalPrice = 0;
  }

  void setPrice(BuildContext context) {
    List<Product> list =
        (Provider.of<CartDatabase>(context, listen: false).getProducts());
    _totalPrice = 0;
    list.forEach((element) {
      String err = element.price.split(" ").first;
      int price = int.parse(err);
      _totalPrice += (price * element.quantity);
    });
    notifyListeners();
  }

  int getPrice() {
    return this._totalPrice;
  }
}
