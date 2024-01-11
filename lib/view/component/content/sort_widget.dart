// flutter
import 'package:flutter/material.dart';

class SortWidget extends StatelessWidget {
  const SortWidget({
    Key? key,
    required this.onTapSortFeild,
    required this.onTapSortOrder,
    required this.sortFields,
    required this.selectedSortField,
    required this.isAscending,
  }) : super(key: key);
  final Function(String value) onTapSortFeild;
  final VoidCallback onTapSortOrder;
  final List<String> sortFields;
  final String selectedSortField;
  final bool isAscending;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ソートボタン
        PopupMenuButton<String>(
          onSelected: (String value) {
            onTapSortFeild(value);
          },
          itemBuilder: (BuildContext context) {
            return sortFields
                .map((String value) => PopupMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ))
                .toList();
          },
          child: Text(selectedSortField),
        ),
        const SizedBox(width: 10),
        // 昇順降順ボタン
        IconButton(
          onPressed: () {
            onTapSortOrder();
          },
          icon: isAscending
              ? const Icon(Icons.arrow_upward_rounded)
              : const Icon(Icons.arrow_downward_rounded),
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}
