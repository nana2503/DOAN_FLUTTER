import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final bool isPassword;
  final String hintText;
  final TextEditingController controller;
  final bool isReadOnly;

  const CustomTextField(
      {super.key,
      required this.isPassword,
      required this.hintText,
      required this.controller,
      required this.isReadOnly});

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: widget.isReadOnly ? true : false,
      controller: widget.controller,
      obscureText: widget.isPassword && _isObscure,
      decoration: InputDecoration(
          filled: widget.isReadOnly,
          fillColor: widget.isReadOnly ? Colors.grey[200] : Colors.white,
          contentPadding: const EdgeInsets.all(0),
          labelText: widget.hintText,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                )
              : null),
    );
  }
}
