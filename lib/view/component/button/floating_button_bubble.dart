// flutter
import 'package:flutter/material.dart';

// view
import 'package:botob/view/component/bubble/bubble.dart';

class FloatingButtonBubble extends StatelessWidget {
  const FloatingButtonBubble({
    Key? key,
    required this.onPressed,
    this.text = '',
    this.textStyle,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return text == ''
        ? FloatingActionButton(
            // newContentを作成する
            onPressed: () => onPressed(),
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(Icons.add),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Bubble(
                    text: text,
                    textStyle: textStyle ??
                        Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.white),
                  )),
              Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: FloatingActionButton(
                    onPressed: () => onPressed(),
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Icon(Icons.add),
                  )),
            ],
          );
  }
}
