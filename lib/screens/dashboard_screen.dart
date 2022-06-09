import 'package:finance_tracker/models/user_model.dart';
import 'package:finance_tracker/providers/user_provider.dart';
import 'package:finance_tracker/screens/login_screen.dart';
import 'package:finance_tracker/widgets/custom_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Dashboard',
      ),
      body: Column(
        children: [
          Text('Hello ${user!.name}'),
        ],
      ),
    );
  }
}
