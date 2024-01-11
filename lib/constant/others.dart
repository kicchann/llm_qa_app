// intとかstring以外のものをreturn

// flutter
import 'package:botob/constant/enums.dart';

// package
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

User? returnAuthUser() => FirebaseAuth.instance.currentUser;

Future<XFile?> returnXFile() async {
// Future<String> returnXFile() async {
  final ImagePicker _picker = ImagePicker();
  final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  // return image!.path;
  return image;
}

SignupErrorMessages isValidPassword(String password) {
  // パスワードが空の場合はweakPassword
  if (password.isEmpty) {
    return SignupErrorMessages.weakPassword;
    // パスワードが8文字未満の場合はweakPassword
  } else if (password.length < 8) {
    return SignupErrorMessages.weakPassword;
    // 数字と英字が混在していない場合はinvalidPassword
  } else if (!password.contains(RegExp(r"[0-9]")) ||
      !password.contains(RegExp(r"[a-zA-Z]"))) {
    return SignupErrorMessages.invalidPassword;
    // 上記以外の場合はnoError
  } else {
    return SignupErrorMessages.noError;
  }
}

bool isValidUser(User? user) {
  if (user == null) {
    // ユーザーが存在しない場合はfalse
    return false;
  } else if (!user.emailVerified) {
    // メールアドレスが認証されていない場合はfalse
    return false;
  }

  String providerId = user.providerData[0].providerId;
  List<String> providerIdList = [
    "google.com",
    "password",
  ];
  if (!providerIdList.contains(providerId)) {
    // googleアカウントとパスワードアカウント以外の場合はfalse
    return false;
  } else {
    // 上記以外の場合はtrue
    return true;
  }
}

DateTime today() {
  DateTime now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}

IconData getMdiIcons(List<String> fileNames) {
  if (fileNames.length == 1) {
    final String extension = fileNames[0].split('.').last;
    switch (extension) {
      case 'txt':
        return MdiIcons.textBoxOutline;
      case 'md':
        return MdiIcons.languageMarkdownOutline;
      case 'json':
        return MdiIcons.codeJson;
      case 'pdf':
        return MdiIcons.filePdfBox;
      default:
        return MdiIcons.fileOutline;
    }
  } else if (fileNames.length > 1) {
    switch (fileNames.length) {
      case 2:
        return MdiIcons.numeric2BoxMultipleOutline;
      case 3:
        return MdiIcons.numeric3BoxMultipleOutline;
      case 4:
        return MdiIcons.numeric4BoxMultipleOutline;
      case 5:
        return MdiIcons.numeric5BoxMultipleOutline;
      case 6:
        return MdiIcons.numeric6BoxMultipleOutline;
      case 7:
        return MdiIcons.numeric7BoxMultipleOutline;
      case 8:
        return MdiIcons.numeric8BoxMultipleOutline;
      case 9:
        return MdiIcons.numeric9BoxMultipleOutline;
      default:
        return MdiIcons.numeric9PlusBoxMultipleOutline;
    }
  } else {
    return MdiIcons.fileOutline;
  }
}
