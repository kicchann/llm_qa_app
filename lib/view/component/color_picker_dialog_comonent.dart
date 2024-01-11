// packages
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

// constants
import 'package:botob/constant/strings.dart';

class ColorPickerDialogComponent extends HookWidget {
  const ColorPickerDialogComponent({
    Key? key,
    required this.selectedColor,
    required this.onColorChange,
  }) : super(key: key);

  final Color selectedColor;
  final Function(Color color) onColorChange;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(colorDialogTitle),
      content: MaterialColorPicker(
        selectedColor: selectedColor,
        onColorChange: (Color color) {
          onColorChange(color);
          Navigator.pop(context);
        },
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(cancelButtonText),
        )
      ],
    );
  }
}
