import 'dart:convert';

import 'package:easy_food_service/Models/ForgotPasswordModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  ForgotPasswordModel user = ForgotPasswordModel();
  TextFormField buildTextFormField(String name, BuildContext context) {
    return TextFormField(
      keyboardType: name == "Contact"
          ? TextInputType.numberWithOptions(decimal: false, signed: false)
          : TextInputType.text,
      onChanged: (val) {
        setState(() {
          if (name == "Username") {
            user.username = val;
          } else if (name == "Contact") {
            if (val.startsWith("0")) {
              user.contact = val.replaceFirst(RegExp(r'0'), "92", 0);
            } else {
              user.contact = val;
            }
          } else {
            user.password = val;
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

  void updatePassword(ForgotPasswordModel user, BuildContext context) async {
    if (user.username.isNotEmpty &&
        user.password.isNotEmpty &&
        user.contact != null) {
      if (user.contact.length > 12 ||
          user.contact.length < 12 ||
          !user.contact.startsWith("92")) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Invalid Contact")));
      } else {
        Uri uri = Uri.http("localhost:8080", "/update");
        Map<String, dynamic> map = {
          "username": user.username,
          "password": user.password,
          "contact": user.contact,
        };
        var res = await http.post(
          uri,
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          },
          body: jsonEncode(map),
        );
        String message = jsonDecode(res.body)['message'];
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
        int status = jsonDecode(res.body)['status'];
        if (status == 200) {
          Navigator.pop(context);
        }
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("All fields required")));
    }
  }

  @override
  Widget build(BuildContext context) {
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
            "Reset Password",
            style: TextStyle(
              fontFamily: "Times New Roman",
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.70,
                decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 20),
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
                          horizontal: 25.0, vertical: 20),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                        ),
                        child: buildTextFormField("New Password", context),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
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
                            updatePassword(user, context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Text(
                              "Update",
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
            ],
          ),
        ));
  }
}
