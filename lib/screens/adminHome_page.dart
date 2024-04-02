import 'package:flutter/material.dart';
import 'package:flutter_doan/component/homeItem.dart';
import 'package:flutter_doan/screens/classList_page.dart';
import 'package:flutter_doan/screens/listUser_page.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
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
                        title: "Thông tin",
                        backgroundColor: Colors.redAccent,
                        onPress: () => {print('Nhấn nút thành công!!')}),
                    HomeItem(
                        title: "DSMH",
                        backgroundColor: Colors.blue,
                        onPress: () => {print('Nhấn nút thành công!!')}),
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
        ],
      ),
    );
  }
}
