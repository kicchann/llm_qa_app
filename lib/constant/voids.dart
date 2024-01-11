import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:logger/logger.dart';

// constants
import 'package:botob/constant/strings.dart';

var logger = Logger();

void showSnackBar(
    {required BuildContext context,
    required String msg,
    required AnimatedSnackBarType type}) {
  AnimatedSnackBar.material(
    msg,
    type: type,
    duration: const Duration(seconds: 5),
    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
    desktopSnackBarPosition: DesktopSnackBarPosition.bottomCenter,
  ).show(context);
  return;
}

Future<void> uploadContentFile({
  required String uid,
  required String storageContentId,
  required PlatformFile file,
}) async {
  logger.d('uploadContentFile: called');

  final Reference storageReference = FirebaseStorage.instance
      .ref()
      .child(usersFieldKey)
      .child(uid)
      .child(contentsFieldKey)
      .child(storageContentId)
      .child(file.name);

  await storageReference.putData(file.bytes!);
  logger.d('uploadContentFile: finished');
  return;
}
