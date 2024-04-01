import 'package:flutter/material.dart';
import 'package:flutter_doan/component/userItem.dart';
import 'package:flutter_doan/utils/services.dart';

class ClassList extends StatefulWidget {
  const ClassList({super.key});

  @override
  State<ClassList> createState() => _ClassListState();
}

class _ClassListState extends State<ClassList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: FutureBuilder<Map<String, dynamic>>(
        //   future: AppUtils.getClassList(),
        //   builder: (context, snapshot) => {

        //   },
        // ),
        );
  }
}
