// flutter
import 'package:flutter/material.dart';

// constant
import 'package:botob/constant/doubles.dart';

// view
import 'package:botob/view/component/button/text_field_container.dart';

class RoundedTextField extends StatelessWidget {
  const RoundedTextField({
    Key? key,
    required this.keyboardType,
    required this.onChanged,
    required this.controller,
    required this.labelText,
    required this.width,
    this.maxLines = 1,
    this.maxLength,
  }) : super(key: key);
  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final String labelText;
  final double width;
  final int? maxLength; // nullなら制限なし
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      width: width,
      child: TextFormField(
        keyboardType: keyboardType,
        onChanged: onChanged,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(normalBorderRadius)),
          ),
          labelText: labelText,
        ),
        controller: controller,
        maxLength: maxLength,
        maxLines: maxLines,
      ),
    );
  }
}
