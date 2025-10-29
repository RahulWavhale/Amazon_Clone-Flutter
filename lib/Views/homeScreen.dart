import 'package:amzon_clone/Controller/Provider_Controllers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home-screen';
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome User To Amazon"),
      ),
      body: Column(
        children: [
          Text(user.name),
          Text(user.password),
          Text(user.email),
          Text(user.email),
          
        ],
      ),
    );
  }
}
