import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_doan/component/classItem.dart';
import 'package:flutter_doan/component/userItem.dart';
import 'package:flutter_doan/model/class.dart';
import 'package:flutter_doan/utils/services.dart';

class ClassList extends StatefulWidget {
  const ClassList({super.key});

  @override
  State<ClassList> createState() => _ClassListState();
}

class _ClassListState extends State<ClassList> {
  Future<Map<String, dynamic>> _classListFuture = AppUtils.getClassList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Danh sách lớp học"),
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: _classListFuture,
          builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text("Something went wrong ${snapshot.error}"));
            } else {
              final classListData = snapshot.data!['DT'] as List<dynamic>;
              // print(classListData);

              final classList = classListData
                  .map((item) => ClassInfo.fromJson(item))
                  .toList();
              return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: classList.length,
                  itemBuilder: (context, index) {
                    final classInfoItem = classList[index];
                    print(classInfoItem.id);
                    return ClassItem(
                        classInfoItem: classInfoItem,
                        onPressed: () {
                          print("Hello");
                        });
                  });
            }
          },
        ));
  }
}
