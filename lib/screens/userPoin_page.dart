import 'package:flutter/material.dart';
import 'package:flutter_doan/component/dropdownButton.dart';
import 'package:flutter_doan/utils/services.dart';
import 'package:flutter_doan/utils/tokenService.dart'; 

class UserPointPage extends StatefulWidget {
  const UserPointPage({Key? key});

  @override
  State<UserPointPage> createState() => _UserPointPageState();
}

class _UserPointPageState extends State<UserPointPage> {
  Future<List<dynamic>>? _pointData;
  String? _role;
  String _selectedSemester="Học kỳ 1"; // Thêm biến lưu giữ giá trị của học kỳ được chọn

  @override
  void initState() {
    super.initState();
    _getTablePoint(_selectedSemester!); // Truyền giá trị ban đầu của học kỳ
  }

Future<void> _getTablePoint(String semester) async {
  final tokenAndRole = await TokenService.getTokenAndRole();
  _role = tokenAndRole['role'] ?? '';
  final data = await AppUtils.getTablePoint(_role!);
  setState(() { 
 
    final semesterIndex = semester == 'Học kỳ 1' ? '1' : '2';
    _pointData = Future.value(data['points']
      .where((point) => point['hocky'] == semesterIndex) // Lọc danh sách points theo học kỳ được chọn
      .toList()
    );
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: _pointData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else {
            final points = snapshot.data;
            // print("points");
            // print(points);
            if (points == null || points.isEmpty) {
              return Center(child: 
              Column(children: [
                CustomDropdownButton(
  onChanged: (semester) {
    setState(() {
      _selectedSemester = semester;
    });
    _getTablePoint(semester); // Gọi lại hàm để lấy dữ liệu mới dựa trên học kỳ mới được chọn
  },
  selectedSemester: _selectedSemester, // Truyền giá trị _selectedSemester vào CustomDropdownButton
),

                  Text('Không có điểm')
              ],),);
             
            }
            return Center(
              child: Column(
                children: [
                 CustomDropdownButton(
  onChanged: (semester) {
    setState(() {
      _selectedSemester = semester;
    });
    _getTablePoint(semester); // Gọi lại hàm để lấy dữ liệu mới dựa trên học kỳ mới được chọn
  },
  selectedSemester: _selectedSemester, // Truyền giá trị _selectedSemester vào CustomDropdownButton
),

                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black), // Viền cho bảng
                        ),
                        child: DataTable(
                          columnSpacing: MediaQuery.of(context).size.width * 0, // 10% lề giữa cột
                          columns: [
                            DataColumn(
                              label: Container(
                                width: MediaQuery.of(context).size.width * 0.5, // 50% chiều rộng cột
                                decoration: BoxDecoration(
                                  border: Border(right: BorderSide(color: Colors.black))), // Viền đen bên phải cho DataColumn đầu tiên
                                child: Center(child: Text('Môn học')),
                              ),
                            ),
                            DataColumn(
                              label: Container(
                                width: MediaQuery.of(context).size.width * 0.3, // 30% chiều rộng cột
                                decoration: BoxDecoration(
                                  border: Border(left: BorderSide(color: Colors.black))), // Viền đen bên phải cho DataColumn thứ hai
                                child: Center(child: Text('Điểm')),
                              ),
                            ),
                          ],
                          rows: points.map((point) {
                            return DataRow(
                              cells: [
                                DataCell(
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.5, // 50% chiều rộng cột
                                    child: Center(child: Text(point['subjectName'] ?? '')),
                                    decoration: BoxDecoration(
                                      border: Border(right: BorderSide(color: Colors.black)) // Viền cho bảng
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.3, // 30% chiều rộng cột
                                    child: Center(child: Text(point['point']?.toString() ?? '')),
                                    decoration: BoxDecoration(
                                      border: Border(left: BorderSide(color: Colors.black)) // Viền cho bảng
                                    ),
                                  ),
                                ),
                              ],
                              // Thêm viền cho mỗi DataRow
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
    );
  }
}
