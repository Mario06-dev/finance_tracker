import 'package:finance_tracker/bottom_navigation.dart';
import 'package:finance_tracker/colors.dart';
import 'package:finance_tracker/screens/dashboard_screen.dart';
import 'package:finance_tracker/screens/signup_screen.dart';
import 'package:finance_tracker/widgets/text_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/auth_methods.dart';
import '../utils/utils.dart';
import '../widgets/small_action_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (res == 'success') {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const BottomNavigation()),
      );
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;

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
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 60.h),
                Center(
                  /* child: SvgPicture.asset(
                    'assets/images/auth_img_3.svg',
                    //width: MediaQuery.of(context).size.width * 0.5,
                    width: _isKeyboardOpen ? 60.w : 120.w,
                    height: _isKeyboardOpen ? 60.h : 120.h,
                  ), */
                  child: AnimatedContainer(
                    width: _isKeyboardOpen ? 60.w : 120.w,
                    height: _isKeyboardOpen ? 60.h : 120.h,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.fastOutSlowIn,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/image.png'))),
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
                    _isLoading
                        ? const CircularProgressIndicator()
                        : GestureDetector(
                            onTap: loginUser,
                            child: const SmallActionButton(),
                          ),
                  ],
                ),
                SizedBox(height: 30.h),
                const Text('Forgot password?'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
