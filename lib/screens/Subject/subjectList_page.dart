import 'package:flutter/material.dart';
import 'package:flutter_doan/utils/services.dart';

class SubjectList extends StatefulWidget {
  const SubjectList({super.key});

  @override
  State<SubjectList> createState() => _SubjectListState();
}

class _SubjectListState extends State<SubjectList> {
  Future<Map<String, dynamic>> _subjectListFuture = AppUtils.getClassList();
  Future<void> refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _subjectListFuture;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
