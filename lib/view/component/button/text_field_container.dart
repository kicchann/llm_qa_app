// flutter
import 'package:flutter/material.dart';

// constants
import 'package:botob/constant/doubles.dart';

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer({Key? key, required this.width, required this.child})
      : super(key: key);
  final double width;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // marginとは余白のこと
        // symmetricとは対称
        // verticalとは上下
        margin: const EdgeInsets.all(normalMargin),
        width: width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(normalBorderRadius)),
        ),
        child: child,
      ),
    );
  }
}
