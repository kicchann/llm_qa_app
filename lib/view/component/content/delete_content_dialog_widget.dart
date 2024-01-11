// packages
import 'package:flutter/material.dart';

// constants
import 'package:botob/constant/strings.dart';

// models
import 'package:botob/model/content/content.dart';

// repogitories
import 'package:botob/repogitory/content_repogitory.dart';

class DeleteContentDialogWidget extends StatelessWidget {
  const DeleteContentDialogWidget({
    Key? key,
    required this.content,
  }) : super(key: key);

  final Content content;
  @override
  Widget build(BuildContext context) {
    final ContentRepository contentRepository = ContentRepository();
    return AlertDialog(
      title: Text(content.title),
      content: const SizedBox(height: 100, child: Text(deleteDialogText)),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(cancelButtonText),
        ),
        TextButton(
          onPressed: () async {
            await contentRepository.deleteContent(content: content);
            if (!context.mounted) return;
            Navigator.pop(context);
          },
          child: const Text(okButtonText),
        ),
      ],
    );
  }
}
