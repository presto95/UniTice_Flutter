import "package:flutter/material.dart";
import 'package:flutter/cupertino.dart';

class UniversityPicker extends StatefulWidget {
  final List<String> universityNames;
  final void Function(String) onSelectedUniversityChanged;

  UniversityPicker({this.universityNames, this.onSelectedUniversityChanged});

  @override
  State<StatefulWidget> createState() => _UniversityPickerState();
}

class _UniversityPickerState extends State<UniversityPicker> {
  String _selectedUniversity;

  String get selectedUniversity => _selectedUniversity;

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker.builder(
      itemBuilder: (context, row) =>
          _buildPickerItem(widget.universityNames[row]),
      childCount: widget.universityNames.length,
      onSelectedItemChanged: (row) {
        widget.onSelectedUniversityChanged(widget.universityNames[row]);
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
