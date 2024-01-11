// flutter
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class ContinuousText extends StatelessWidget {
  const ContinuousText({
    Key? key,
    required this.text,
    required this.suffix,
    required this.textStyle,
    this.textAlign = TextAlign.center,
  }) : super(key: key);
  final String text;
  final String suffix;
  final TextStyle? textStyle; // nullなら制限なし
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text, style: textStyle),
        AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              suffix,
              textStyle: textStyle,
              textAlign: textAlign,
              speed: const Duration(milliseconds: 200),
            ),
          ],
          repeatForever: true,
        ),
      ],
    );
  }
}
