import 'package:flutter/material.dart';
import 'package:flutter_doan/screens/action_page.dart';
import 'package:flutter_doan/screens/adminHome_page.dart';
import 'package:flutter_doan/screens/listUser_page.dart';
import 'package:flutter_doan/utils/services.dart';
import 'package:flutter_doan/utils/tokenService.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _selectedIndex = 0;
  String appBarTitle = "Xin chào Admin";
  static const TextStyle optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  final List<Widget> _widgetOptions = <Widget>[
    const AdminHomePage(),
    const ListUser(),
    const Text(
      'Đăng xuất',
      style: optionStyle,
    ),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
    return Scaffold(
      appBar: AppBar(title: Text(appBarTitle)),
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const SizedBox(height: 50),
            ListTile(
                title: const Text("Trang chủ", style: optionStyle),
                selected: _selectedIndex == 0,
                onTap: () {
                  _onItemTapped(0);
                  Navigator.pop(context);
                  setState(() {
                    appBarTitle = "Trang chủ";
                  });
                }),
            ListTile(
                title:
                    const Text("Xem danh sách sinh viên", style: optionStyle),
                selected: _selectedIndex == 1,
                onTap: () {
                  _onItemTapped(1);
                  Navigator.pop(context);
                  setState(() {
                    appBarTitle = "Danh sách sinh viên";
                  });
                }),
            ListTile(
                title: const Text("Đăng xuất", style: optionStyle),
                selected: _selectedIndex == 2,
                onTap: () {
                  _onItemTapped(2);
                  handleLogout();
                })
          ],
        ),
      ),
    );
  }
}
