import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_food_service/CartScreen/CartDatabase.dart';
import 'package:easy_food_service/CartScreen/cartScreen.dart';
import 'package:easy_food_service/Drawer/drawer.dart';
import 'package:easy_food_service/HttpUtilities/HttpRequests.dart';
import 'package:easy_food_service/Models/User.dart';
import 'package:easy_food_service/LoginSystem/LoginRequest.dart';
import 'package:easy_food_service/LoginSystem/LoginScreen.dart';
import 'package:easy_food_service/Models/PriceModel.dart';
import 'package:easy_food_service/Models/ProductModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'CartScreen/placeHolder.dart';
import 'Models/Product.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> HttpRequests()),
        ChangeNotifierProvider(create: (_) => CartDatabase.getInstance()),
        ChangeNotifierProvider(create: (_) => PriceModel())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  static User user;
  static DateTime tokenExpirationDate;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Easy Food',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CartDatabase _cartDatabase = CartDatabase.getInstance();
  void addToCart(ProductModel model, BuildContext mycontext) {
    Product product = Product(
        name: model.name,
        price: model.price,
        quantity: 1,
        imgUrl: model.imgUrl);
    bool _available = false;
    for (Product p in _cartDatabase.getProducts()) {
      if (product.compere(p)) {
        _available = true;
        break;
      }
    }
    if (_available == false) {
      Provider.of<CartDatabase>(context, listen: false).addProduct(product);
      Provider.of<PriceModel>(context, listen: false).setPrice(context);
      SnackBar snackBar = SnackBar(
        content: Text("Food added to cart"),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(mycontext).showSnackBar(snackBar);
    } else {
      SnackBar snackBar = SnackBar(
        content: Text("Already available"),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(mycontext).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CartScreen()));
        },
        child: Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
      ),
      drawer: MyDrawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.lightGreen),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          GestureDetector(
            onTap: () {
              LoginRequest.user = null;
              LoginRequest.token = null;
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(
                  "Logout",
                  style: TextStyle(
                      color: Colors.lightGreen,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      fontFamily: "Times New Roman"),
                ),
              ),
            ),
          )
        ],
        title: Text(
          "Easy Food",
          style: TextStyle(
              fontFamily: "Times New Roman",
              color: Colors.lightGreen,
              fontSize: 22,
              fontWeight: FontWeight.w500),
        ),
        elevation: 0,
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: Provider.of<HttpRequests>(context).listProducts(),
        builder: (context, snapshot) => snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          child: CachedNetworkImage(
                            imageUrl: snapshot.data[index].imgUrl,
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.3,
                            placeholder: (context, string) {
                              return myPlaceHoler(context);
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10, top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data[index].name,
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontFamily: "Times New Roman",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    "Rs : ${snapshot.data[index].price}",
                                    style: TextStyle(
                                        fontFamily: "Times New Roman",
                                        color: Colors.black54,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    addToCart(snapshot.data[index], context);
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.lightGreen),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
                                    child: Text(
                                      "Add to cart",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        index == snapshot.data.length - 1
                            ? Container()
                            : Divider(thickness: 8),
                      ],
                    ),
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
