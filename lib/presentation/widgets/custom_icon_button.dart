import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;
  final Color? iconColor;

  CustomIconButton(
      {required this.onPressed, required this.icon, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      icon: Icon(
        icon,
        color: iconColor,
      ),
      onPressed: onPressed,
    );
  }
}
