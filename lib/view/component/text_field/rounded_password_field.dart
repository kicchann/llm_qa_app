// flutter
import 'package:flutter/material.dart';
import 'package:botob/view/component/button/text_field_container.dart';

// constants
import 'package:botob/constant/strings.dart';
import 'package:botob/constant/doubles.dart';

class RoundedPasswordField extends StatelessWidget {
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
    required this.controller,
    required this.isObscure,
    required this.toggleIsObscure,
    required this.width,
  }) : super(key: key);
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final bool isObscure;
  final void Function()? toggleIsObscure;
  final double width;

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      width: width,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.visiblePassword,
            onChanged: onChanged,
            style: Theme.of(context).textTheme.bodyMedium,
            controller: controller,
            obscureText: isObscure,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(normalBorderRadius)),
              ),
              labelText: passwordText,
            ),
          ),
          Row(
            children: [
              Checkbox(
                  value: isObscure, onChanged: (value) => toggleIsObscure!()),
              Text(
                obscureText,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
