import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: <Widget>[
        Chip(
          label: const Text("Ngọc Na"),
          avatar: CircleAvatar(
            backgroundColor: Colors.blue.shade900,
            child: const Text("NN"),
          ),
        ),
        Chip(
          avatar: CircleAvatar(
              backgroundColor: Colors.blue.shade900, child: const Text('AH')),
          label: const Text('Hamilton'),
        ),
        Chip(
          avatar: CircleAvatar(
              backgroundColor: Colors.blue.shade900, child: const Text('ML')),
          label: const Text('Lafayette'),
        ),
        Chip(
          avatar: CircleAvatar(
              backgroundColor: Colors.blue.shade900, child: const Text('HM')),
          label: const Text('Mulligan'),
        ),
        Chip(
          avatar: CircleAvatar(
              backgroundColor: Colors.blue.shade900, child: const Text('JL')),
          label: const Text('Laurens'),
        ),
      ],
    ));
  }
}
