import 'package:easy_food_service/Models/User.dart';
import 'package:easy_food_service/LoginSystem/LoginRequest.dart';
import 'package:easy_food_service/LoginSystem/ForgotPasswordScreen.dart';
import 'package:easy_food_service/LoginSystem/SIgnupScreen.dart';
import 'package:easy_food_service/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _username = "";
  String _password = "";
  bool _obSecure = true;
  Icon _icon = Icon(
    Icons.link,
    color: Colors.lightGreen,
  );

  TextFormField buildTextFormField(String name) {
    return TextFormField(
      obscureText: name == "Username" ? false : _obSecure,
      onChanged: (val) {
        setState(() {
          if (name == "Username") {
            _username = val;
          } else {
            _password = val;
          }
        });
      },
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        fontFamily: "Times New Roman",
      ),
      decoration: name == "Username"
          ? InputDecoration(
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
            )
          : InputDecoration(
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (_obSecure == true) {
                        _obSecure = false;
                        _icon = Icon(
                          Icons.link_off,
                          color: Colors.lightGreen,
                        );
                      } else {
                        _obSecure = true;
                        _icon = Icon(
                          Icons.link,
                          color: Colors.lightGreen,
                        );
                      }
                    });
                  },
                  child: _icon,
                ),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              hintText: "Password",
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: size.width,
              height: size.height * 0.75,
              decoration: BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(40))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      "Login",
                      style: GoogleFonts.pacifico(
                          color: Colors.white, fontSize: 70),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                      ),
                      child: buildTextFormField("Username"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(40),
                        ),
                      ),
                      child: buildTextFormField("Password"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                        onPressed: () async {
                          if (_username.isNotEmpty && _password.isNotEmpty) {
                            User user = await LoginRequest.loginRequest(
                                _username, _password);

                            if (user != null) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()));
                            } else {
                              SnackBar snackBar = SnackBar(
                                content: Text("Bad request try again"),
                                duration: Duration(seconds: 2),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          } else {
                            SnackBar snackBar = SnackBar(
                              content: Text("All fields required"),
                              duration: Duration(seconds: 2),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            "Login",
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen()));
                      },
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            fontFamily: "Times New Roman"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignupScreen()));
                },
                child: Text(
                  "SIGN UP",
                  style: TextStyle(
                      color: Colors.lightGreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      fontFamily: "Times New Roman"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
