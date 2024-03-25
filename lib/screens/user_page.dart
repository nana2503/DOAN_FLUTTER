import 'package:flutter/material.dart';
import 'package:flutter_doan/component/dialog.dart';
import 'package:flutter_doan/component/textfield.dart';
import 'package:flutter_doan/utils/services.dart';
import 'package:flutter_doan/utils/tokenService.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late Future<Map<String, dynamic>> _userData;
  late String _role;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    final tokenAndRole = await TokenService.getTokenAndRole();
    _role = tokenAndRole['role'] ?? ''; // Lấy giá trị role từ TokenService
    setState(() {
      _userData = AppUtils.fetchUser();
      print(_userData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _userData == null
          ? Center(child: CircularProgressIndicator())
          : FutureBuilder<Map<String, dynamic>>(
              future: _userData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Lỗi: ${snapshot.error}'));
                } else {
                  final userData = snapshot.data;
                  if (userData == null) {
                    return Center(child: Text('Không có dữ liệu'));
                  }

                  final List<dynamic>? userList = userData['DT'];
                  if (userList == null || userList.isEmpty) {
                    return Center(child: Text('Không có người dùng'));
                  }

                  final List<dynamic> filteredUsers =
                      userList.where((user) => user['username'] == _role).toList();

                  if (filteredUsers.isEmpty) {
                    return Center(child: Text('Không tìm thấy người dùng có username giống với role'));
                  }

                  // Gán dữ liệu từ filteredUsers vào các controller
                 final user = filteredUsers.first;
                        _usernameController.text = user['username'];
                        _userIdController.text = user['userId'];
                        _phoneController.text = user['phone'];
                        _addressController.text = user['address'] ?? '';
                        _sexController.text = user['sex'] ?? '';
                        _classController.text = user['Class']['className']?? '';
                    // print(user);
                  return ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      Container(
                        child: Center(
                          child: 
                          Text("Thông tin sinh viên",
                          style: TextStyle( fontSize: 20, color: Colors.blue, fontWeight: FontWeight.bold),
                          )
                        ),
                      ),
                       CustomTextField(
                        isReadOnly: true,
                        isPassword: false,
                        hintText: "MSSV",
                        controller: _userIdController),
                    const SizedBox(
                      height: 10,
                    ),
                           CustomTextField(
                        isReadOnly: false,
                        isPassword: false,
                        hintText: "Họ và tên",
                        controller: _usernameController),
                    const SizedBox(
                      height: 10,
                    ),
                            CustomTextField(
                        isReadOnly: true,
                        isPassword: false,
                        hintText: "SĐT",
                        controller: _phoneController),
                    const SizedBox(
                      height: 10,
                    ),
                           CustomTextField(
                        isReadOnly: false,
                        isPassword: false,
                        hintText: "Địa chỉ",
                        controller: _addressController),
                    const SizedBox(
                      height: 10,
                    ),
                           CustomTextField(
                        isReadOnly: false,
                        isPassword: false,
                        hintText: "Giới tính",
                        controller: _sexController),
                    const SizedBox(
                      height: 10,
                    ),
                            CustomTextField(
                        isReadOnly: false,
                        isPassword: false,
                        hintText: "Lớp",
                        controller: _classController),
                    const SizedBox(
                      height: 10,
                    ),
                    BottomAppBar(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                            String userId = _userIdController.text.trim();
                                String username = _usernameController.text.trim();
                                String address = _addressController.text.trim();
                                String gender = _sexController.text.trim();
                                String className = _classController.text.trim();
                              if (username.isEmpty || 
                                  address.isEmpty ||
                                  gender.isEmpty ||
                                  className.isEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDialogAlert(
                                      title: "Thông báo",
                                      message: "Vui lòng nhập đầy đủ thông tin",
                                      closeButtonText: "Đóng",
                                      onPressed: () => Navigator.of(context).pop(),
                                    );
                                  },
                                );
                              } else {
                                try {
                                    print(className);
                                  final response = await AppUtils.HandleUpdate(
                                    userId, username, address, gender, className);
                                  print(response);
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return CustomDialogAlert(
                                        title: "Thông báo",
                                        message: response['EM'],
                                        closeButtonText: "Đóng",
                                        onPressed: () => Navigator.of(context).pop(),
                                      );
                                    },
                                  );
                                } catch (e) {
                                  print("Lỗi: $e");
                                }
                              }
                            },
                            child: Text('Cập nhật'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Xử lý sự kiện khi nhấn nút "Thoát"
                            },
                            child: Text('Thoát'),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
              }
            ),
    );
  }
}
