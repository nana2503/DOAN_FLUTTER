import 'package:flutter/material.dart';
import 'package:flutter_doan/component/dropdownButton.dart';
import 'package:flutter_doan/screens/addTablePoint.dart';
import 'package:flutter_doan/utils/services.dart';
import 'package:flutter_doan/utils/tokenService.dart';

class UserPointPage extends StatefulWidget {
  final String userId;

  const UserPointPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<UserPointPage> createState() => _UserPointPageState();
}

class _UserPointPageState extends State<UserPointPage> {
  Future<List<dynamic>>? _pointData;
  String? _role;
 String _selectedSemester = "Học kỳ 1";

  @override
  void initState() {
    super.initState();
    _getTablePoint(_selectedSemester);
  }

  Future<void> _getTablePoint(String semester) async {
    final tokenAndRole = await TokenService.getTokenAndRole();
    setState(() {
      _role = tokenAndRole['role'];
    });
    final data = await AppUtils.getTablePoint(widget.userId);
    setState(() {
      final semesterIndex = semester == 'Học kỳ 1' ? '1' : '2';
      _pointData = Future.value(data['points']
          .where((point) => point['hocky'] == semesterIndex)
          .toList());
    });
  }

  Future<void> _updateTablePoint(String subjectName, int point) async {
    try {
      final response = await AppUtils.updateTablePoint(subjectName, point);
      if (response['EC'] == 0) {
        // Cập nhật thành công, cập nhật lại dữ liệu trong widget
        _getTablePoint(_selectedSemester);
      } else {
        throw Exception(response['EM']);
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }

  @override
  Widget build(BuildContext context) { 
    String _userId = widget.userId;
    return Scaffold(
<<<<<<< Updated upstream
      appBar: AppBar(
        title: Text("Bảng điểm sinh viên"),
      ),
=======
      appBar: _role != 'admin'
          ? null
          : AppBar(
              title: Text("Điểm của sinh viên"),
            ),
>>>>>>> Stashed changes
      body: FutureBuilder<List<dynamic>>(
        future: _pointData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else {
            final List<dynamic>? points = snapshot.data as List<dynamic>?;

            if (points == null || points.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    CustomDropdownButton(
                      onChanged: (semester) {
                        setState(() {
                          _selectedSemester = semester;
                        });
                        _getTablePoint(semester);
                      },
                      selectedSemester: _selectedSemester,
                    ),
                    Text('Không có điểm'),
                  ],
                ),
              );
            }

            return Center(
              child: Column(
                children: [
                  CustomDropdownButton(
                    onChanged: (semester) {
                      setState(() {
                        _selectedSemester = semester;
                      });
                      _getTablePoint(semester);
                    },
                    selectedSemester: _selectedSemester,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        child: DataTable(
                          columnSpacing: MediaQuery.of(context).size.width * 0,
                          columns: [
                            DataColumn(
                              label: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(color: Colors.black)),
                                ),
                                child: Center(child: Text('Môn học')),
                              ),
                            ),
                            DataColumn(
                              label: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                  border: Border(
                                      left: BorderSide(color: Colors.black)),
                                ),
                                child: Center(child: Text('Điểm')),
                              ),
                            ),
                          ],
                          rows: points.map<DataRow>((point) {
                            return DataRow(
                              cells: [
                                DataCell(
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Center(
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        controller: TextEditingController(
                                            text: point['subjectName'] ?? ''),
                                        readOnly: _role !=
                                            'admin', // Chỉ cho phép chỉnh sửa khi là admin
                                        decoration: InputDecoration(
                                          border: InputBorder
                                              .none, // Xóa viền của TextField
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                          right:
                                              BorderSide(color: Colors.black)),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Center(
                                      child: TextField(
                                        textAlign: TextAlign.center,
<<<<<<< Updated upstream
                                        controller: TextEditingController(text: point['point'].toString()), 
                                        readOnly: _role != 'admin', // Chỉ cho phép chỉnh sửa khi là admin
=======
                                        controller: TextEditingController(
                                            text: point['point']?.toString() ??
                                                ''),
                                        readOnly: _role !=
                                            'admin', // Chỉ cho phép chỉnh sửa khi là admin
>>>>>>> Stashed changes
                                        decoration: InputDecoration(
                                          border: InputBorder
                                              .none, // Xóa viền của TextField
                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                          left:
                                              BorderSide(color: Colors.black)),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: _role == 'admin'
          ? BottomAppBar(
              surfaceTintColor: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
<<<<<<< Updated upstream
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    onPressed: () async {
                      // Lặp qua danh sách điểm để cập nhật từng điểm
                      for (var point in await _pointData!) {
                        _updateTablePoint(point['subjectName'], int.parse(point['point'] ?? '0'));
                      }
                    },
                    child: Text('Cập nhật'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                    onPressed: () {
                     Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                               AddTablePointPage(userId: _userId ,hocky: _selectedSemester)));
                    },
                    child: Text('Thêm'),
=======
                  Container(
                    width: 150,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        // Xử lý logic cập nhật điểm ở đây
                        setState(() {
                          // Thực hiện cập nhật điểm
                        });
                      },
                      child: Text('Cập nhật'),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        // Xử lý logic thêm mới điểm ở đây
                        setState(() {
                          // Thực hiện thêm mới điểm
                        });
                      },
                      child: Text('Thêm'),
                    ),
>>>>>>> Stashed changes
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
