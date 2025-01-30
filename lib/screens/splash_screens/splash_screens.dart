import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_to_image/screens/auth_screens/login_screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_screens/home_screens.dart';

class SplashScreens extends StatefulWidget {
  const SplashScreens({super.key});

  @override
  State<SplashScreens> createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  @override
  void initState() {
    super.initState();
    // _navigateToLogin();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

      await Future.delayed(const Duration(seconds: 3));

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              isLoggedIn ? const HomeScreen() : const LoginScreen(),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  void _navigateToLogin() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
        log("Navigate To Login Screen");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [
        //       Colors.red.shade400,
        //       Colors.red.shade200,
        //     ],
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //   ),
        // ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: Colors.red.shade200,
                  ),
                ),
                child: Image.asset(
                  'assets/images/imagetoimage.png',
                  height: 120.h,
                  width: 120.w,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: 30.h),

              // Welcome Text
              Text(
                "Welcome to",
                style: TextStyle(
                  fontSize: 24.sp,
                  color: Colors.black,
                  letterSpacing: 1.2,
                ),
              ),

              SizedBox(height: 10.h),

              // App Name
              Text(
                "Image To Image",
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 1.5,
                ),
              ),

              SizedBox(height: 8.h),

              // Subtitle
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  "Catalog App",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              SizedBox(height: 40.h),

              // Loading Indicator
              SizedBox(
                width: 45.w,
                height: 45.h,
                child: CircularProgressIndicator(
                  color: Colors.red.shade300,
                  strokeWidth: 3.w,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
