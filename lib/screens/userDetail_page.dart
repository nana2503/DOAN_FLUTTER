import 'package:flutter/material.dart';
import 'package:flutter_doan/component/dialog.dart';
import 'package:flutter_doan/component/textfield.dart';
import 'package:flutter_doan/model/user.dart';
import 'package:flutter_doan/utils/services.dart';

class UserDetail extends StatefulWidget {
  final String userId;

  const UserDetail({Key? key, required this.userId}) : super(key: key);

  @override
  _UserDetailState createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  User user = User(
    userId: "",
    username: "",
    address: "",
    sex: "",
    phone: "",
    className: "",
  );

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _classController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getUserById();
  }

  Future<void> _getUserById() async {
    final response = await AppUtils.getUserByID(widget.userId);
    setState(() {
      user = User.fromJson(response['DT']);
      _usernameController.text = user.username;
      _userIdController.text = user.userId;
      _phoneController.text = user.phone;
      _addressController.text = user.address ?? '';
      _sexController.text = user.sex ?? '';
      _classController.text = user.className ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin của sinh viên"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          CustomTextField(
            isReadOnly: true,
            isPassword: false,
            hintText: "MSSV",
            controller: _userIdController,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            isReadOnly: false,
            isPassword: false,
            hintText: "Họ và tên",
            controller: _usernameController,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            isReadOnly: true,
            isPassword: false,
            hintText: "SĐT",
            controller: _phoneController,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            isReadOnly: false,
            isPassword: false,
            hintText: "Địa chỉ",
            controller: _addressController,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            isReadOnly: false,
            isPassword: false,
            hintText: "Giới tính",
            controller: _sexController,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            isReadOnly: false,
            isPassword: false,
            hintText: "Lớp",
            controller: _classController,
          ),
          const SizedBox(height: 10),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
