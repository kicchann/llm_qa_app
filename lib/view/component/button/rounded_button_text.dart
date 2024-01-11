// flutter
import 'package:flutter/material.dart';
import 'package:botob/constant/doubles.dart';

// details
import 'package:botob/view/component/button/rounded_button.dart';

class RoundedButtonText extends StatelessWidget {
  const RoundedButtonText({
    Key? key,
    required this.text,
    required this.onPressed,
    this.height = 50.0,
    this.width,
    this.color,
  }) : super(key: key);
  final String text;
  final VoidCallback? onPressed;
  final double height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(normalMargin),
      child: RoundedButton(
        onPressed: onPressed,
        width: width,
        height: height,
        color: color,
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.white,
              ),
          // const TextStyle(fontSize: normalFontSize),
        ),
      ),
    );
  }
}
