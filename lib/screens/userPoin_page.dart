import 'package:flutter/material.dart';
import 'package:flutter_doan/component/button.dart';
import 'package:flutter_doan/component/dropdownButton.dart';
import 'package:flutter_doan/screens/addTablePoint.dart';
import 'package:flutter_doan/screens/updateSubject_page.dart';
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

  Future<void> refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _getTablePoint(_selectedSemester);
    });
  }

  @override
  Widget build(BuildContext context) {
    String _userId = widget.userId;
    return Scaffold(
      appBar: _role != 'admin'
          ? null
          : AppBar(
              title: Text("Điểm của sinh viên"),
            ),
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

            return RefreshIndicator(
                onRefresh: refreshData,
                child: Center(
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
                          scrollDirection: Axis.horizontal,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                            ),
                            child: DataTable(
                              columnSpacing:
                                  MediaQuery.of(context).size.width * 0,
                              columns: [
                                DataColumn(
                                  label: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    decoration: BoxDecoration(
                                      border: Border(
                                          right:
                                              BorderSide(color: Colors.black)),
                                    ),
                                    child: Center(child: Text('ID')),
                                  ),
                                ),
                                DataColumn(
                                  label: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              color: const Color.fromARGB(
                                                  255, 248, 204, 204))),
                                    ),
                                    child: Center(child: Text('Môn học')),
                                  ),
                                ),
                                DataColumn(
                                  label: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    decoration: BoxDecoration(
                                      border: Border(
                                          left:
                                              BorderSide(color: Colors.black)),
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
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                        decoration: BoxDecoration(
                                          border: Border(
                                              right: BorderSide(
                                                  color: Colors.black)),
                                        ),
                                        child: Text(
                                            point['subjectId'].toString() ??
                                                ''),
                                      ),
                                    ),
                                    DataCell(
                                      onTap: () {
                                        _role == 'admin'
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateSubjectAndPoint(
                                                          subjectId:
                                                              point['subjectId']
                                                                  .toString(),
                                                          subject: point[
                                                                  'subjectName']
                                                              .toString(),
                                                          point: point['point']
                                                              .toString(),
                                                          hocky:
                                                              _selectedSemester
                                                                  .toString(),
                                                        )))
                                            : null;
                                      },
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        decoration: BoxDecoration(
                                          border: Border(
                                              right: BorderSide(
                                                  color: Colors.black)),
                                        ),
                                        child: Center(
                                          child: Text(
                                              point['subjectName'].toString() ??
                                                  ''),
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      onTap: () {
                                        _role == 'admin'
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateSubjectAndPoint(
                                                          subjectId:
                                                              point['subjectId']
                                                                  .toString(),
                                                          subject: point[
                                                                  'subjectName']
                                                              .toString(),
                                                          point: point['point']
                                                              .toString(),
                                                          hocky:
                                                              _selectedSemester
                                                                  .toString(),
                                                        )))
                                            : null;
                                      },
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: Center(
                                            child: Text(
                                                point['point'].toString() ??
                                                    '')),
                                        decoration: BoxDecoration(
                                          border: Border(
                                              left: BorderSide(
                                                  color: Colors.black)),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          )),
                    ],
                  ),
                ));
          }
        },
      ),
      bottomNavigationBar: _role == 'admin'
          ? BottomAppBar(
              surfaceTintColor: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomButton(
                      buttonText: "Thêm điểm",
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddTablePointPage(
                                  userId: _userId, hocky: _selectedSemester))))
                ],
              ),
            )
          : null,
    );
  }
}
