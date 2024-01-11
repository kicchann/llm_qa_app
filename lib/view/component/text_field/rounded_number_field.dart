// flutter
import 'package:flutter/material.dart';

// constant
import 'package:botob/constant/doubles.dart';

// view
import 'package:botob/view/component/button/text_field_container.dart';

class RoundedNumberField extends StatelessWidget {
  const RoundedNumberField({
    Key? key,
    required this.onChanged,
    required this.controller,
    required this.labelText,
    required this.width,
  }) : super(key: key);
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final String labelText;
  final double width;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      width: width,
      child: TextFormField(
        keyboardType: TextInputType.number,
        onChanged: onChanged,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(normalBorderRadius)),
          ),
          labelText: labelText,
        ),
        controller: controller,
        maxLines: 1,
        textAlign: TextAlign.center,
      ),
    );
  }
}
