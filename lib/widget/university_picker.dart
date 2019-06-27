import "package:flutter/material.dart";
import 'package:flutter/cupertino.dart';

class UniversityPicker extends StatelessWidget {
  final List<String> universityNames;
  final void Function(String) onSelectedUniversityChanged;

  UniversityPicker({this.universityNames, this.onSelectedUniversityChanged});

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker.builder(
      itemBuilder: (context, row) => _buildPickerItem(universityNames[row]),
      childCount: universityNames.length,
      onSelectedItemChanged: (row) {
        onSelectedUniversityChanged(universityNames[row]);
      },
      itemExtent: 44,
      backgroundColor: Colors.transparent,
      useMagnifier: true,
      magnification: 1.5,
    );
  }

  Widget _buildPickerItem(String universityName) {
    return Center(
      child: Text(
        universityName,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
    );
  }
}
