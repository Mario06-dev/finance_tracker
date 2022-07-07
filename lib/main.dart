import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:finance_tracker/constants/colors.dart';
import 'package:finance_tracker/providers/add_trans_provider.dart';
import 'package:finance_tracker/providers/user_provider.dart';
import 'package:finance_tracker/screens/login_screen.dart';
import 'package:finance_tracker/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'bottom_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => AddTransProvider()),
        ],
        child: AdaptiveTheme(
          light: lightModeTheme(),
          dark: darkModeTheme(),
          initial: AdaptiveThemeMode.system,
          builder: (theme, darkTheme) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Finance Tracker',
              /* theme: ThemeData.light().copyWith(
                scaffoldBackgroundColor: Colors.white,
                textTheme: GoogleFonts.rubikTextTheme(),
              ), */
              theme: theme,
              darkTheme: darkTheme,
              home: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      return const BottomNavigation();
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('${snapshot.error}'),
                      );
                    }
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: primaryColor,
                    ));
                  }

                  return const LoginScreen();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
