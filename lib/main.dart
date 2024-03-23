import 'package:flutter/material.dart';
import 'package:flutter_doan/component/button.dart';
import 'package:flutter_doan/screens/action_page.dart';
import 'package:flutter_doan/screens/admin_page.dart';
import 'package:flutter_doan/screens/login_screen.dart';
import 'package:flutter_doan/screens/register_screen.dart';
import 'package:flutter_doan/utils/tokenService.dart';

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
    return FutureBuilder(
        future: TokenService.getToken(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            if (snapshot.hasData && snapshot.data != null) {
              return const AdminPage();
            } else {
              return const ActionPage();
            }
          }
        });
  }
}
