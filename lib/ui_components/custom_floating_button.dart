import 'package:flutter/material.dart';

class CustomFloatingButton extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String? heroTag;
  const CustomFloatingButton(
      {Key? key,
      required this.onPressed,
      this.icon = Icons.arrow_forward_ios,
      this.heroTag})
      : super(key: key);

  @override
  State<CustomFloatingButton> createState() => _CustomFloatingButtonState();
}

class _CustomFloatingButtonState extends State<CustomFloatingButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: widget.heroTag ?? "FAB",
      onPressed: widget.onPressed,
      child: Icon(widget.icon),
      elevation: 0,
    );
  }
}
