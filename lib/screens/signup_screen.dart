import 'package:finance_tracker/colors.dart';
import 'package:finance_tracker/screens/login_screen.dart';
import 'package:finance_tracker/widgets/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/small_action_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My finance tracker',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: const Text(
              'Login',
              style: TextStyle(color: primaryColor),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Center(
                  child: SvgPicture.asset(
                    'assets/images/auth_img_2.svg',
                    width: MediaQuery.of(context).size.width * 0.5,
                  ),
                ),
                const SizedBox(height: 60),
                const Text(
                  'Sign up to Finance tracker',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                const TextFieldInput(
                  hintText: 'Your name',
                  labelText: 'Name',
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 25),
                const TextFieldInput(
                  hintText: 'name@example.com',
                  labelText: 'Email',
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 25),
                const TextFieldInput(
                  hintText: '********',
                  labelText: 'Password',
                  textInputType: TextInputType.text,
                  isPass: true,
                ),
                const SizedBox(height: 25),
                Row(
                  children: const [
                    Expanded(
                      child: TextFieldInput(
                        hintText: '********',
                        labelText: 'Confirm password',
                        textInputType: TextInputType.text,
                        isPass: true,
                      ),
                    ),
                    SizedBox(width: 30),
                    SmallActionButton(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
