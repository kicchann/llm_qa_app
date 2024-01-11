// flutter
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// constants
import 'package:botob/constant/others.dart';
import 'package:botob/constant/strings.dart';

class ContentWidget extends StatelessWidget {
  const ContentWidget({
    Key? key,
    required this.onTap,
    required this.refferedDocumentIds,
    required this.refferedFileNames,
    required this.title,
    required this.date,
    required this.status,
  }) : super(key: key);
  final VoidCallback onTap;
  final List<String> refferedDocumentIds;
  final List<String> refferedFileNames;
  final String title;
  final DateTime date;
  final String status;

  String get _shortStatus {
    if (status.contains('失敗')) return '失敗';
    if (status.contains('完了')) return '利用可能';
    return '準備中';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(getMdiIcons(refferedFileNames)),
        trailing: null,
        onTap: onTap,
        title: Column(
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  DateFormat(datetimeFormatText).format(date),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Expanded(child: SizedBox()),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Text(_shortStatus,
                      style: Theme.of(context).textTheme.bodySmall),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
