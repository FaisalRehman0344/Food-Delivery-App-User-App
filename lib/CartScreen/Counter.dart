import 'package:easy_food_service/CartScreen/CartDatabase.dart';
import 'package:easy_food_service/Models/Product.dart';
import 'package:easy_food_service/Models/PriceModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Counter extends StatefulWidget {
  final Product product;
  final int index;
  Counter(this.product, this.index);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  CartDatabase products = CartDatabase.getInstance();
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.lightGreen)),
        child: Row(
          children: [
            TextButton(
              onPressed: () {
                ++quantity;
                products.updateQuantity(widget.product.name, quantity);
                Provider.of<PriceModel>(context, listen: false)
                    .setPrice(context);
              },
              child: Icon(Icons.add),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text("${products.getProducts()[widget.index].quantity}"),
            ),
            TextButton(
              onPressed: () {
                if (quantity > 1) {
                  --quantity;
                }
                products.updateQuantity(widget.product.name, quantity);
                Provider.of<PriceModel>(context, listen: false)
                    .setPrice(context);
              },
              child: Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}
