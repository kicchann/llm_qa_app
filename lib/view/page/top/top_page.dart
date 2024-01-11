// flutter
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:botob/constant/strings.dart';
import 'package:botob/view/component/button/rounded_button_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// constant
import 'package:botob/constant/routes.dart' as routes;

class TopPage extends HookWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('TopPage: build');
    final animatedWidget = useMemoized(() async {
      await Future.delayed(const Duration(milliseconds: 500));
      if (!context.mounted) return Container();
      return AnimatedTextKit(
        animatedTexts: [
          TypewriterAnimatedText(
            appDescriptingText,
            textStyle: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
            speed: const Duration(milliseconds: 50),
          ),
        ],
        totalRepeatCount: 1,
      );
    });
    final snapshot01 = useFuture(animatedWidget);
    final animatedBool = useMemoized(() async {
      await Future.delayed(const Duration(milliseconds: 2500));
      return true;
    });
    final snapshot02 = useFuture(animatedBool);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  appTitle,
                  textStyle: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                  speed: const Duration(milliseconds: 50),
                ),
              ],
              totalRepeatCount: 1,
            ),
            const SizedBox(height: 20),
            snapshot01.connectionState == ConnectionState.done
                ? snapshot01.data!
                : Container(),
            const SizedBox(height: 50),
            AnimatedOpacity(
              opacity: snapshot02.connectionState == ConnectionState.done
                  ? 1.0
                  : 0.0,
              curve: Curves.easeIn,
              duration: const Duration(milliseconds: 1000),
              child: RoundedButtonText(
                text: startButtonText,
                onPressed: () => routes.toSignupPage(context: context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
