import 'package:easy_food_service/HttpUtilities/HttpRequests.dart';
import 'package:easy_food_service/LoginSystem/LoginRequest.dart';
import 'package:easy_food_service/Models/SignupUser.dart';
import 'package:easy_food_service/Models/User.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateUser extends StatefulWidget {
  _UpdateUserState createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  SignupUser user = SignupUser();
  TextFormField buildTextFormField(String name, BuildContext context) {
    return TextFormField(
      keyboardType: name == "Contact"
          ? TextInputType.numberWithOptions(decimal: false, signed: false)
          : TextInputType.text,
      onChanged: (val) {
        setState(() {
          if (name == "Firstname") {
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

  static const double verticalPadding = 15.0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.lightGreen),
        centerTitle: true,
        actions: [
          Container(
            width: 20,
          )
        ],
        title: Text(
          "Update Info",
          style: TextStyle(
            fontFamily: "Times New Roman",
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.lightGreen,
          ),
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: size.height * 0.65,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                    backgroundBlendMode: BlendMode.darken,
                    color: Colors.lightGreen,
                    borderRadius: BorderRadius.circular(60)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 25, bottom: verticalPadding),
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
                      padding:
                          const EdgeInsets.only(left: 25.0, right: 25, top: 15),
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
                            Provider.of<HttpRequests>(context, listen: false)
                                .updateUser(this.user, context);
                            User user = User(
                              username: LoginRequest.user.username,
                                firstname: this.user.firstname,
                                lastname: this.user.lastname,
                                contact: this.user.contact,
                                address: this.user.address);
                            LoginRequest.user = user;
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
        ],
      ),
    );
  }
}
