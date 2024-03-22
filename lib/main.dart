import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_doan/component/button.dart';
import 'package:flutter_doan/screens/createUser_page.dart';
import 'package:flutter_doan/screens/login_screen.dart';
import 'package:flutter_doan/screens/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ĐỒ ÁN FLUTTER',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const AuthenticationPage(),
    );
  }
}

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
          child: Text(
            "Quản Lý Sinh Viên",
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
                buttonText: "Đăng nhập",
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                      //  MaterialPageRoute(builder: (context) => EditScreen()));
                }),
            SizedBox(height: 20),
            CustomButton(
                buttonText: "Đăng ký",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                }),
          ],
        ),
      ),
    ));
  }
}
