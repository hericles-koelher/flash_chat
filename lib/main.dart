import 'package:flash_chat/router_creator.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'initialization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeApp();

  runApp(const FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var routerCreator = BeamerRouterCreator(GetIt.I());

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
    );
  }
}
