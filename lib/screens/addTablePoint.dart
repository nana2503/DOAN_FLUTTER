import 'package:flutter/material.dart';
import 'package:flutter_doan/component/dialog.dart';
import 'package:flutter_doan/component/textfield.dart';
import 'package:flutter_doan/model/user.dart';
import 'package:flutter_doan/utils/services.dart';

class AddTablePointPage extends StatefulWidget {
  final String userId;
  final String hocky;

  const AddTablePointPage({Key? key, required this.userId, required this.hocky}) : super(key: key);

  @override
  _AddTablePointPageState createState() => _AddTablePointPageState();
}

class _AddTablePointPageState extends State<AddTablePointPage> {
  // User user = User(
  //   userId: "",
  //   username: "",
  //   address: "",
  //   sex: "",
  //   phone: "",
  //   className: "",
  // );

  final TextEditingController _subjectId = TextEditingController();
  final TextEditingController _subjectName = TextEditingController();
  final TextEditingController _point = TextEditingController();
  // final TextEditingController _userId = TextEditingController();
  // final TextEditingController _hocky = TextEditingController();

  @override
  void initState() {
    super.initState();
   // _getUserById();
  }

  // Future<void> _getUserById() async {
  //   final response = await AppUtils.getUserByID(widget.userId);
  //   print("response['DT']");
  //    print(response['DT']);
  //   setState(() {
  //     user = User.fromJson(response['DT']);
  //     _usernameController.text = user.username;
  //     _userIdController.text = user.userId;
  //     _phoneController.text = user.phone;
  //     _addressController.text = user.address == null ? "": user.address;
  //     _sexController.text = user.sex == null ?"":user.sex;
  //     _classController.text = user.className == null ?"":user.className;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm điểm"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
           Text("ID",style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold)),
          CustomTextField(
            isReadOnly: false,
            isPassword: false,
            hintText: "Mã môn học",
            controller: _subjectId,
          ),
          const SizedBox(height: 10),
           Text("Tên môn học",style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold)),
          CustomTextField(
            isReadOnly: false,
            isPassword: false,
            hintText: "Tên môn học",
            controller: _subjectName,
          ),
          const SizedBox(height: 10),
           Text("Điểm",style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold)),
          CustomTextField(
            isReadOnly: false,
            isPassword: false,
            hintText: "Điểm",
            controller: _point,
          ),
          const SizedBox(height: 10),
          BottomAppBar(
           surfaceTintColor: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 232, 225, 225)),
                  onPressed: () async {
                    String subjectId = _subjectId.text.trim();
                    String subjectName = _subjectName.text.trim();
                    int point = int.parse(_point.text.trim());
                    if (subjectId.isEmpty ||
                        subjectName.isEmpty ||
                        point==0) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return CustomDialogAlert(
                            title: "Thông báo",
                            message: "Vui lòng nhập đầy đủ thông tin",
                            closeButtonText: "Đóng",
                            onPressed: () => Navigator.of(context).pop(),
                          );
                        },
                      );
                    } else {
                      try {
                        final response = await AppUtils.addTablePoint(
                            widget.userId,subjectId ,subjectName, point,widget.hocky);
                        print(response);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialogAlert(
                              title: "Thông báo",
                              message: response['EM'],
                              closeButtonText: "Đóng",
                              onPressed: () => Navigator.of(context).pop(),
                            );
                          },
                        );
                      } catch (e) {
                        print("Lỗi: $e");
                      }
                    }
                  },
                  child: Text('Cập nhật'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
