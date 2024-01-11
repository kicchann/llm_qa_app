import 'package:botob/constant/strings.dart';
import 'package:botob/view/component/text_field/rounded_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UserNameDialogComponent extends HookWidget {
  const UserNameDialogComponent({
    Key? key,
    required this.oldUserName,
    required this.okAction,
  }) : super(key: key);

  final String oldUserName;
  final Function(String text) okAction;

  @override
  Widget build(BuildContext context) {
    final userName = useState<String>(oldUserName);
    final controller = useTextEditingController(text: userName.value);

    return AlertDialog(
      title: const Text(userNameDialogTitle),
      content: SizedBox(
        height: 100,
        child: RoundedTextField(
          keyboardType: TextInputType.name,
          onChanged: (text) => userName.value = text,
          controller: controller,
          labelText: userNameText,
          width: 400,
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(cancelButtonText),
        ),
        TextButton(
          onPressed: () {
            okAction(userName.value);
            Navigator.pop(context);
          },
          child: const Text(okButtonText),
        ),
      ],
    );
  }
}
