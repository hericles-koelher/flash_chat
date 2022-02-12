import 'dart:async';

import 'package:beamer/beamer.dart';
import 'package:flash_chat/placeholder_page.dart';
import 'package:flash_chat/src/modules/auth/auth.dart';
import 'package:flutter/widgets.dart';

abstract class IRouterCreator {
  RouteInformationParser<RouteInformation> get routeInformationParser;

  RouterDelegate<RouteInformation> get routerDelegate;
}

class BeamerRouterCreator extends IRouterCreator {
  final _ListenableUserAuthState _authState;

  BeamerRouterCreator(UserAuthCubit userAuthCubit)
      : _authState = _ListenableUserAuthState(userAuthCubit);

  @override
  RouteInformationParser<RouteInformation> get routeInformationParser =>
      BeamerParser();

  @override
  RouterDelegate<RouteInformation> get routerDelegate => BeamerDelegate(
        updateListenable: _authState,
        guards: [
          BeamGuard(
            pathPatterns: ["/auth"],
            check: (context, state) =>
                _authState.value is UserUnauthenticated ||
                _authState.value is UserAuthLoading,
            // if check is false them beam to "/"
            beamToNamed: (_, __) => "/",
          ),
          BeamGuard(
            pathPatterns: ["/home"],
            check: (context, state) => _authState.value is UserAuthenticated,
            // if check is false them beam to "/auth"
            beamToNamed: (_, __) => "/auth",
          ),
        ],
        initialPath: "/home",
        locationBuilder: RoutesLocationBuilder(
          routes: {
            "/home": (_, __, ___) => const PlaceholderPage(),
            "/auth": (_, __, ___) => const InitialPage(),
            "/auth/register": (_, __, ___) => const RegisterPage(),
          },
        ),
      );
}

class _ListenableUserAuthState extends ValueNotifier<UserAuthState> {
  late final StreamSubscription<UserAuthState> _streamSubscription;

  _ListenableUserAuthState(UserAuthCubit userAuthCubit)
      : super(userAuthCubit.state) {
    _streamSubscription = userAuthCubit.stream.listen((state) {
      value = state;
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();

    super.dispose();
  }
}
