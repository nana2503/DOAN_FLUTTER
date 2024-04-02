import 'package:flutter/material.dart';
import 'package:flutter_doan/model/class.dart';

class ClassItem extends StatelessWidget {
  final ClassInfo classInfoItem;
  final VoidCallback onPressed;

  const ClassItem({
    Key? key,
    required this.classInfoItem,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.blue, // Màu nền của container
            borderRadius: BorderRadius.circular(10.0), // Bo tròn góc
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ID Lớp Học: ${classInfoItem.id}', // Hiển thị ID của lớp
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Tên lớp: ${classInfoItem.className}', // Hiển thị tên của lớp
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Tổng số lượng sinh viên: ${classInfoItem.count}', // Hiển thị tổng số sinh viên
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
