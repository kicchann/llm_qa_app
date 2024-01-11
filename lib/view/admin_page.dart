// flutter
import 'package:flutter/material.dart';

// constant
import 'package:botob/constant/strings.dart';

// model
import 'package:botob/model/admin_model.dart';

// view
import 'package:botob/view/component/button/rounded_button_text.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final AdminModel adminModel = AdminModel();
    return Scaffold(
      appBar: AppBar(
        title: const Text(adminPageTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: RoundedButtonText(
              onPressed: () async {
                await adminModel.resetDefaultExercise();
              },
              text: '種目を初期化',
              width: 100,
            ),
          )
        ],
      ),
    );
  }
}
