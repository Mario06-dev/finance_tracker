import 'package:finance_tracker/colors.dart';
import 'package:finance_tracker/screens/signup_screen.dart';
import 'package:finance_tracker/widgets/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/small_action_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'My finance tracker',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const SignupScreen()));
            },
            child: const Text(
              'Sign Up',
              style: TextStyle(color: primaryColor),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 60.h),
                Center(
                  child: SvgPicture.asset(
                    'assets/images/auth_img_2.svg',
                    //width: MediaQuery.of(context).size.width * 0.5,
                    width: 120.w,
                    height: 120.h,
                  ),
                ),
                SizedBox(height: 60.h),
                Text(
                  'Login to your account',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30.h),
                TextFieldInput(
                  controller: _emailController,
                  hintText: 'name@example.com',
                  labelText: 'Email',
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 25.h),
                Row(
                  children: [
                    Expanded(
                      child: TextFieldInput(
                        controller: _passwordController,
                        hintText: '********',
                        labelText: 'Password',
                        textInputType: TextInputType.text,
                        isPass: true,
                      ),
                    ),
                    SizedBox(width: 30.w),
                    const SmallActionButton(),
                  ],
                ),
                SizedBox(height: 30.h),
                Text('Forgot password?'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
