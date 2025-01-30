import 'dart:convert';
import 'package:api_register_login/new_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService extends ChangeNotifier {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login(BuildContext context, String email, String password) async {
    try {
      Uri uri = Uri.parse("https://shareittofriends.com/demo/flutter/Login.php");
      var response = await http.post(uri,
          body: {
            'email': email,
            'password': password
          });
      if(response.statusCode == 200){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool("isLoggedIn", true);

        print("Login successfully ${response.body}");
        Navigator.push(context, MaterialPageRoute(builder: (context) => NewPage(),));
      } else {
        Fluttertoast.showToast(msg: "Login failed ${response.body}");
      }
    } catch (ex){
      print("Error $ex");
    }
    }

}
