import 'package:flutter/widgets.dart';

class AnimatedLogo extends StatefulWidget {
  const AnimatedLogo({Key? key}) : super(key: key);

  @override
  _AnimatedLogoState createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> sizeAnimation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )
      ..repeat(reverse: true)
      ..addListener(() {
        setState(() {});
      });

    // animationController.repeat(reverse: true);

    sizeAnimation =
        Tween<double>(begin: 50, end: 200).animate(animationController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "images/logo.png",
      height: sizeAnimation.value,
      width: sizeAnimation.value,
    );
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }
}
