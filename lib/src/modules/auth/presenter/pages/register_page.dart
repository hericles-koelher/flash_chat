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
  final Key registerFormKey = GlobalKey(debugLabel: "register-form");
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  final UserAuthCubit _authCubit = GetIt.I();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.grey[900],
      ),
      body: Column(
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

              if (state is UserUnauthenticatedError) {
                // TODO: handle error logic
              }

              return Form(
                child: Column(
                  children: [
                    createTextField(
                      controller: emailController,
                      labelText: "E-mail",
                      errorText: emailErrorText,
                    ),
                    createTextField(
                      controller: passwordController,
                      labelText: "Password",
                      errorText: passwordErrorText,
                    ),
                    createTextField(
                      controller: passwordConfirmationController,
                      labelText: "Password Confirm",
                    ),
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
                            color: Theme.of(context).colorScheme.secondary),
                        const Spacer(),
                        createExpansiveButton(
                          flex: 3,
                          label: "Register",
                          callback: () {
                            // TODO: use auth cubit...
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
    );
  }

  Widget createTextField({
    TextEditingController? controller,
    String? labelText,
    String? errorText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 35,
        vertical: 5,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: labelText, errorText: errorText),
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
