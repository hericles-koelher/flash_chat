import 'dart:async';

import 'package:beamer/beamer.dart';
import 'package:flash_chat/placeholder_page.dart';
import 'package:flash_chat/src/modules/auth/auth.dart';
import 'package:flutter/widgets.dart';

abstract class IRouterCreator {
  RouteInformationParser<RouteInformation> get routeInformationParser;

  RouterDelegate<RouteInformation> get routerDelegate;

  BackButtonDispatcher get backButtonDispatcher;
}

class BeamerRouterCreator extends IRouterCreator {
  final _ListenableUserAuthState _authState;
  RouteInformationParser<RouteInformation>? _routeInformationParser;
  RouterDelegate<RouteInformation>? _routerDelegate;
  BackButtonDispatcher? _backButtonDispatcher;

  BeamerRouterCreator(UserAuthCubit userAuthCubit)
      : _authState = _ListenableUserAuthState(userAuthCubit);

  @override
  RouteInformationParser<RouteInformation> get routeInformationParser {
    if (_routeInformationParser != null) {
      return _routeInformationParser!;
    } else {
      // Assign _routeInformationParser and return it.
      return _routeInformationParser = BeamerParser();
    }
  }

  @override
  RouterDelegate<RouteInformation> get routerDelegate {
    if (_routerDelegate != null) {
      return _routerDelegate!;
    } else {
      // Assign _routerDelegate and return it.
      return _routerDelegate = BeamerDelegate(
        updateListenable: _authState,
        guards: [
          BeamGuard(
            pathPatterns: [
              RegExp(r"^\/auth(\/.*)?$"),
            ],
            check: (context, state) =>
                _authState.value is UserUnauthenticated ||
                _authState.value is UserAuthLoading,
            // if check is false them beam to "/"
            beamToNamed: (_, __) => "/",
          ),
          BeamGuard(
            pathPatterns: [
              RegExp(r"^(?!\/auth(\/.*)?).*$"),
            ],
            check: (context, state) => _authState.value is UserAuthenticated,
            // if check is false them beam to "/auth"
            beamToNamed: (_, __) => "/auth",
          ),
        ],
        initialPath: "/",
        locationBuilder: RoutesLocationBuilder(
          routes: {
            "/": (_, __, ___) => const PlaceholderPage(),
            "/auth": (_, __, ___) => const AuthPage(),
            "/auth/register": (_, __, ___) => const RegisterPage(),
          },
        ),
      );
    }
  }

  @override
  BackButtonDispatcher get backButtonDispatcher {
    if (_backButtonDispatcher != null) {
      return _backButtonDispatcher!;
    } else {
      // Assign _backButtonDispatcher and return it.
      return _backButtonDispatcher = BeamerBackButtonDispatcher(
        delegate: routerDelegate as BeamerDelegate,
      );
    }
  }
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
