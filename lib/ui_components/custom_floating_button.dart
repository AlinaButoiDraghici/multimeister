import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multimeister/ui_components/ui_specs.dart';

class CustomFloatingButton extends StatefulWidget {
  final VoidCallback onPressed;
  const CustomFloatingButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  State<CustomFloatingButton> createState() => _CustomFloatingButtonState();
}

class _CustomFloatingButtonState extends State<CustomFloatingButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: widget.onPressed,
      child: Icon(
        Icons.arrow_forward_ios,
      ),
      elevation: 0,
    );
  }
}
