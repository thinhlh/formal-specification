import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;
  final Color? iconColor;
  final String? tooltip;

  CustomIconButton({
    required this.onPressed,
    required this.icon,
    this.iconColor,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
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
