import 'package:amzon_clone/Controller/Provider_Controllers/userProvider.dart';
import 'package:amzon_clone/Controller/authController.dart';
import 'package:amzon_clone/Views/Auth/authScreen.dart';
import 'package:amzon_clone/router.dart';
import 'package:flutter/material.dart';
import 'package:amzon_clone/Constant/global.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthController authController = AuthController();

  @override
  void initState() {
    authController.fetchUserData();
    // TODO: implement initState
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        onGenerateRoute: (settings) => generateRoute(settings),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.light(primary: Global.primaryColor),
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                const Center(child: Text("Hello Amazon")),
                Builder(builder: (context) {
                  return ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AuthScreen.routeName);
                      },
                      child: const Text("Click ME"));
                })
              ],
            )));
  }
}
