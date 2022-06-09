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
      body: const Center(
        child: Text('Settings screen'),
      ),
    );
  }
}
