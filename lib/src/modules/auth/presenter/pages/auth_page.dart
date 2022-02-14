import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(
            flex: 4,
          ),
          Flexible(
            child: Hero(
              tag: "logo",
              child: Image.asset(
                "images/logo.png",
                height: 120,
              ),
            ),
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
                    speed: const Duration(milliseconds: 175),
                    curve: Curves.easeIn,
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
              createExpansiveButton(
                flex: 3,
                label: "Register",
                callback: () {
                  Beamer.of(context).beamToNamed("/auth/register");
                },
                color: Theme.of(context).colorScheme.secondary,
              ),
              const Spacer(),
              createExpansiveButton(
                flex: 3,
                label: "Login",
                callback: () {},
              ),
              const Spacer(),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }

  Widget createExpansiveButton({
    required int flex,
    required String label,
    required VoidCallback callback,
    Color? color,
  }) {
    return Expanded(
      flex: flex,
      child: ElevatedButton(
        child: Text(label),
        onPressed: callback,
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
