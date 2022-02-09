import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/cubit/user_auth_cubit.dart';

class UserCreationPage extends StatelessWidget {
  const UserCreationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var userAuthCubit = GetIt.I<UserAuthCubit>();

    return Scaffold(
      body: FutureBuilder(
        future: GetIt.I.getAsync<UserAuthCubit>(),
        builder: (context, snapshot) => snapshot.hasData
            ? Center(
                child: BlocBuilder<UserAuthCubit, UserAuthState>(
                  bloc: snapshot.data as UserAuthCubit,
                  builder: (context, state) {
                    if (state is UserUnauthenticatedError) {
                      return Text("Error: ${state.exception.message}");
                    }

                    if (state is UserUnauthenticated) {
                      (snapshot.data as UserAuthCubit).signUpWitEmail(
                          "brunokoelher@hotmail.com", "Digm2412@gg54G");

                      return const Text("User Not Authenticated");
                    }

                    if (state is UserAuthLoading) {
                      return const CircularProgressIndicator();
                    } else {
                      return Text(
                        "User Authenticated: ${(state as UserAuthenticated).userUID}}",
                      );
                    }
                  },
                ),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
