import 'dart:convert';
import 'package:easy_food_service/Models/User.dart';
import 'package:http/http.dart' as http;

class LoginRequest {
  static String token;
  static User user;

  static Future<User> loginRequest(String username, String password) async {
    var response = await http.post(Uri.http('localhost:8080', '/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{"username": username, "password": password}));
    if (response.statusCode == 200) {
      token = 'Barrier ${jsonDecode(response.body)['entity']}';
      return getUser();
    } else {
      token = null;
      user = null;
      return null;
    }
  }

  static Future<User> getUser() async {
    var res = await http.get(Uri.http('localhost:8080', '/user/getUser'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token
        });
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      User user = User.formFactory(data);

      LoginRequest.user = user;
      return user;
    } else {
      user = null;
      return null;
    }
  }
}
