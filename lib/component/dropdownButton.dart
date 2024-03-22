import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  @override
  _CustomDropdownButtonnState createState() => _CustomDropdownButtonnState();
}

class _CustomDropdownButtonnState extends State<CustomDropdownButton> {
  String _selectedItem = 'Học kỳ 1';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.grey[50], borderRadius: BorderRadius.circular(8)),
      child: DropdownButton<String>(
        value: _selectedItem,
        onChanged: (String? newValue) {
          setState(() {
            _selectedItem = newValue!;
          });
        },
        items: <String>['Học kỳ 1', 'Học kỳ 2']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Dropdown Button Example'),
      ),
      body: Center(
        child: CustomDropdownButton(),
      ),
    ),
  ));
}
