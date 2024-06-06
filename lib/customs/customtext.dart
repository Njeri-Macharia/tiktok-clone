import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String label;
  final double? fontsize;
  final FontWeight? fontWeight;
  const CustomText(
      {super.key, required this.label, this.fontsize, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(fontSize: fontsize, fontWeight: fontWeight),
    );
  }
}
