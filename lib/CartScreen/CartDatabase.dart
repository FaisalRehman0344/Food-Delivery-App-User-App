
import 'package:easy_food_service/Models/Product.dart';
import 'package:flutter/cupertino.dart';

class CartDatabase extends ChangeNotifier{
  List<Product> _list;
  static CartDatabase _cartDatabase = CartDatabase._();

  CartDatabase._(){
    _list = [];
  }

  static CartDatabase getInstance(){
    if (_cartDatabase == null){
      _cartDatabase = CartDatabase._();
    }
    return _cartDatabase;
  }

  void addProduct(Product product){
    _list.add(product);
    notifyListeners();
  }

  void removeProduct(Product product){
    _list.remove(product);
    notifyListeners();
  }

  void updateQuantity(String name, int quantity){
    for (int i=0;i<_list.length;i++){
      if (_list[i].name == name){
        _list[i].quantity = quantity;
      }
    }
    notifyListeners();
  }

  void updateProduct(Product product){
      for (int i=0;i<_list.length;i++){
        if (product.name == _list[i].name){
          _list.insert(i, product);
        }
      }
      notifyListeners();
  }

  List<Product> getProducts(){
    return _list;
  }

  int length(){
    return _list.length;
  }

  void deleteAll(){
    _list.clear();
    notifyListeners();
  }
}