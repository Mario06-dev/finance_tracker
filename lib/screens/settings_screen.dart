import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:finance_tracker/resources/auth_methods.dart';
import 'package:finance_tracker/screens/login_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Settings',
      ),
      body: Column(
        children: [
          const Text('Settings screen'),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () async {
              await AuthMethods().signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: const Text('Sign Out'),
          ),
          ElevatedButton(
            onPressed: () {
              AdaptiveTheme.of(context).toggleThemeMode();
            },
            child: const Text('Change Theme'),
          ),
        ],
      ),
    );
  }
}
