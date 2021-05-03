
import 'package:easy_food_service/ListGlobalData.dart';
import 'package:easy_food_service/Models/OrderedFoodModel.dart';
import 'package:flutter/material.dart';


class MyCheckBox extends StatefulWidget {
  final OrderedFoodModel product;
  MyCheckBox(this.product);

  static bool isSelected = false;
  @override
  _MyCheckBoxState createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13),
      child: Checkbox(
          value: MyCheckBox.isSelected,
          onChanged: (val) {
            setState(() {
              MyCheckBox.isSelected = val;
              if (MyCheckBox.isSelected){
                deleteOrders.add(widget.product);
              } else {
                deleteOrders.remove(widget.product);
              }
            });
          }),
    );
  }
}
