// flutter
import 'package:flutter/material.dart';

// constants
import 'package:botob/constant/doubles.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.child,
    required this.onPressed,
    required this.height,
    this.width,
    this.color,
  }) : super(key: key);
  final Widget child;
  final VoidCallback? onPressed;
  final double height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(normalBorderRadius),
              ),
            ),
          ),
          onPressed: onPressed,
          child: child),
    );
  }
}
