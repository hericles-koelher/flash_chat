import 'package:flash_chat/src/modules/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 4,
            ),
            ElevatedButton(
              child: const Text("DELETE ACCOUNT"),
              onPressed: () {
                GetIt.I<UserAuthCubit>().deleteAccount(
                  onError: (message) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Account delete action error"),
                          content: Text(
                            message,
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              child: const Text("LOGOUT"),
              onPressed: () {
                GetIt.I<UserAuthCubit>().signOut();
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
