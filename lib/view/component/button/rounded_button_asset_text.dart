// flutter
import 'package:flutter/material.dart';

// details
import 'package:botob/view/component/button/rounded_button.dart';

class RoundedButtonAssetText extends StatelessWidget {
  const RoundedButtonAssetText({
    Key? key,
    required this.assetName,
    required this.text,
    required this.onPressed,
    required this.width,
    this.height = 50.0,
    this.color,
  }) : super(key: key);
  final String assetName;
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(assetName),
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
            ),
          ),
          Opacity(
            opacity: 0.0,
            child: Image.asset(assetName),
          ),
        ],
      ),
    );
  }
}
