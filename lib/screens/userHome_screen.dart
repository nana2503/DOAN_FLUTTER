import 'package:flutter/material.dart';
import 'package:flutter_doan/component/homeItem.dart';
import 'package:flutter_doan/screens/Subject/subjectList_page.dart';
import 'package:flutter_doan/screens/classList_page.dart';
import 'package:flutter_doan/screens/listUser_page.dart';
import 'package:flutter_doan/screens/userPoin_page.dart';
import 'package:flutter_doan/screens/user_page.dart';
import 'package:flutter_doan/utils/tokenService.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  String? _role;

  @override
  void initState() {
    super.initState();
    _getRole(); // Thay vì _getRoleAndUserId, chỉ cần lấy role
  }

  Future<void> _getRole() async {
    final tokenAndRole = await TokenService.getTokenAndRole();
    setState(() {
      _role = tokenAndRole['role'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text(
            "Xin chào",
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
                      title: "Thông tin SV",
                      backgroundColor: Colors.orange,
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserPage(),
                          ),
                        );
                      },
                    ),
                 
                      HomeItem(
                        title: "Bảng Điểm",
                        backgroundColor: Colors.redAccent,
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserPointPage(userId: _role!),
                            ),
                          );
                        },
                      ),
                    // Thêm các HomeItem khác tương tự ở đây nếu cần
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
