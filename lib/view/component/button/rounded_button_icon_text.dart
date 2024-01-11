// flutter
import 'package:flutter/material.dart';

// details
import 'package:botob/view/component/button/rounded_button.dart';

class RoundedButtonIconText extends StatelessWidget {
  const RoundedButtonIconText({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
    required this.width,
    this.height = 50.0,
    this.color,
  }) : super(key: key);
  final IconData icon;
  final String text;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return RoundedButton(
      onPressed: onPressed,
      width: width,
      height: height,
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(icon),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }
}
