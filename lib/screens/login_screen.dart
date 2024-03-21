import 'package:flutter/material.dart';
import 'package:flutter_doan/component/button.dart';
import 'package:flutter_doan/component/textfield.dart';

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
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  void clearTextField() {
    _userNameController.text = "";
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
                  hintText: "User Name",
                  controller: _userNameController),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                  isPassword: true,
                  hintText: "Password",
                  controller: _passwordController),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                  buttonText: "Login",
                  onPressed: () {
                    String userName = _userNameController.text.trim();
                    String password = _passwordController.text.trim();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
