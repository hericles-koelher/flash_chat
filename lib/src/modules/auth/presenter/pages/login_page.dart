import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../commons/commons.dart';
import '../../auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey =
      GlobalKey(debugLabel: "login-form");
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final UserAuthCubit _authCubit = GetIt.I();
  OverlayEntry? _overlayEntry;
  bool _pageWasCreatedNow = true;

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Colors.grey[900],
    );

    var mediaQuery = MediaQuery.of(context);

    return BlocListener<UserAuthCubit, UserAuthState>(
      bloc: _authCubit,
      listenWhen: (prev, next) =>
          next is UserAuthLoading || prev is UserAuthLoading,
      listener: (context, state) {
        if (state is UserAuthLoading) {
          _overlayEntry = showLoadingOverlay(context);
        }

        if (state is UserUnauthenticated || state is UserAuthenticated) {
          _overlayEntry?.remove();
        }
      },
      child: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: mediaQuery.size.height -
                  (mediaQuery.padding.top + appBar.preferredSize.height),
              maxWidth: mediaQuery.size.width,
            ),
            child: Column(
              children: [
                const Spacer(
                  flex: 2,
                ),
                Row(
                  children: [
                    Flexible(
                      child: Hero(
                        tag: "logo",
                        child: Image.asset(
                          "images/logo.png",
                          height: 120,
                        ),
                      ),
                    ),
                    const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                BlocBuilder<UserAuthCubit, UserAuthState>(
                  bloc: _authCubit,
                  buildWhen: (prev, next) => next is UserUnauthenticated,
                  builder: (context, state) {
                    String? emailErrorText;
                    String? passwordErrorText;

                    if (!_pageWasCreatedNow &&
                        state is UserUnauthenticatedError) {
                      emailErrorText = state.exception.emailMessage;
                      passwordErrorText = state.exception.passwordMessage;
                    }

                    return Form(
                      key: _loginFormKey,
                      child: Column(
                        children: [
                          if (!_pageWasCreatedNow &&
                              state is UserUnauthenticatedError)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 15,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red[200],
                                borderRadius: BorderRadius.circular(5.0),
                                border: Border.all(
                                  width: 2.0,
                                  color: Colors.red[700]!,
                                ),
                              ),
                              child: Text(
                                state.exception.message,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          AuthTextFormField(
                            controller: _emailController,
                            labelText: "E-mail",
                            errorText: emailErrorText,
                          ),
                          AuthTextFormField(
                            controller: _passwordController,
                            labelText: "Password",
                            errorText: passwordErrorText,
                            obscureText: true,
                          ),
                          const SizedBox(height: 25),
                          Row(
                            children: [
                              const Spacer(),
                              ExpansiveElevatedButton(
                                  flex: 3,
                                  label: "Cancel",
                                  callback: () {
                                    Beamer.of(context).beamBack();
                                  },
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                              const Spacer(),
                              ExpansiveElevatedButton(
                                flex: 3,
                                label: "Login",
                                callback: () {
                                  if (_loginFormKey.currentState!.validate()) {
                                    // update flag value
                                    _pageWasCreatedNow = false;

                                    _authCubit.signInWitEmail(
                                      _emailController.text,
                                      _passwordController.text,
                                    );
                                  }
                                },
                              ),
                              const Spacer(),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
