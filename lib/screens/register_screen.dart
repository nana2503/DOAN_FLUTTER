import 'package:flutter/material.dart';
import 'package:flutter_doan/component/button.dart';
import 'package:flutter_doan/component/dialog.dart';
import 'package:flutter_doan/component/textfield.dart';
import 'package:flutter_doan/screens/login_screen.dart';
import 'package:flutter_doan/utils/services.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đăng ký"),
      ),
      body: const Center(
        child: RegisterForm(),
      ),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _userPhoneNumberController =
      TextEditingController();
  void clearTextField() {
    _userNameController.text = "";
    _passwordController.text = "";
    _userPhoneNumberController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                isReadOnly: false,
                  isPassword: false,
                  hintText: "Họ và tên",
                  controller: _userNameController),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                     isReadOnly: false,
                  isPassword: false,
                  hintText: "Số điện thoại",
                  controller: _userPhoneNumberController),
              const SizedBox(height: 10),
              CustomTextField(
                     isReadOnly: false,
                  isPassword: true,
                  hintText: "Mật khẩu",
                  controller: _passwordController),
              const SizedBox(height: 10),
              CustomButton(
                  buttonText: "Đăng ký",
                  onPressed: () async {
                    String userName = _userNameController.text.trim();
                    String password = _passwordController.text.trim();
                    String userPhoneNumber =
                        _userPhoneNumberController.text.trim();
                    if (_userNameController.text.isEmpty ||
                        _userPhoneNumberController.text.isEmpty ||
                        _passwordController.text.isEmpty) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialogAlert(
                                title: "Thông báo",
                                message: "Vui lòng nhập đầy đủ thông tin",
                                closeButtonText: "Đóng",
                                onPressed: () => Navigator.of(context).pop());
                          });
                    } else {
                      try {
                        final response = await AppUtils.registerUser(
                            userName, userPhoneNumber, password);
                        clearTextField();
                        if (mounted) {
                          print(response['EM']);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialogAlert(
                                    title: "Thông báo",
                                    message: response['EM'],
                                    closeButtonText: "Đóng",
                                    onPressed: () => Navigator.pop(context));
                              });
                        }
                      } catch (e) {
                        print("Lỗi: $e");
                      }
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
