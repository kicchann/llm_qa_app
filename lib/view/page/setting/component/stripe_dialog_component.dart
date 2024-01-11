import 'package:botob/constant/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// util
import 'package:botob/util/stripe.dart';

// view
import 'package:botob/view/component/button/rounded_button_text.dart';

class StripeDialogComponent extends HookWidget {
  const StripeDialogComponent({
    Key? key,
    required this.userUid,
  }) : super(key: key);

  final String userUid;

  @override
  Widget build(BuildContext context) {
    final sessionId = useState<String>("");

    return AlertDialog(
      title: const Text(userpointDialogTitle),
      content: SizedBox(
        width: 400,
        height: 300,
        child: sessionId.value.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RoundedButtonText(
                    text: price100ButtonText,
                    width: 400,
                    onPressed: () async {
                      sessionId.value = await createCheckoutSession(
                        userUid: userUid,
                        stripePrice: StripePrice.price_100,
                      );
                    },
                  ),
                  RoundedButtonText(
                    text: price1000ButtonText,
                    width: 400,
                    onPressed: () async {
                      sessionId.value = await createCheckoutSession(
                        userUid: userUid,
                        stripePrice: StripePrice.price_1000,
                      );
                    },
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(moveToCheckoutText),
                  const SizedBox(height: 20),
                  StreamBuilder<Widget>(
                    stream: openCheckoutWithWidget(
                      userUid: userUid,
                      sessionId: sessionId.value,
                    ),
                    builder: (context, snapshot) {
                      return snapshot.data ?? const CircularProgressIndicator();
                    },
                  ),
                ],
              ),
      ),
      actions: [
        sessionId.value.isEmpty
            ? TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(cancelButtonText),
              )
            : const SizedBox()
      ],
    );
  }
}
