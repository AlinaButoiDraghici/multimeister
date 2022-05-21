import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String label;
  final IconData? icon;
  final bool isPassword;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  const CustomTextField(
      {Key? key,
      required this.label,
      this.icon,
      this.isPassword = false,
      this.onChanged,
      this.validator,
      this.controller})
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        obscureText: widget.isPassword,
        onChanged: widget.onChanged,
        validator: widget.validator,
        controller: widget.controller,
      ),
    );
  }
}
