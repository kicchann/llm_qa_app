// flutter
import 'package:flutter/material.dart';

class CircleIcon extends StatelessWidget {
  const CircleIcon({
    Key? key,
    required this.size,
    required this.icon,
    required this.iconSize,
    this.fillColor = Colors.white,
    this.borderColor = Colors.black,
    this.iconColor = Colors.black,
  }) : super(key: key);

  final double size;
  final IconData icon;
  final double iconSize;
  final Color fillColor;
  final Color borderColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: fillColor,
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: iconSize,
        color: iconColor,
      ),
    );
  }
}
