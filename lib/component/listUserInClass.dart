import 'package:flutter/material.dart';
import 'package:flutter_doan/component/dialog.dart';
import 'package:flutter_doan/component/userItem.dart';
import 'package:flutter_doan/model/user.dart';
import 'package:flutter_doan/screens/getUserNotInClass.dart';
import 'package:flutter_doan/screens/userDetail_page.dart';
import 'package:flutter_doan/screens/userPoin_page.dart';
import 'package:flutter_doan/utils/services.dart';

class ListUserInClass extends StatefulWidget {
  final List<User> listUser;
  const ListUserInClass({super.key, required this.listUser});

  @override
  State<ListUserInClass> createState() => _ListUserInClassState();
}

class _ListUserInClassState extends State<ListUserInClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Danh sách sinh viên trong lớp'),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: widget.listUser.length,
            itemBuilder: (context, index) {
              final user = widget.listUser[index];
              return UserItem(
                user: user,
                onPressedButton1: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserDetail(userId: user.userId),
                  ),
                ),
                onPressedButton2: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserPointPage(userId: user.userId),
                  ),
                ),
                onPressedButton3: () async =>
                    {_confirmDeleteUser(context, user)},
              );
            }),
             floatingActionButton: Container(
          width: 60,
          height: 60,
          child: FloatingActionButton.small(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ListUserNoClass())),
                // .then((value) => refreshData()),
            child: const Icon(Icons.add),
          ),
        ));
       
  }

  Future<bool> _confirmDeleteUser(BuildContext context, User user) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Xác nhận'),
          content: const Text('Bạn có muốn xóa người dùng này không?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Không'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Có'),
            ),
          ],
        );
      },
    );

    if (shouldDelete != null && shouldDelete) {
      try {
        final response = await AppUtils.deleteUser(user.userId);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogAlert(
                title: "Thông báo",
                message: response['EM'],
                closeButtonText: "Đóng",
                onPressed: () =>
                    {Navigator.of(context).pop(), Navigator.of(context).pop()});
          },
        );
        return true; // Trả về true nếu xóa thành công
      } catch (e) {
        print('Lỗi khi xóa người dùng: $e');
      }
    }
    return false; // Trả về false nếu không xóa hoặc xác nhận không
  }
}
