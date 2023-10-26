import 'package:assignment/domain/stateauth/authentication_provider.dart';
import 'package:assignment/presentation/Login/Loginpage.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer(builder: (context, ref, _) {
            return IconButton(
                onPressed: () {
                  ref.read(authProvider.notifier).signout();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (builder) {
                    return LoginPage();
                  }));
                },
                icon: Icon(Icons.exit_to_app));
          })
        ],
      ),
    );
  }
}
