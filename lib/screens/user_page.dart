import 'package:flutter/material.dart';
import 'package:flutter_doan/component/button.dart';

import 'package:flutter_doan/screens/action_page.dart';
import 'package:flutter_doan/utils/services.dart';
import 'package:flutter_doan/utils/tokenService.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  void handleLogout() {
    try {
      final response = AppUtils.handleLogout();
      if (response.toString().isNotEmpty) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ActionPage()));
        TokenService.deleteToken();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomButton(buttonText: "Đăng xuất", onPressed: handleLogout),
    );
  }
}
