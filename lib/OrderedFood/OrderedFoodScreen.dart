import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_food_service/HttpUtilities/HttpRequests.dart';
import 'package:easy_food_service/Models/User.dart';
import 'package:easy_food_service/LoginSystem/LoginRequest.dart';
import 'package:easy_food_service/Models/OrderedFoodModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderedFoodScreen extends StatefulWidget {
  @override
  _OrderedFoodScreenState createState() => _OrderedFoodScreenState();
}

class _OrderedFoodScreenState extends State<OrderedFoodScreen> {
  User user;
  @override
  void initState() {
    user = LoginRequest.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool _isDelivered = false;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.lightGreen),
        title: Text(
          "Ordered Food",
          style: TextStyle(
            fontFamily: "Times New Roman",
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: Colors.lightGreen,
          ),
        ),
      ),
      body: FutureBuilder<List<OrderedFoodModel>>(
        future: Provider.of<HttpRequests>(context)
            .getOrderedFoodDate(user.username),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            bool isEmpty = snapshot.data.isNotEmpty ? false : true;
            return isEmpty
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 80.0),
                    child: Center(
                      child: Text(
                        "Empty",
                        style: GoogleFonts.pacifico(
                          color: Colors.lightGreen,
                          fontSize: 60,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      DateTime dateTime = snapshot.data[index].dateTime;
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(dateTime);
                      String formattedTime =
                          DateFormat('kk:mm').format(dateTime);
                      if (snapshot.data[index].status == "Delivered") {
                        _isDelivered = true;
                      }
                      return GestureDetector(
                        onLongPress: () => {
                          showMenu(
                            position: RelativeRect.fill,
                            items: <PopupMenuEntry>[
                              PopupMenuItem(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (snapshot.data[index].status ==
                                          "Under process") {
                                        Provider.of<HttpRequests>(context,listen: false)
                                            .deleteOrder(
                                                snapshot.data[index], context);
                                      } else if (snapshot.data[index].status ==
                                          "Dispatched") {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Order is dispatched, can't be canceled")));
                                      } else {
                                        Provider.of<HttpRequests>(context,listen: false).deleteOrder(
                                            snapshot.data[index], context);
                                      }
                                    });
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.lightGreen,
                                        ),
                                      ),
                                      Text(
                                        "Delete",
                                        style: TextStyle(
                                            color: Colors.lightGreen,
                                            fontFamily: "Times New Roman",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                            context: context,
                          )
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Date : $formattedDate",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: "Times New Roman",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      Text(
                                        "Time : $formattedTime",
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: "Times New Roman",
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          style: new TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black,
                                          ),
                                          children: <TextSpan>[
                                            new TextSpan(
                                              text: "Status : ",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontFamily: "Times New Roman",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            TextSpan(
                                              text: snapshot.data[index].status,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "Times New Roman",
                                                  fontSize: 16,
                                                  color: _isDelivered
                                                      ? Colors.red
                                                      : Colors.green),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "Rs : ${snapshot.data[index].totalPrice.toString()}",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontFamily: "Times New Roman",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      snapshot.data[index].cartItem.length,
                                  itemBuilder: (context, cartItemIndex) {
                                    var cartItem = snapshot
                                        .data[index].cartItem[cartItemIndex];
                                    return Column(
                                      children: [
                                        SizedBox(
                                          child: Container(
                                            color: Colors.grey[350],
                                            width: size.width,
                                            height: 3,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Container(
                                                width: size.width * 0.2,
                                                height: size.height * 0.1,
                                                child: CachedNetworkImage(
                                                  imageUrl: cartItem.imgUrl,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0,
                                                          left: 8.0,
                                                          bottom: 6),
                                                  child: Text(
                                                    cartItem.name,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Times New Roman",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    "Quantity : ${cartItem.quantity} ${cartItem.price.split("/")[1]}",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Times New Roman",
                                                        color: Colors.grey[400],
                                                        fontSize: 12),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    "Rs : ${cartItem.price}",
                                                    style: TextStyle(
                                                        color: Colors.grey[400],
                                                        fontFamily:
                                                            "Times New Roman",
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                            index == snapshot.data.length - 1
                                ? Container()
                                : Divider(thickness: 8),
                          ],
                        ),
                      );
                    },
                  );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
