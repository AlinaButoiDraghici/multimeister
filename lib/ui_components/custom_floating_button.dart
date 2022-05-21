import 'package:flutter/material.dart';

class CustomFloatingButton extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;
  const CustomFloatingButton(
      {Key? key, required this.onPressed, this.icon = Icons.arrow_forward_ios})
      : super(key: key);

  @override
  State<CustomFloatingButton> createState() => _CustomFloatingButtonState();
}

class _CustomFloatingButtonState extends State<CustomFloatingButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: widget.onPressed,
      child: Icon(widget.icon),
      elevation: 0,
    );
  }
}
