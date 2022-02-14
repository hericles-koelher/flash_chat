import 'package:flash_chat/router_creator.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'initialization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeApp();

  runApp(
    FlashChat(
      routerCreator: BeamerRouterCreator(GetIt.I()),
    ),
  );
}

class FlashChat extends StatelessWidget {
  final IRouterCreator routerCreator;

  const FlashChat({
    Key? key,
    required this.routerCreator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flash Chat',
      theme: ThemeData.light().copyWith(
        // primaryColor: Colors.amber[700],
        colorScheme: ColorScheme.light(
          primary: Colors.amber[700]!,
          secondary: Colors.blue[600]!,
        ),
      ),
      routeInformationParser: routerCreator.routeInformationParser,
      routerDelegate: routerCreator.routerDelegate,
      backButtonDispatcher: routerCreator.backButtonDispatcher,
    );
  }
}
