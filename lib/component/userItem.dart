import 'package:flutter/material.dart';
import 'package:flutter_doan/model/user.dart';

class UserItem extends StatelessWidget {
  final User user;
  final void Function() onPressedButton1;
  final void Function() onPressedButton2;

  UserItem({
    required this.user,
    required this.onPressedButton1,
    required this.onPressedButton2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
                border: Border.symmetric(
                    horizontal: BorderSide(width: 1, color: Colors.black),
                    vertical: BorderSide(width: 1, color: Colors.black)),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Ô lớn chứa thông tin
                Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    user.toString(),
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: onPressedButton1,
                      child: Text('Thông tin sinh viên'),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                    ),
                    ElevatedButton(
                      onPressed: onPressedButton2,
                      child: Text('Điểm số của sinh viên'),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}