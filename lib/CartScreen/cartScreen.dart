import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_food_service/CartScreen/CartDatabase.dart';
import 'package:easy_food_service/CartScreen/Counter.dart';
import 'package:easy_food_service/CartScreen/MyCheckBox.dart';
import 'package:easy_food_service/CartScreen/OrderFoodRequest.dart';
import 'package:easy_food_service/CartScreen/placeHolder.dart';
import 'package:easy_food_service/ListGlobalData.dart';
import 'package:easy_food_service/Models/PriceModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String _totalPrice() {
    int totalPrice = Provider.of<PriceModel>(context).getPrice();
    return totalPrice.toString();
  }

  Widget actionButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          deleteElements.forEach((element) {
            Provider.of<CartDatabase>(context, listen: false)
                .removeProduct(element);
          });
          deleteElements = [];
          MyCheckBox.isSelected = false;
          Provider.of<PriceModel>(context, listen: false).setPrice(context);
        },
      ),
    );
  }

  ElevatedButton checkOutButton(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.lightGreen)),
      onPressed: () => OrderFoodRequest.saveToDatabase(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Text(
          "Check Out",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "Arial",
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          actionButton(),
        ],
        iconTheme: IconThemeData(color: Colors.lightGreen),
        elevation: 0,
        title: Text(
          "Your Cart",
          style: TextStyle(
            fontFamily: "Times New Roman",
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: Colors.lightGreen,
          ),
        ),
      ),
      body: Stack(
        children: [
          Provider.of<CartDatabase>(context).length() != 0
              ? ListView.builder(
                  itemCount: Provider.of<CartDatabase>(context).length(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              MyCheckBox(Provider.of<CartDatabase>(context)
                                  .getProducts()[index]),
                              Container(
                                width: 75,
                                height: 80,
                                child: CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: Provider.of<CartDatabase>(context)
                                      .getProducts()[index]
                                      .imgUrl,
                                  placeholder: (context, string) =>
                                      myPlaceHoler(context),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 5, left: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Provider.of<CartDatabase>(context)
                                          .getProducts()[index]
                                          .name,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: "Times New Roman",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                    Text(
                                        "Rs ${Provider.of<CartDatabase>(context).getProducts()[index].price}",
                                        style: TextStyle(
                                          fontFamily: "Times New Roman",
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black54,
                                          fontSize: 12,
                                        )),
                                    Counter(
                                        Provider.of<CartDatabase>(context)
                                            .getProducts()[index],
                                        index),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Divider(),
                          SizedBox(
                            height: 5,
                          )
                        ],
                      ),
                    );
                  },
                )
              : Padding(
                  padding: const EdgeInsets.only(bottom: 80.0),
                  child: Center(
                    child: Text(
                      "Empty",
                      style: GoogleFonts.pacifico(
                          color: Colors.lightGreen, fontSize: 60),
                    ),
                  ),
                ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.lightGreen)),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Total: Rs. ${_totalPrice()}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Arial",
                          color: Colors.red,
                          fontSize: 16,
                        ),
                      ),
                      checkOutButton(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
