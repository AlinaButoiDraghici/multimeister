import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multimeister/ui_components/ui_specs.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final IconData? icon;
  const CustomTextField({Key? key, required this.label, this.icon = null})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      child: TextFormField(
        decoration: InputDecoration(
            suffixIcon: Icon(
              widget.icon,
              size: 24,
            ),
            labelText: widget.label,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
