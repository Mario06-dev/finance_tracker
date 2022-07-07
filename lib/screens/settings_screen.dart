import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:finance_tracker/models/user_model.dart';
import 'package:finance_tracker/resources/auth_methods.dart';
import 'package:finance_tracker/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../widgets/custom_app_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<String> themeModes = ['Dark', 'Light', 'System'];
  String? selectedThemeMode = 'System';

  @override
  Widget build(BuildContext context) {
    // Getting current logged in user
    UserModel? user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Settings',
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.black,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user!.name,
                        style: Theme.of(context).textTheme.titleLarge),
                    Text(user.email,
                        style: Theme.of(context).textTheme.labelSmall),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {},
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                minLeadingWidth: 10,
                leading: const Icon(Icons.event),
                title: Text(
                  'Upcoming Features',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                trailing: const Icon(Icons.chevron_right),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              minLeadingWidth: 10,
              leading: const Icon(Icons.dark_mode),
              title: Text(
                'App Appearance',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              trailing: DropdownButton<String>(
                underline: const SizedBox(),
                onChanged: (value) {
                  setState(() {
                    selectedThemeMode = value;
                  });

                  if (value == 'Light') {
                    AdaptiveTheme.of(context).setLight();
                  }
                  if (value == 'Dark') {
                    AdaptiveTheme.of(context).setDark();
                  }
                  if (value == 'System') {
                    AdaptiveTheme.of(context).setSystem();
                  }
                },
                value: selectedThemeMode,
                items: themeModes
                    .map(
                      (themeMode) => DropdownMenuItem<String>(
                        value: themeMode,
                        child: Text(themeMode),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            InkWell(
              onTap: () async {
                await AuthMethods().signOut();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const LoginScreen()));
              },
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                minLeadingWidth: 10,
                leading: const Icon(Icons.logout, color: Colors.red),
                title: Text(
                  'Log Out',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
