import 'package:flash_chat/router_creator.dart';
import 'package:flash_chat/src/modules/auth/auth.dart';
import 'package:flash_chat/src/modules/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  inject();

  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  final Future<IRouterCreator> futureBeamerRouter;

  FlashChat({Key? key})
      : // Delaying future just to play with animations...
        futureBeamerRouter = Future.delayed(
          const Duration(seconds: 5),
          () => GetIt.I.getAsync<UserAuthCubit>().then(
                (cubit) => BeamerRouterCreator(cubit),
              ),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureBeamerRouter,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          var beamerRouter = snapshot.data as BeamerRouterCreator;

          return MaterialApp.router(
            title: 'Flutter Demo',
            theme: ThemeData.light().copyWith(
              // primaryColor: Colors.amber[700],
              colorScheme: ColorScheme.light(
                primary: Colors.amber[700]!,
                secondary: Colors.blue[600]!,
              ),
            ),
            routeInformationParser: beamerRouter.routeInformationParser,
            routerDelegate: beamerRouter.routerDelegate,
          );
        } else {
          return const Material(
            child: Center(
              child: AnimatedLogo(),
            ),
          );
        }
      },
    );
  }
}
