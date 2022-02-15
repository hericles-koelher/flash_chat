import 'package:flash_chat/src/modules/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// Just a widget page used to test router...
class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text("LOGOUT"),
          onPressed: () {
            GetIt.I<UserAuthCubit>().signOut();
          },
        ),
      ),
    );
  }
}
