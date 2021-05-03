import 'package:easy_food_service/LoginSystem/LoginRequest.dart';
import 'package:easy_food_service/LoginSystem/LoginScreen.dart';
import 'package:easy_food_service/OrderedFood/OrderedFoodScreen.dart';
import 'package:easy_food_service/UpdateUtilities/Update.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  void _logout() async {
    LoginRequest.user = null;
    LoginRequest.token = null;
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  GestureDetector listTile(String name, IconData icon) {
    return GestureDetector(
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        title: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            name,
            style: TextStyle(
                fontSize: 14,
                fontFamily: "LemonMilk",
                color: Colors.black54,
                fontWeight: FontWeight.bold),
          ),
        ),
        leading: Icon(icon),
      ),
      onTap: () => _myDrawerNavigation(name),
    );
  }

  void _myDrawerNavigation(String name) {
    if (name == "Your Orders") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderedFoodScreen(),
        ),
      );
    } else if (name == "Logout") {
      _logout();
    } else if (name == "Update Details") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UpdateUser()),
      );
    } else if (name == "Trace Order") {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Padding(
            padding: const EdgeInsets.only(left: 6.0),
            child: Text(
              "Under developement",
              style: TextStyle(fontFamily: "Calibri"),
            ),
          ),
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right:6.0),
                child: Icon(Icons.info_outline),
              ),

              Text(
                "Info",
                style: TextStyle(fontFamily: "Calibri"),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Ok"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              child: Text(
                LoginRequest.user.firstname[0].toString(),
                style: TextStyle(
                    color: Colors.lightGreen,
                    fontFamily: "Times New Roman",
                    fontSize: 40,
                    fontWeight: FontWeight.w500),
              ),
            ),
            accountName: Text(
              LoginRequest.user.firstname + " " + LoginRequest.user.lastname,
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "BeautyMountain",
                  color: Colors.white),
            ),
            accountEmail: null,
            decoration: BoxDecoration(color: Colors.lightGreen),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              listTile("Your Orders", Icons.food_bank),
              listTile("Trace Order", Icons.track_changes),
              listTile("Update Details", Icons.update),
              listTile("Version (0.0.1)", Icons.info_outline),
              Divider(),
              listTile("Logout", Icons.logout),
            ],
          ),
        ],
      ),
    );
  }
}
