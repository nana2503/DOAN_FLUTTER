import 'package:flutter/material.dart';

class UserDetail extends StatefulWidget {
  final String userId;
  const UserDetail({super.key, required this.userId});

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
