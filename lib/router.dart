import 'package:amzon_clone/Views/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:amzon_clone/Views/Auth/authScreen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AuthScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const HomeScreen());

    default:
      return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))));
  }
}
