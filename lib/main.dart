//Levy Thiga Kariuki          G20893080      CO3808: Project
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:levexauto/constants/app_colors.dart';
import 'package:levexauto/views/splash/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

//Git final Push test 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'LevexAuto',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.native,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.scaffoldColor,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const SplashPage(),
    );
  }
}
