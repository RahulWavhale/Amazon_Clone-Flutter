import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void showSnackeBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}

void httpErrorHandling({
  required BuildContext context,
  required http.Response response,
  required VoidCallback onsucess,
}) {
  switch (response.statusCode) {
    case 200:
      onsucess();
      break;
    case 400:
      showSnackeBar(context, jsonDecode(response.body)['msg']);
      break;
    default:
      showSnackeBar(context, response.body);
  }
}
