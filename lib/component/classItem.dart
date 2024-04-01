import 'package:flutter/material.dart';

class ClassItem extends StatelessWidget {
  final String classId;
  final String className;
  final int totalStudent;
  final VoidCallback onPressed;

  const ClassItem({
    Key? key,
    required this.classId,
    required this.className,
    required this.totalStudent,
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
                'Class ID: $classId', // Hiển thị ID của lớp
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Class Name: $className', // Hiển thị tên của lớp
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Total Students: $totalStudent', // Hiển thị tổng số sinh viên
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
