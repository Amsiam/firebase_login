import 'package:firebase_login/auth_service.dart';
import 'package:firebase_login/home.dart';
import 'package:firebase_login/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  bool isLoggedIn = await AuthService().isLoggedIn();
  runApp(MyApp(
    isLoggedIn: isLoggedIn,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, this.isLoggedIn}) : super(key: key);
  final isLoggedIn;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: !isLoggedIn ? Login() : Home(),
    );
  }
}
