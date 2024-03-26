import 'package:flutter/material.dart';
import 'package:flutter_doan/component/userItem.dart';
import 'package:flutter_doan/model/user.dart';
import 'package:flutter_doan/screens/userDetail_page.dart';
import 'package:flutter_doan/utils/services.dart';

class ListUser extends StatelessWidget {
  const ListUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: AppUtils.getListAllUser(),
      builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Đã xảy ra lỗi: ${snapshot.error}'));
        } else {
          if (snapshot.data!.containsKey('DT')) {
            if (snapshot.data!['DT'] is List) {
              final List<dynamic> userDataList = snapshot.data!['DT'];
              final List<User> userList =
                  userDataList.map((item) => User.fromJson(item)).toList();
              return ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  final User user = userList[index];
                  if (user.username == 'admin') {
                    return const SizedBox();
                  } else {
                    return UserItem(
                        user: user,
                        onPressedButton1: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UserDetail(userId: user.userId)))
                            },
                        onPressedButton2: () => {print('2')});
                  }
                },
              );
            } else {
              return Center(child: Text('Dữ liệu không hợp lệ'));
            }
          } else {
            return Center(child: Text('Không có dữ liệu người dùng'));
          }
        }
      },
    );
  }
}
