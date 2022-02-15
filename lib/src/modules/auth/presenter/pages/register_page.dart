import 'package:beamer/beamer.dart';
import 'package:flash_chat/src/modules/auth/presenter/cubit/user_auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _registerFormKey =
      GlobalKey(debugLabel: "register-form");
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
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
          _insertOverlay(context);
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
                      "Register",
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
                      key: _registerFormKey,
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
                          createTextField(
                            controller: _emailController,
                            labelText: "E-mail",
                            errorText: emailErrorText,
                          ),
                          createTextField(
                            controller: _passwordController,
                            labelText: "Password",
                            errorText: passwordErrorText,
                            obscureText: true,
                          ),
                          createTextField(
                              controller: _passwordConfirmationController,
                              labelText: "Password Confirm",
                              obscureText: true,
                              validator: (String? text) {
                                if ((text ?? "") != _passwordController.text) {
                                  return "This field must be equal to Password field.";
                                } else {
                                  return null;
                                }
                              }),
                          const SizedBox(height: 25),
                          Row(
                            children: [
                              const Spacer(),
                              createExpansiveButton(
                                  flex: 3,
                                  label: "Cancel",
                                  callback: () {
                                    Beamer.of(context).beamBack();
                                  },
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                              const Spacer(),
                              createExpansiveButton(
                                flex: 3,
                                label: "Register",
                                callback: () {
                                  if (_registerFormKey.currentState!
                                      .validate()) {
                                    // update flag value
                                    _pageWasCreatedNow = false;

                                    _authCubit.signUpWitEmail(
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

  Widget createTextField({
    TextEditingController? controller,
    String? labelText,
    String? errorText,
    String? Function(String?)? validator,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 35,
        vertical: 5,
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          errorText: errorText,
        ),
        validator: validator,
        obscureText: obscureText,
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

  void _insertOverlay(BuildContext context) {
    var overlayState = Overlay.of(context);

    _overlayEntry = OverlayEntry(
      builder: (_) => Stack(
        children: [
          Container(
            color: Colors.grey[400]!.withOpacity(0.3),
          ),
          const Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );

    overlayState!.insert(_overlayEntry!);
  }
}
