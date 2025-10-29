import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:amzon_clone/Controller/Provider_Controllers/userProvider.dart';
import 'package:amzon_clone/Views/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/userModel.dart';
import '../Constant/global.dart';
import '../utility/errorhandleing.dart';

class AuthController {
  Future<void> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    User user = User(
      id: "",
      name: name,
      email: email,
      password: password,
      address: "",
      type: "",
    );

    try {
      final uri =
          Uri.parse("$urilink/api/signup"); // Ensure $uri is correctly set
      final response = await http.post(
        uri,
        body: jsonEncode(user.fromApptoDb()), // Convert user to JSON
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(const Duration(seconds: 15), onTimeout: () {
        throw TimeoutException("Connection Timeout. Please try again later.");
      });

      // Handle the response
      if (response.statusCode == 201) {
        showSnackeBar(
          context,
          "User Created Successfully. Please Login With Same Credentials.",
        );
      } else {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        showSnackeBar(
          context,
          responseBody['msg'] ??
              "Unexpected error occurred. Please try again later.",
        );
      }
    } catch (e) {
      // Provide detailed error handling
      if (e is TimeoutException) {
        showSnackeBar(context, "Timeout error: ${e.message}");
      } else if (e is SocketException) {
        showSnackeBar(context, "Network error: ${e.message}");
      } else {
        showSnackeBar(context, "Error: $e");
      }
    }
  }

  Future<void> signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    // Define the URI for the API endpoint
    final uri = Uri.parse("$urilink/api/signin"); // Ensure the URL is correct

    try {
      // Perform the POST request to the API
      final response = await http.post(
        uri,
        body: jsonEncode({
          "email": email,
          "password": password
        }), // Encode the credentials as JSON
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(const Duration(seconds: 15), onTimeout: () {
        // Handle timeout exception
        throw TimeoutException("Connection Timeout. Please try again later.");
      });

      // Check the response status code
      if (response.statusCode == 200) {
        // Success case
        showSnackBar(context, "Welcome Back");

        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        Provider.of<UserProvider>(context, listen: false);

        print("STAMP VALUE IS HERE");
        print(jsonDecode(response.body)['token']);
        await sharedPreferences.setString(
            "stamp", jsonDecode(response.body)['token']);
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (route) => false);
      } else {
        // Handle non-success responses
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        showSnackBar(
          context,
          responseBody['msg'] ??
              "Unexpected error occurred. Please try again later.",
        );
      }
    } catch (e) {
      // Provide detailed error handling
      if (e is TimeoutException) {
        showSnackBar(context, "Timeout error: ${e.message}");
      } else if (e is SocketException) {
        showSnackBar(context, "Network error: ${e.message}");
      } else {
        showSnackBar(context, "Error: $e");
      }
    }
  }

// Utility function to display a Snackbar
  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }


  Future<void> fetchUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String ?token = sharedPreferences.getString('stamp');
    if (token == null) {
      sharedPreferences.setString("key", "");      
    }
    var stampRes = await http.post(Uri.parse("$urilink/validateStamp"),headers: <String,String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'token' : token!
    });
    var responce = jsonDecode(stampRes.body);

if (responce == true) {
  print("User Validate Successfully Fectching Details Now");
}
else{
  print("User Not Valid");
}
  }
}
