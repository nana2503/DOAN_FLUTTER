import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final bool isPassword;
  final String hintText;
  final TextEditingController controller;
  final bool isReadOnly;

  const CustomTextField({
    Key? key,
    required this.isPassword,
    required this.hintText,
    required this.controller,
    required this.isReadOnly,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // Bo góc 10%
        border: Border.all(color: Colors.black), // Viền đen
      ),
      child: TextField(
        onChanged: (value) {
          setState(() {}); // Khi có sự thay đổi trong TextField, rebuild để cập nhật hiển thị
        },
        readOnly: widget.isReadOnly ? true : false,
        controller: widget.controller,
        obscureText: widget.isPassword && _isObscure,
        decoration: InputDecoration(
          filled: widget.isReadOnly,
          fillColor: widget.isReadOnly ? Colors.grey[200] : Colors.white,
          contentPadding: const EdgeInsets.all(10), // Lề nội dung
          border: OutlineInputBorder(
            borderSide: BorderSide.none, // Loại bỏ viền của TextField
            borderRadius: BorderRadius.circular(10), // Bo góc 10%
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: widget.controller.text.isEmpty ? Colors.grey : Colors.transparent, // Biến mất hint khi có ký tự
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
