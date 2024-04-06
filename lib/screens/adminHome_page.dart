import 'package:flutter/material.dart';
import 'package:flutter_doan/component/button.dart';
import 'package:flutter_doan/component/homeItem.dart';
import 'package:flutter_doan/screens/Subject/subjectList_page.dart';
import 'package:flutter_doan/screens/action_page.dart';
import 'package:flutter_doan/screens/classList_page.dart';
import 'package:flutter_doan/screens/listUser_page.dart';
import 'package:flutter_doan/screens/projectInfo_page.dart';
import 'package:flutter_doan/utils/services.dart';
import 'package:flutter_doan/utils/tokenService.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
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
      body: Column(
        children: <Widget>[
          const SizedBox(height: 100),
          Text(
            "Quản Lý Sinh Viên",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: <Widget>[
                    HomeItem(
                        title: "DDSV",
                        backgroundColor: Colors.orange,
                        onPress: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ListUser()))
                            }),
                    HomeItem(
                        title: "Thông tin \n    đồ án",
                        backgroundColor: Colors.redAccent,
                        onPress: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProjectInfo()))
                            }),
                    HomeItem(
                        title: "DSMH",
                        backgroundColor: Colors.blue,
                        onPress: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SubjectList()))),
                    HomeItem(
                        title: "DS Lớp",
                        backgroundColor: Colors.green,
                        onPress: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ClassList()))
                            })
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          CustomButton(buttonText: "Đăng xuất", onPressed: () => handleLogout())
        ],
      ),
    );
  }
}
