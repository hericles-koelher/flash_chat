import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class FlashChatInitialPage extends StatelessWidget {
  const FlashChatInitialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(
            flex: 4,
          ),
          Image.asset(
            "images/logo.png",
            height: 120,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedTextKit(
                totalRepeatCount: 1,
                animatedTexts: [
                  TypewriterAnimatedText(
                    "Flash Chat",
                    cursor: "",
                    speed: const Duration(milliseconds: 150),
                    textStyle: const TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                    ),
                  )
                ],
              ),
            ],
          ),
          const Spacer(
            flex: 2,
          ),
          Row(
            children: [
              const Spacer(),
              Expanded(
                flex: 3,
                child: ElevatedButton(
                  child: const Text("Register"),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 3,
                child: ElevatedButton(
                  child: const Text("Login"),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).colorScheme.secondary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
