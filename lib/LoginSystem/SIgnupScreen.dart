import 'dart:convert';

import 'package:easy_food_service/Models/SignupUser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  SignupUser user = SignupUser();
  TextFormField buildTextFormField(String name, BuildContext context) {
    return TextFormField(
      keyboardType: name == "Contact"
          ? TextInputType.numberWithOptions(decimal: false, signed: false)
          : TextInputType.text,
      onChanged: (val) {
        setState(() {
          if (name == "Username") {
            user.username = val;
          } else if (name == "Password") {
            user.password = val;
          } else if (name == "Firstname") {
            user.firstname = val;
          } else if (name == "Lastname") {
            user.lastname = val;
          } else if (name == "Contact") {
            if (val.startsWith("0")) {
              user.contact = val.replaceFirst(RegExp(r'0'), "92", 0);
            } else {
              user.contact = val;
            }
          } else if (name == "Address") {
            user.address = val;
          }
        });
      },
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        fontFamily: "Times New Roman",
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15),
        hintText: name,
        hintStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          fontFamily: "Times New Roman",
          color: Colors.black38,
        ),
        fillColor: Colors.white,
        focusColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
        ),
      ),
    );
  }

  void signUp(SignupUser user, BuildContext context) async {
    if (user.firstname != null &&
        user.lastname != null &&
        user.address != null &&
        user.contact != null &&
        user.username != null &&
        user.password != null) {
      if (user.contact.length > 12 ||
          user.contact.length < 12 ||
          !user.contact.startsWith("92")) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Invalid Contact")));
      } else {
        Uri uri = Uri.http("localhost:8080", "/signup");
        Map<String, dynamic> map = {
          "username": user.username,
          "password": user.password,
          "firstname": user.firstname,
          "lastname": user.lastname,
          "contact": user.contact,
          "address": user.address,
        };
        var res = await http.post(
          uri,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: jsonEncode(map),
        );

        String message = jsonDecode(res.body)["message"];
        SnackBar snackBar = SnackBar(content: Text(message));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        int status = jsonDecode(res.body)['status'];
        if (status == 200) {
          Navigator.pop(context);
        }
      }
    } else {
      SnackBar snackBar = SnackBar(content: Text("All fields required"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  static const double verticalPadding = 15.0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        actions: [
          Container(
            width: 20,
          )
        ],
        title: Text(
          "SIGN UP",
          style: TextStyle(
            fontFamily: "Times New Roman",
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          decoration: BoxDecoration(
            color: Colors.lightGreen,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0, vertical: verticalPadding),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                  child: buildTextFormField("Username", context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0, vertical: verticalPadding),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                  child: buildTextFormField("Password", context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0, vertical: verticalPadding),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                  child: buildTextFormField("Firstname", context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0, vertical: verticalPadding),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                  child: buildTextFormField("Lastname", context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0, vertical: verticalPadding),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                  child: buildTextFormField("Address", context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25, vertical: verticalPadding),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                  child: buildTextFormField("Contact", context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25.0,right: 25, top: 15,bottom: 40),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.lightGreen,
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width, 4)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(40)),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.white),
                    ),
                    onPressed: () {
                      signUp(this.user, context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Times New Roman",
                            color: Colors.lightGreen),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
