import 'package:flutter/material.dart';
import 'package:flutter_doan/component/button.dart';
import 'package:flutter_doan/component/dialog.dart';
import 'package:flutter_doan/component/textfield.dart';
import 'package:flutter_doan/utils/services.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Đăng nhập"),
        ),
        body: LoginForm());
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _userPhoneNumberController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void clearTextField() {
    _userPhoneNumberController.text = "";
    _passwordController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomTextField(
                  isPassword: false,
                  hintText: "Số điện thoại",
                  controller: _userPhoneNumberController),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  isPassword: true,
                  hintText: "Mật Khẩu",
                  controller: _passwordController),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                  buttonText: "Đăng nhập",
                  onPressed: () async {
                    String phoneNumber = _userPhoneNumberController.text.trim();
                    String password = _passwordController.text.trim();
                    if (phoneNumber.isEmpty || password.isEmpty) {
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
                        final response =
                            await AppUtils.hanldeLogin(phoneNumber, password);
                        clearTextField();
                        print(response);
                        if (mounted) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialogAlert(
                                    title: "Thông báo",
                                    message: response['EM'],
                                    closeButtonText: "Đóng",
                                    onPressed: () =>
                                        Navigator.of(context).pop());
                              });
                        }
                      } catch (e) {
                        print("Lỗi: $e");
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
