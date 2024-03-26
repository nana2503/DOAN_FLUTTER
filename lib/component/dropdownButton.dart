import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  final Function(String) onChanged;
  final String selectedSemester; // Thêm thuộc tính selectedSemester

  CustomDropdownButton({required this.onChanged, required this.selectedSemester});

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String _selectedItem ='Học kỳ 1';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.grey[50], borderRadius: BorderRadius.circular(8)),
      child: DropdownButton<String>(
        value: widget.selectedSemester, // Sử dụng giá trị selectedSemester từ prop
        onChanged: (String? newValue) {
          setState(() {
            _selectedItem = newValue!;
            widget.onChanged(newValue!); 
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
