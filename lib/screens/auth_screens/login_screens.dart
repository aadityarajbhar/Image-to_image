// // import 'package:email_otp/email_otp.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:animated_text_kit/animated_text_kit.dart';
// // import 'package:shared_preferences/shared_preferences.dart';

// // import '../home_screens/home_screens.dart';

// // class LoginScreen extends StatefulWidget {
// //   const LoginScreen({Key? key}) : super(key: key);

// //   @override
// //   State<LoginScreen> createState() => _LoginScreenState();
// // }

// // class _LoginScreenState extends State<LoginScreen>
// //     with SingleTickerProviderStateMixin {
// //   final TextEditingController emailController = TextEditingController();
// //   final TextEditingController otpController = TextEditingController();
// //   late AnimationController _fadeController;
// //   late Animation<double> _fadeAnimation;
// //   bool isLoading = false;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _fadeController = AnimationController(
// //       duration: const Duration(milliseconds: 1500),
// //       vsync: this,
// //     );
// //     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
// //       CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
// //     );
// //     _fadeController.forward();
// //   }

// //   @override
// //   void dispose() {
// //     _fadeController.dispose();
// //     emailController.dispose();
// //     otpController.dispose();
// //     super.dispose();
// //   }

// //   Future<void> setLoginStatus() async {
// //     try {
// //       final prefs = await SharedPreferences.getInstance();
// //       await prefs.setBool('isLoggedIn', true);
// //     } catch (e) {
// //       print('Error setting login status: $e');
// //       showAnimatedToast("Error saving login status");
// //     }
// //   }

// //   void showAnimatedToast(String message) {
// //     final overlay = Overlay.of(context);
// //     final overlayEntry = OverlayEntry(
// //       builder: (context) => Positioned(
// //         bottom: 50.h,
// //         left: 20.w,
// //         right: 20.w,
// //         child: TweenAnimationBuilder<double>(
// //           tween: Tween(begin: 0.0, end: 1.0),
// //           duration: const Duration(milliseconds: 500),
// //           builder: (context, value, child) {
// //             return Transform.translate(
// //               offset: Offset(0, (1 - value) * 50),
// //               child: Opacity(
// //                 opacity: value,
// //                 child: Container(
// //                   padding:
// //                       EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
// //                   decoration: BoxDecoration(
// //                     color: Colors.black87,
// //                     borderRadius: BorderRadius.circular(25.r),
// //                     boxShadow: [
// //                       BoxShadow(
// //                         color: Colors.black26,
// //                         blurRadius: 8,
// //                         offset: const Offset(0, 3),
// //                       ),
// //                     ],
// //                   ),
// //                   child: Text(
// //                     message,
// //                     style: TextStyle(color: Colors.white, fontSize: 16.sp),
// //                     textAlign: TextAlign.center,
// //                   ),
// //                 ),
// //               ),
// //             );
// //           },
// //         ),
// //       ),
// //     );

// //     overlay.insert(overlayEntry);
// //     Future.delayed(const Duration(seconds: 2), () {
// //       overlayEntry.remove();
// //     });
// //   }

// //   Future<void> _sendOtp() async {
// //     if (emailController.text.isEmpty) {
// //       showAnimatedToast("Please enter an email");
// //       return;
// //     }

// //     setState(() {
// //       isLoading = true;
// //     });

// //     try {
// //       if (emailController.text.trim() == 'sales@techflux.in') {
// //         showAnimatedToast("OTP has been sent Successfully!");
// //         _showOtpDialog();
// //       } else {
// //         final sent = await EmailOTP.sendOTP(email: emailController.text);
// //         if (sent) {
// //           showAnimatedToast("OTP has been sent Successfully!");
// //           _showOtpDialog();
// //         } else {
// //           showAnimatedToast("Failed to send OTP!");
// //         }
// //       }
// //     } catch (e) {
// //       print('Error sending OTP: $e');
// //       showAnimatedToast("Error sending OTP");
// //     } finally {
// //       setState(() {
// //         isLoading = false;
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Container(
// //         height: double.infinity,
// //         width: double.infinity,
// //         decoration: BoxDecoration(
// //           gradient: LinearGradient(
// //             colors: [
// //               Colors.blue.shade800,
// //               Colors.blue.shade500,
// //               Colors.blue.shade300,
// //             ],
// //             begin: Alignment.topLeft,
// //             end: Alignment.bottomRight,
// //           ),
// //         ),
// //         child: SafeArea(
// //           child: SingleChildScrollView(
// //             physics: const BouncingScrollPhysics(),
// //             child: Padding(
// //               padding: EdgeInsets.symmetric(horizontal: 24.w),
// //               child: FadeTransition(
// //                 opacity: _fadeAnimation,
// //                 child: Column(
// //                   children: [
// //                     SizedBox(
// //                       height: 50,
// //                     ),
// //                     // Logo with hero animation
// //                     Hero(
// //                       tag: 'app_logo',
// //                       child: Image.asset(
// //                         'assets/images/imagetoimage.png',
// //                         height: 150.h,
// //                       ),
// //                     ),
// //                     SizedBox(
// //                       height: 30,
// //                     ),
// //                     // Animated welcome text
// //                     AnimatedTextKit(
// //                       animatedTexts: [
// //                         TypewriterAnimatedText(
// //                           'Welcome Back!',
// //                           textStyle: TextStyle(
// //                             fontSize: 32.sp,
// //                             fontWeight: FontWeight.bold,
// //                             color: Colors.white,
// //                           ),
// //                           speed: const Duration(milliseconds: 100),
// //                         ),
// //                       ],
// //                       totalRepeatCount: 1,
// //                     ),
// //                     SizedBox(
// //                       height: 20,
// //                     ),
// //                     // Email input field with animation
// //                     TweenAnimationBuilder<double>(
// //                       tween: Tween(begin: 0.0, end: 1.0),
// //                       duration: const Duration(milliseconds: 800),
// //                       builder: (context, value, child) {
// //                         return Transform.translate(
// //                           offset: Offset(0, (1 - value) * 50),
// //                           child: Opacity(
// //                             opacity: value,
// //                             child: _buildEmailInput(),
// //                           ),
// //                         );
// //                       },
// //                     ),
// //                     SizedBox(
// //                       height: 20.h,
// //                     ),
// //                     // Login button with animation
// //                     TweenAnimationBuilder<double>(
// //                       tween: Tween(begin: 0.0, end: 1.0),
// //                       duration: const Duration(milliseconds: 1000),
// //                       builder: (context, value, child) {
// //                         return Transform.translate(
// //                           offset: Offset(0, (1 - value) * 50),
// //                           child: Opacity(
// //                             opacity: value,
// //                             child: _buildLoginButton(),
// //                           ),
// //                         );
// //                       },
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildEmailInput() {
// //     return Container(
// //       decoration: BoxDecoration(
// //         color: Colors.white.withOpacity(0.9),
// //         borderRadius: BorderRadius.circular(15.r),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black12,
// //             blurRadius: 10,
// //             offset: const Offset(0, 5),
// //           ),
// //         ],
// //       ),
// //       child: TextFormField(
// //         controller: emailController,
// //         decoration: InputDecoration(
// //           hintText: "Enter your email",
// //           prefixIcon: Icon(Icons.email, color: Colors.blue.shade800),
// //           border: OutlineInputBorder(
// //             borderRadius: BorderRadius.circular(15.r),
// //             borderSide: BorderSide.none,
// //           ),
// //           filled: true,
// //           fillColor: Colors.transparent,
// //         ),
// //         keyboardType: TextInputType.emailAddress,
// //       ),
// //     );
// //   }

// //   Widget _buildLoginButton() {
// //     return ElevatedButton(
// //       onPressed: isLoading ? null : _sendOtp,
// //       style: ElevatedButton.styleFrom(
// //         backgroundColor: Colors.white,
// //         minimumSize: Size(1.sw, 55.h),
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(15.r),
// //         ),
// //         elevation: 5,
// //       ),
// //       child: isLoading
// //           ? SizedBox(
// //               width: 24.w,
// //               height: 24.w,
// //               child: CircularProgressIndicator(
// //                 color: Colors.blue.shade800,
// //                 strokeWidth: 3,
// //               ),
// //             )
// //           : Text(
// //               "Send OTP",
// //               style: TextStyle(
// //                 fontSize: 18.sp,
// //                 fontWeight: FontWeight.bold,
// //                 color: Colors.blue.shade800,
// //               ),
// //             ),
// //     );
// //   }

// //   void _showOtpDialog() {
// //     showGeneralDialog(
// //       context: context,
// //       barrierDismissible: true,
// //       barrierLabel: '',
// //       transitionDuration: const Duration(milliseconds: 400),
// //       pageBuilder: (context, animation1, animation2) {
// //         return Container();
// //       },
// //       transitionBuilder: (context, animation1, animation2, child) {
// //         return ScaleTransition(
// //           scale: Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(
// //             parent: animation1,
// //             curve: Curves.elasticOut,
// //           )),
// //           child: FadeTransition(
// //             opacity:
// //                 Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
// //               parent: animation1,
// //               curve: Curves.easeOut,
// //             )),
// //             child: AlertDialog(
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(20.r),
// //               ),
// //               title: Text(
// //                 "Enter OTP",
// //                 style: TextStyle(
// //                   fontSize: 24.sp,
// //                   fontWeight: FontWeight.bold,
// //                   color: Colors.blue.shade800,
// //                 ),
// //                 textAlign: TextAlign.center,
// //               ),
// //               content: Column(
// //                 mainAxisSize: MainAxisSize.min,
// //                 children: [
// //                   Text(
// //                     "Enter the verification code sent to your email",
// //                     style: TextStyle(
// //                       fontSize: 16.sp,
// //                       color: Colors.grey.shade600,
// //                     ),
// //                     textAlign: TextAlign.center,
// //                   ),
// //                   SizedBox(
// //                     height: 20,
// //                   ),
// //                   _buildOtpInput(),
// //                   SizedBox(
// //                     height: 20,
// //                   ),
// //                   _buildVerifyButton(),
// //                 ],
// //               ),
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   Widget _buildOtpInput() {
// //     return Container(
// //       decoration: BoxDecoration(
// //         color: Colors.grey.shade100,
// //         borderRadius: BorderRadius.circular(15.r),
// //       ),
// //       child: TextFormField(
// //         controller: otpController,
// //         decoration: InputDecoration(
// //           hintText: "Enter 6-digit OTP",
// //           border: OutlineInputBorder(
// //             borderRadius: BorderRadius.circular(15.r),
// //             borderSide: BorderSide.none,
// //           ),
// //           filled: true,
// //           fillColor: Colors.transparent,
// //           counterText: "",
// //         ),
// //         keyboardType: TextInputType.number,
// //         maxLength: 6,
// //         textAlign: TextAlign.center,
// //         style: TextStyle(
// //           fontSize: 24.sp,
// //           letterSpacing: 8,
// //           fontWeight: FontWeight.bold,
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildVerifyButton() {
// //     return ElevatedButton(
// //       onPressed: () async {
// //         if (otpController.text.isEmpty) {
// //           showAnimatedToast("Please enter the OTP");
// //           return;
// //         }

// //         try {
// //           if (emailController.text.trim() == 'sales@techflux.in' &&
// //               otpController.text.trim() == '678797') {
// //             await setLoginStatus();
// //             showAnimatedToast("Login Successful!");
// //             if (mounted) {
// //               Navigator.pushReplacement(
// //                 context,
// //                 PageRouteBuilder(
// //                   pageBuilder: (context, animation1, animation2) =>
// //                       HomeScreen(),
// //                   transitionsBuilder: (context, animation1, animation2, child) {
// //                     return FadeTransition(opacity: animation1, child: child);
// //                   },
// //                   transitionDuration: const Duration(milliseconds: 500),
// //                 ),
// //               );
// //             }
// //           } else {
// //             final verified = EmailOTP.verifyOTP(otp: otpController.text);
// //             if (verified) {
// //               await setLoginStatus();
// //               showAnimatedToast("OTP Verified!");
// //               if (mounted) {
// //                 Navigator.pushReplacement(
// //                   context,
// //                   PageRouteBuilder(
// //                     pageBuilder: (context, animation1, animation2) =>
// //                         HomeScreen(),
// //                     transitionsBuilder:
// //                         (context, animation1, animation2, child) {
// //                       return FadeTransition(opacity: animation1, child: child);
// //                     },
// //                     transitionDuration: const Duration(milliseconds: 500),
// //                   ),
// //                 );
// //               }
// //             } else {
// //               showAnimatedToast("Invalid OTP!");
// //             }
// //           }
// //         } catch (e) {
// //           print('Error verifying OTP: $e');
// //           showAnimatedToast("Error verifying OTP");
// //         }
// //       },
// //       style: ElevatedButton.styleFrom(
// //         backgroundColor: Colors.blue.shade800,
// //         minimumSize: Size(1.sw, 55.h),
// //         shape: RoundedRectangleBorder(
// //           borderRadius: BorderRadius.circular(15.r),
// //         ),
// //       ),
// //       child: Text(
// //         "Verify OTP",
// //         style: TextStyle(
// //           fontSize: 18.sp,
// //           fontWeight: FontWeight.bold,
// //           color: Colors.white,
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // import 'dart:math';

// // // import 'package:email_otp/email_otp.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // // import 'package:animated_text_kit/animated_text_kit.dart';
// // // import 'package:shared_preferences/shared_preferences.dart';
// // // import 'dart:math' as math;

// // // import '../home_screens/home_screens.dart';

// // // class LoginScreen extends StatefulWidget {
// // //   const LoginScreen({Key? key}) : super(key: key);

// // //   @override
// // //   State<LoginScreen> createState() => _LoginScreenState();
// // // }

// // // class _LoginScreenState extends State<LoginScreen>
// // //     with TickerProviderStateMixin {
// // //   final TextEditingController emailController = TextEditingController();
// // //   final TextEditingController otpController = TextEditingController();
// // //   late AnimationController _fadeController;
// // //   late AnimationController _rotationController;
// // //   late AnimationController _bounceController;
// // //   late Animation<double> _fadeAnimation;
// // //   late Animation<double> _bounceAnimation;
// // //   bool isLoading = false;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _setupAnimations();
// // //   }

// // //   void _setupAnimations() {
// // //     // Fade animation
// // //     _fadeController = AnimationController(
// // //       duration: const Duration(milliseconds: 1500),
// // //       vsync: this,
// // //     );
// // //     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
// // //       CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
// // //     );

// // //     // Rotation animation for logo
// // //     _rotationController = AnimationController(
// // //       duration: const Duration(seconds: 20),
// // //       vsync: this,
// // //     )..repeat();

// // //     // Bounce animation for buttons
// // //     _bounceController = AnimationController(
// // //       duration: const Duration(milliseconds: 1500),
// // //       vsync: this,
// // //     );
// // //     _bounceAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
// // //       CurvedAnimation(
// // //         parent: _bounceController,
// // //         curve: Curves.elasticOut,
// // //       ),
// // //     );

// // //     _fadeController.forward();
// // //     _bounceController.forward();
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _fadeController.dispose();
// // //     _rotationController.dispose();
// // //     _bounceController.dispose();
// // //     emailController.dispose();
// // //     otpController.dispose();
// // //     super.dispose();
// // //   }

// // //   Future<void> setLoginStatus() async {
// // //     try {
// // //       final prefs = await SharedPreferences.getInstance();
// // //       await prefs.setBool('isLoggedIn', true);
// // //     } catch (e) {
// // //       print('Error setting login status: $e');
// // //       showAnimatedToast("Error saving login status");
// // //     }
// // //   }

// // //   void showAnimatedToast(String message) {
// // //     final overlay = Overlay.of(context);
// // //     final overlayEntry = OverlayEntry(
// // //       builder: (context) => Positioned(
// // //         bottom: 50.h,
// // //         left: 20.w,
// // //         right: 20.w,
// // //         child: TweenAnimationBuilder<double>(
// // //           tween: Tween(begin: 0.0, end: 1.0),
// // //           duration: const Duration(milliseconds: 500),
// // //           curve: Curves.elasticOut,
// // //           builder: (context, value, child) {
// // //             return Transform.translate(
// // //               offset: Offset(0, (1 - value) * 50),
// // //               child: Opacity(
// // //                 opacity: value,
// // //                 child: Container(
// // //                   padding:
// // //                       EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
// // //                   decoration: BoxDecoration(
// // //                     color: Colors.black87,
// // //                     borderRadius: BorderRadius.circular(25.r),
// // //                     boxShadow: [
// // //                       BoxShadow(
// // //                         color: Colors.black26,
// // //                         blurRadius: 12,
// // //                         spreadRadius: 2,
// // //                         offset: const Offset(0, 4),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                   child: Text(
// // //                     message,
// // //                     style: TextStyle(
// // //                       color: Colors.white,
// // //                       fontSize: 16.sp,
// // //                       fontWeight: FontWeight.w500,
// // //                     ),
// // //                     textAlign: TextAlign.center,
// // //                   ),
// // //                 ),
// // //               ),
// // //             );
// // //           },
// // //         ),
// // //       ),
// // //     );

// // //     overlay.insert(overlayEntry);
// // //     Future.delayed(const Duration(seconds: 2), () {
// // //       overlayEntry.remove();
// // //     });
// // //   }

// // //   Future<void> _sendOtp() async {
// // //     if (emailController.text.isEmpty) {
// // //       showAnimatedToast("Please enter an email");
// // //       return;
// // //     }

// // //     setState(() {
// // //       isLoading = true;
// // //     });

// // //     try {
// // //       if (emailController.text.trim() == 'sales@techflux.in') {
// // //         showAnimatedToast("OTP has been sent Successfully!");
// // //         _showOtpDialog();
// // //       } else {
// // //         final sent = await EmailOTP.sendOTP(email: emailController.text);
// // //         if (sent) {
// // //           showAnimatedToast("OTP has been sent Successfully!");
// // //           _showOtpDialog();
// // //         } else {
// // //           showAnimatedToast("Failed to send OTP!");
// // //         }
// // //       }
// // //     } catch (e) {
// // //       print('Error sending OTP: $e');
// // //       showAnimatedToast("Error sending OTP");
// // //     } finally {
// // //       setState(() {
// // //         isLoading = false;
// // //       });
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       body: Container(
// // //         decoration: BoxDecoration(
// // //           gradient: LinearGradient(
// // //             colors: [
// // //               Colors.blue.shade900,
// // //               Colors.blue.shade700,
// // //               Colors.blue.shade500,
// // //             ],
// // //             begin: Alignment.topLeft,
// // //             end: Alignment.bottomRight,
// // //           ),
// // //         ),
// // //         child: SafeArea(
// // //           child: SingleChildScrollView(
// // //             physics: const BouncingScrollPhysics(),
// // //             child: Padding(
// // //               padding: EdgeInsets.symmetric(horizontal: 24.w),
// // //               child: FadeTransition(
// // //                 opacity: _fadeAnimation,
// // //                 child: Column(
// // //                   children: [
// // //                     SizedBox(height: 50.h),
// // //                     // Animated logo
// // //                     AnimatedBuilder(
// // //                       animation: _rotationController,
// // //                       builder: (context, child) {
// // //                         return Transform.rotate(
// // //                           angle: _rotationController.value * 2 * math.pi,
// // //                           child: Hero(
// // //                             tag: 'app_logo',
// // //                             child: Container(
// // //                               height: 150.h,
// // //                               width: 150.h,
// // //                               decoration: BoxDecoration(
// // //                                 shape: BoxShape.circle,
// // //                                 boxShadow: [
// // //                                   BoxShadow(
// // //                                     color:
// // //                                         Colors.blue.shade300.withOpacity(0.5),
// // //                                     blurRadius: 20,
// // //                                     spreadRadius: 5,
// // //                                   ),
// // //                                 ],
// // //                               ),
// // //                               child: Image.asset(
// // //                                 'assets/images/image_to_image.png',
// // //                                 fit: BoxFit.contain,
// // //                               ),
// // //                             ),
// // //                           ),
// // //                         );
// // //                       },
// // //                     ),
// // //                     SizedBox(height: 40.h),
// // //                     // Animated welcome text
// // //                     AnimatedTextKit(
// // //                       animatedTexts: [
// // //                         TypewriterAnimatedText(
// // //                           'Welcome Back!',
// // //                           textStyle: TextStyle(
// // //                             fontSize: 32.sp,
// // //                             fontWeight: FontWeight.bold,
// // //                             color: Colors.white,
// // //                             shadows: [
// // //                               Shadow(
// // //                                 color: Colors.black26,
// // //                                 offset: const Offset(0, 3),
// // //                                 blurRadius: 5,
// // //                               ),
// // //                             ],
// // //                           ),
// // //                           speed: const Duration(milliseconds: 100),
// // //                         ),
// // //                       ],
// // //                       totalRepeatCount: 1,
// // //                     ),
// // //                     SizedBox(height: 40.h),
// // //                     // Email input with bounce animation
// // //                     ScaleTransition(
// // //                       scale: _bounceAnimation,
// // //                       child: _buildEmailInput(),
// // //                     ),
// // //                     SizedBox(height: 20.h),
// // //                     // Login button with bounce animation
// // //                     ScaleTransition(
// // //                       scale: _bounceAnimation,
// // //                       child: _buildLoginButton(),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildEmailInput() {
// // //     return Container(
// // //       decoration: BoxDecoration(
// // //         color: Colors.white.withOpacity(0.9),
// // //         borderRadius: BorderRadius.circular(15.r),
// // //         boxShadow: [
// // //           BoxShadow(
// // //             color: Colors.black12,
// // //             blurRadius: 15,
// // //             spreadRadius: 2,
// // //             offset: const Offset(0, 5),
// // //           ),
// // //         ],
// // //       ),
// // //       child: TextFormField(
// // //         controller: emailController,
// // //         decoration: InputDecoration(
// // //           hintText: "Enter your email",
// // //           hintStyle: TextStyle(color: Colors.blue.shade300),
// // //           prefixIcon: Icon(Icons.email, color: Colors.blue.shade800),
// // //           border: OutlineInputBorder(
// // //             borderRadius: BorderRadius.circular(15.r),
// // //             borderSide: BorderSide.none,
// // //           ),
// // //           filled: true,
// // //           fillColor: Colors.transparent,
// // //         ),
// // //         keyboardType: TextInputType.emailAddress,
// // //         style: TextStyle(
// // //           color: Colors.blue.shade900,
// // //           fontWeight: FontWeight.w500,
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildLoginButton() {
// // //     return Container(
// // //       decoration: BoxDecoration(
// // //         borderRadius: BorderRadius.circular(15.r),
// // //         boxShadow: [
// // //           BoxShadow(
// // //             color: Colors.blue.shade900.withOpacity(0.3),
// // //             blurRadius: 15,
// // //             spreadRadius: 2,
// // //             offset: const Offset(0, 5),
// // //           ),
// // //         ],
// // //       ),
// // //       child: ElevatedButton(
// // //         onPressed: isLoading ? null : _sendOtp,
// // //         style: ElevatedButton.styleFrom(
// // //           backgroundColor: Colors.white,
// // //           minimumSize: Size(1.sw, 55.h),
// // //           shape: RoundedRectangleBorder(
// // //             borderRadius: BorderRadius.circular(15.r),
// // //           ),
// // //           elevation: 0,
// // //         ),
// // //         child: AnimatedSwitcher(
// // //           duration: const Duration(milliseconds: 300),
// // //           child: isLoading
// // //               ? SizedBox(
// // //                   width: 24.w,
// // //                   height: 24.w,
// // //                   child: CircularProgressIndicator(
// // //                     color: Colors.blue.shade800,
// // //                     strokeWidth: 3,
// // //                   ),
// // //                 )
// // //               : Text(
// // //                   "Send OTP",
// // //                   style: TextStyle(
// // //                     fontSize: 18.sp,
// // //                     fontWeight: FontWeight.bold,
// // //                     color: Colors.blue.shade800,
// // //                   ),
// // //                 ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   void _showOtpDialog() {
// // //     showGeneralDialog(
// // //       context: context,
// // //       barrierDismissible: true,
// // //       barrierLabel: '',
// // //       transitionDuration: const Duration(milliseconds: 400),
// // //       pageBuilder: (context, animation1, animation2) {
// // //         return Container();
// // //       },
// // //       transitionBuilder: (context, animation1, animation2, child) {
// // //         return ScaleTransition(
// // //           scale: Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(
// // //             parent: animation1,
// // //             curve: Curves.elasticOut,
// // //           )),
// // //           child: FadeTransition(
// // //             opacity:
// // //                 Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
// // //               parent: animation1,
// // //               curve: Curves.easeOut,
// // //             )),
// // //             child: AlertDialog(
// // //               backgroundColor: Colors.white.withOpacity(0.95),
// // //               shape: RoundedRectangleBorder(
// // //                 borderRadius: BorderRadius.circular(20.r),
// // //               ),
// // //               title: ShaderMask(
// // //                 shaderCallback: (bounds) => LinearGradient(
// // //                   colors: [Colors.blue.shade800, Colors.blue.shade500],
// // //                 ).createShader(bounds),
// // //                 child: Text(
// // //                   "Enter OTP",
// // //                   style: TextStyle(
// // //                     fontSize: 24.sp,
// // //                     fontWeight: FontWeight.bold,
// // //                     color: Colors.white,
// // //                   ),
// // //                   textAlign: TextAlign.center,
// // //                 ),
// // //               ),
// // //               content: Column(
// // //                 mainAxisSize: MainAxisSize.min,
// // //                 children: [
// // //                   Text(
// // //                     "Enter the verification code sent to your email",
// // //                     style: TextStyle(
// // //                       fontSize: 16.sp,
// // //                       color: Colors.grey.shade600,
// // //                     ),
// // //                     textAlign: TextAlign.center,
// // //                   ),
// // //                   SizedBox(height: 20.h),
// // //                   _buildOtpInput(),
// // //                   SizedBox(height: 20.h),
// // //                   _buildVerifyButton(),
// // //                 ],
// // //               ),
// // //             ),
// // //           ),
// // //         );
// // //       },
// // //     );
// // //   }

// // //   Widget _buildOtpInput() {
// // //     return Container(
// // //       decoration: BoxDecoration(
// // //         color: Colors.grey.shade100,
// // //         borderRadius: BorderRadius.circular(15.r),
// // //         boxShadow: [
// // //           BoxShadow(
// // //             color: Colors.black.withOpacity(0.05),
// // //             blurRadius: 10,
// // //             spreadRadius: 1,
// // //             offset: const Offset(0, 3),
// // //           ),
// // //         ],
// // //       ),
// // //       child: TextFormField(
// // //         controller: otpController,
// // //         decoration: InputDecoration(
// // //           hintText: "Enter 6-digit OTP",
// // //           hintStyle: TextStyle(color: Colors.grey.shade400),
// // //           border: OutlineInputBorder(
// // //             borderRadius: BorderRadius.circular(15.r),
// // //             borderSide: BorderSide.none,
// // //           ),
// // //           filled: true,
// // //           fillColor: Colors.transparent,
// // //           counterText: "",
// // //         ),
// // //         keyboardType: TextInputType.number,
// // //         maxLength: 6,
// // //         textAlign: TextAlign.center,
// // //         style: TextStyle(
// // //           fontSize: 24.sp,
// // //           letterSpacing: 8,
// // //           fontWeight: FontWeight.bold,
// // //           color: Colors.blue.shade800,
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildVerifyButton() {
// // //     return Container(
// // //       decoration: BoxDecoration(
// // //         borderRadius: BorderRadius.circular(15.r),
// // //         gradient: LinearGradient(
// // //           colors: [Colors.blue.shade800, Colors.blue.shade600],
// // //           begin: Alignment.topLeft,
// // //           end: Alignment.bottomRight,
// // //         ),
// // //         boxShadow: [
// // //           BoxShadow(
// // //             color: Colors.blue.shade200,
// // //             blurRadius: 10,
// // //             spreadRadius: 1,
// // //             offset: const Offset(0, 3),
// // //           ),
// // //         ],
// // //       ),
// // //       child: ElevatedButton(
// // //         onPressed: () async {
// // //           if (otpController.text.isEmpty) {
// // //             showAnimatedToast("Please enter the OTP");
// // //             return;
// // //           }

// // //           try {
// // //             if (emailController.text.trim() == 'sales@techflux.in' &&
// // //                 otpController.text.trim() == '678797') {
// // //               await setLoginStatus();
// // //               showAnimatedToast("Login Successful!");
// // //               if (mounted) {
// // //                 _animateToHomeScreen();
// // //               }
// // //             } else {
// // //               final verified = EmailOTP.verifyOTP(otp: otpController.text);
// // //               if (verified) {
// // //                 await setLoginStatus();
// // //                 showAnimatedToast("OTP Verified!");
// // //                 if (mounted) {
// // //                   _animateToHomeScreen();
// // //                 }
// // //               } else {
// // //                 showAnimatedToast("Invalid OTP!");
// // //                 // Add shake animation for invalid OTP
// // //                 _shakeOtpInput();
// // //               }
// // //             }
// // //           } catch (e) {
// // //             print('Error verifying OTP: $e');
// // //             showAnimatedToast("Error verifying OTP");
// // //           }
// // //         },
// // //         style: ElevatedButton.styleFrom(
// // //           backgroundColor: Colors.transparent,
// // //           minimumSize: Size(1.sw, 55.h),
// // //           elevation: 0,
// // //           shape: RoundedRectangleBorder(
// // //             borderRadius: BorderRadius.circular(15.r),
// // //           ),
// // //         ),
// // //         child: Text(
// // //           "Verify OTP",
// // //           style: TextStyle(
// // //             fontSize: 18.sp,
// // //             fontWeight: FontWeight.bold,
// // //             color: Colors.white,
// // //             shadows: [
// // //               Shadow(
// // //                 color: Colors.black26,
// // //                 offset: const Offset(0, 2),
// // //                 blurRadius: 4,
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   void _animateToHomeScreen() {
// // //     Navigator.pushReplacement(
// // //       context,
// // //       PageRouteBuilder(
// // //         pageBuilder: (context, animation1, animation2) => HomeScreen(),
// // //         transitionsBuilder: (context, animation1, animation2, child) {
// // //           return Stack(
// // //             children: [
// // //               FadeTransition(
// // //                 opacity: animation1,
// // //                 child: child,
// // //               ),
// // //               SlideTransition(
// // //                 position: Tween<Offset>(
// // //                   begin: const Offset(0.0, 0.0),
// // //                   end: const Offset(-1.0, 0.0),
// // //                 ).animate(
// // //                   CurvedAnimation(
// // //                     parent: animation1,
// // //                     curve: Curves.easeInOut,
// // //                   ),
// // //                 ),
// // //                 child: Container(
// // //                   color: Colors.blue.shade800,
// // //                 ),
// // //               ),
// // //             ],
// // //           );
// // //         },
// // //         transitionDuration: const Duration(milliseconds: 800),
// // //       ),
// // //     );
// // //   }

// // //   void _shakeOtpInput() {
// // //     final AnimationController shakeController = AnimationController(
// // //       duration: const Duration(milliseconds: 500),
// // //       vsync: this,
// // //     );

// // //     final Animation<double> offsetAnimation = Tween(begin: 0.0, end: 1.0)
// // //         .chain(CurveTween(curve: ShakeCurve(count: 3)))
// // //         .animate(shakeController);

// // //     shakeController.addStatusListener((status) {
// // //       if (status == AnimationStatus.completed) {
// // //         shakeController.dispose();
// // //       }
// // //     });

// // //     shakeController.forward();
// // //   }
// // // }

// // // // Custom shake curve for invalid OTP animation
// // // class ShakeCurve extends Curve {
// // //   final int count;

// // //   const ShakeCurve({this.count = 3});

// // //   @override
// // //   double transformInternal(double t) {
// // //     return sin(count * 2 * pi * t) * (1 - t);
// // //   }
// // // }

// // // import 'package:email_otp/email_otp.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // // import 'package:fluttertoast/fluttertoast.dart';
// // // import 'package:shared_preferences/shared_preferences.dart';
// // // import 'package:animated_text_kit/animated_text_kit.dart';

// // // import '../home_screens/home_screens.dart';

// // // class LoginScreen extends StatefulWidget {
// // //   const LoginScreen({Key? key}) : super(key: key);

// // //   @override
// // //   State<LoginScreen> createState() => _LoginScreenState();
// // // }

// // // class _LoginScreenState extends State<LoginScreen>
// // //     with SingleTickerProviderStateMixin {
// // //   final TextEditingController emailController = TextEditingController();
// // //   final TextEditingController otpController = TextEditingController();
// // //   late AnimationController _fadeController;
// // //   late Animation<double> _fadeAnimation;
// // //   bool isLoading = false;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _fadeController = AnimationController(
// // //       duration: const Duration(milliseconds: 1500),
// // //       vsync: this,
// // //     );
// // //     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
// // //       CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
// // //     );
// // //     _fadeController.forward();
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _fadeController.dispose();
// // //     otpController.clear();
// // //     emailController.dispose();
// // //     super.dispose();
// // //   }

// // //   Future<void> setLoginStatus() async {
// // //     try {
// // //       final prefs = await SharedPreferences.getInstance();
// // //       await prefs.setBool('isLoggedIn', true);
// // //     } catch (e) {
// // //       print('Error setting login status: $e');
// // //       showToast("Error saving login status");
// // //     }
// // //   }

// // //   Future<void> _sendOtp() async {
// // //     if (emailController.text.isEmpty) {
// // //       showToast("Please enter an email");
// // //       return;
// // //     }

// // //     setState(() {
// // //       isLoading = true;
// // //     });

// // //     try {
// // //       // Check for specific email
// // //       if (emailController.text.trim() == 'sales@techflux.in') {
// // //         showToast("OTP has been sent Successfully!");
// // //         _showOtpDialog();
// // //       } else {
// // //         final sent = await EmailOTP.sendOTP(email: emailController.text);
// // //         if (sent) {
// // //           showToast("OTP has been sent Successfully!");
// // //           _showOtpDialog();
// // //         } else {
// // //           showToast("Failed to send OTP!");
// // //         }
// // //       }
// // //     } catch (e) {
// // //       print('Error sending OTP: $e');
// // //       showToast("Error sending OTP");
// // //     } finally {
// // //       setState(() {
// // //         isLoading = false;
// // //       });
// // //     }
// // //   }

// // //   void showToast(String message) {
// // //     Fluttertoast.showToast(
// // //       msg: message,
// // //       toastLength: Toast.LENGTH_SHORT,
// // //       gravity: ToastGravity.BOTTOM,
// // //       timeInSecForIosWeb: 1,
// // //       backgroundColor: Colors.green,
// // //       textColor: Colors.white,
// // //       fontSize: 16.sp,
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       body: Container(
// // //         decoration: BoxDecoration(
// // //           gradient: LinearGradient(
// // //             colors: [Colors.blue.shade200, Colors.white],
// // //             begin: Alignment.topCenter,
// // //             end: Alignment.bottomCenter,
// // //           ),
// // //         ),
// // //         child: SafeArea(
// // //           child: SingleChildScrollView(
// // //             physics: const BouncingScrollPhysics(),
// // //             child: Padding(
// // //               padding: EdgeInsets.symmetric(horizontal: 24.w),
// // //               child: FadeTransition(
// // //                 opacity: _fadeAnimation,
// // //                 child: Column(
// // //                   children: [
// // //                     // 50.h.heightBox,
// // //                     // Logo with hero animation
// // //                     SizedBox(
// // //                       height: 50,
// // //                     ),
// // //                     Hero(
// // //                       tag: 'app_logo',
// // //                       child: Image.asset(
// // //                         'assets/images/image_to_image.png',
// // //                         height: 190.h,
// // //                       ),
// // //                     ),
// // //                     // 20.h.heightBox,
// // //                     SizedBox(
// // //                       height: 20,
// // //                     ),

// // //                     // Animated welcome text
// // //                     AnimatedTextKit(
// // //                       animatedTexts: [
// // //                         TypewriterAnimatedText(
// // //                           'Welcome Back!',
// // //                           textStyle: TextStyle(
// // //                             fontSize: 32.sp,
// // //                             fontWeight: FontWeight.bold,
// // //                             color: Colors.black,
// // //                           ),
// // //                           speed: const Duration(milliseconds: 100),
// // //                         ),
// // //                       ],
// // //                       totalRepeatCount: 1,
// // //                     ),
// // //                     // 15.h.heightBox,
// // //                     SizedBox(
// // //                       height: 15,
// // //                     ),

// // //                     Center(
// // //                       // child: "Create & share your product catalogs easily!"
// // //                       //     .text
// // //                       //     .size(16.sp)
// // //                       //     .color(Colors.black)
// // //                       //     .fontWeight(FontWeight.w500)
// // //                       //     .make(),
// // //                       child: Text(
// // //                         "Create & share your product catalogs easily!",
// // //                         style: TextStyle(
// // //                             fontSize: 16.sp, fontWeight: FontWeight.bold),
// // //                       ),
// // //                     ),
// // //                     // 20.h.heightBox,
// // //                     SizedBox(
// // //                       height: 20,
// // //                     ),

// // //                     // Email input with animation
// // //                     TweenAnimationBuilder<double>(
// // //                       tween: Tween(begin: 0.0, end: 1.0),
// // //                       duration: const Duration(milliseconds: 800),
// // //                       builder: (context, value, child) {
// // //                         return Transform.translate(
// // //                           offset: Offset(0, (1 - value) * 50),
// // //                           child: Opacity(
// // //                             opacity: value,
// // //                             child: TextFormField(
// // //                               controller: emailController,
// // //                               decoration: InputDecoration(
// // //                                 hintText: "Enter your email",
// // //                                 prefixIcon: Icon(Icons.email,
// // //                                     color: Colors.blue.shade800),
// // //                                 border: OutlineInputBorder(
// // //                                   borderRadius: BorderRadius.circular(12.r),
// // //                                 ),
// // //                                 filled: true,
// // //                                 fillColor: Colors.blue.shade50,
// // //                               ),
// // //                               keyboardType: TextInputType.emailAddress,
// // //                             ),
// // //                           ),
// // //                         );
// // //                       },
// // //                     ),
// // //                     // 20.h.heightBox,
// // //                     SizedBox(
// // //                       height: 20,
// // //                     ),
// // //                     // Login button with animation
// // //                     TweenAnimationBuilder<double>(
// // //                       tween: Tween(begin: 0.0, end: 1.0),
// // //                       duration: const Duration(milliseconds: 1000),
// // //                       builder: (context, value, child) {
// // //                         return Transform.translate(
// // //                           offset: Offset(0, (1 - value) * 50),
// // //                           child: Opacity(
// // //                             opacity: value,
// // //                             child: ElevatedButton(
// // //                               onPressed: isLoading ? null : _sendOtp,
// // //                               style: ElevatedButton.styleFrom(
// // //                                 backgroundColor: Colors.blue.shade800,
// // //                                 minimumSize: Size(1.sw, 50.h),
// // //                                 shape: RoundedRectangleBorder(
// // //                                   borderRadius: BorderRadius.circular(12.r),
// // //                                 ),
// // //                                 elevation: 5,
// // //                               ),
// // //                               child: isLoading
// // //                                   ? SizedBox(
// // //                                       width: 24.w,
// // //                                       height: 24.w,
// // //                                       child: CircularProgressIndicator(
// // //                                         color: Colors.white,
// // //                                         strokeWidth: 3,
// // //                                       ),
// // //                                     )
// // //                                   : Text(
// // //                                       "Send OTP",
// // //                                       style: TextStyle(
// // //                                         fontSize: 18.sp,
// // //                                         fontWeight: FontWeight.bold,
// // //                                         color: Colors.white,
// // //                                       ),
// // //                                     ),
// // //                             ),
// // //                           ),
// // //                         );
// // //                       },
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   void _showOtpDialog() {
// // //     showGeneralDialog(
// // //       context: context,
// // //       barrierDismissible: true,
// // //       barrierLabel: '',
// // //       transitionDuration: const Duration(milliseconds: 400),
// // //       pageBuilder: (context, animation1, animation2) {
// // //         return Container();
// // //       },
// // //       transitionBuilder: (context, animation1, animation2, child) {
// // //         return ScaleTransition(
// // //           scale: Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(
// // //             parent: animation1,
// // //             curve: Curves.elasticOut,
// // //           )),
// // //           child: FadeTransition(
// // //             opacity:
// // //                 Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
// // //               parent: animation1,
// // //               curve: Curves.easeOut,
// // //             )),
// // //             child: Dialog(
// // //               shape: RoundedRectangleBorder(
// // //                 borderRadius: BorderRadius.circular(20.r),
// // //               ),
// // //               elevation: 0,
// // //               backgroundColor: Colors.transparent,
// // //               child: Container(
// // //                 padding: EdgeInsets.all(20.w),
// // //                 decoration: BoxDecoration(
// // //                   color: Colors.white,
// // //                   borderRadius: BorderRadius.circular(20.r),
// // //                   boxShadow: [
// // //                     BoxShadow(
// // //                       color: Colors.black12,
// // //                       blurRadius: 10,
// // //                       spreadRadius: 5,
// // //                     ),
// // //                   ],
// // //                 ),
// // //                 child: Column(
// // //                   mainAxisSize: MainAxisSize.min,
// // //                   children: [
// // //                     Text(
// // //                       "Enter the OTP",
// // //                       style: TextStyle(
// // //                         fontSize: 24.sp,
// // //                         fontWeight: FontWeight.bold,
// // //                         color: Colors.blue.shade800,
// // //                       ),
// // //                     ),
// // //                     // 20.h.heightBox,
// // //                     SizedBox(
// // //                       height: 20,
// // //                     ),
// // //                     TextFormField(
// // //                       controller: otpController,
// // //                       decoration: InputDecoration(
// // //                         hintText: "Enter OTP",
// // //                         border: OutlineInputBorder(
// // //                           borderRadius: BorderRadius.circular(12.r),
// // //                         ),
// // //                         filled: true,
// // //                         fillColor: Colors.blue.shade50,
// // //                       ),
// // //                       keyboardType: TextInputType.number,
// // //                       maxLength: 6,
// // //                       textAlign: TextAlign.center,
// // //                       style: TextStyle(
// // //                         fontSize: 24.sp,
// // //                         letterSpacing: 8,
// // //                         fontWeight: FontWeight.bold,
// // //                       ),
// // //                     ),
// // //                     SizedBox(
// // //                       height: 20,
// // //                     ),
// // //                     ElevatedButton(
// // //                       onPressed: () async {
// // //                         if (otpController.text.isEmpty) {
// // //                           showToast("Please enter the OTP");
// // //                           return;
// // //                         }

// // //                         try {
// // //                           // Check for specific email and OTP combination
// // //                           if (emailController.text.trim() ==
// // //                                   'sales@techflux.in' &&
// // //                               otpController.text.trim() == '678797') {
// // //                             await setLoginStatus();
// // //                             showToast("Login Successful!");
// // //                             if (mounted) {
// // //                               Navigator.pushReplacement(
// // //                                 context,
// // //                                 PageRouteBuilder(
// // //                                   pageBuilder:
// // //                                       (context, animation1, animation2) =>
// // //                                           HomeScreen(),
// // //                                   transitionsBuilder:
// // //                                       (context, animation1, animation2, child) {
// // //                                     return FadeTransition(
// // //                                         opacity: animation1, child: child);
// // //                                   },
// // //                                   transitionDuration:
// // //                                       const Duration(milliseconds: 500),
// // //                                 ),
// // //                               );
// // //                             }
// // //                           } else {
// // //                             // For other emails, verify OTP normally
// // //                             final verified =
// // //                                 EmailOTP.verifyOTP(otp: otpController.text);
// // //                             if (verified) {
// // //                               await setLoginStatus();
// // //                               showToast("OTP Verified!");
// // //                               if (mounted) {
// // //                                 Navigator.pushReplacement(
// // //                                   context,
// // //                                   PageRouteBuilder(
// // //                                     pageBuilder:
// // //                                         (context, animation1, animation2) =>
// // //                                             HomeScreen(),
// // //                                     transitionsBuilder: (context, animation1,
// // //                                         animation2, child) {
// // //                                       return FadeTransition(
// // //                                           opacity: animation1, child: child);
// // //                                     },
// // //                                     transitionDuration:
// // //                                         const Duration(milliseconds: 500),
// // //                                   ),
// // //                                 );
// // //                               }
// // //                             } else {
// // //                               showToast("Invalid OTP!");
// // //                             }
// // //                           }
// // //                         } catch (e) {
// // //                           print('Error verifying OTP: $e');
// // //                           showToast("Error verifying OTP");
// // //                         }
// // //                       },
// // //                       style: ElevatedButton.styleFrom(
// // //                         backgroundColor: Colors.blue.shade800,
// // //                         minimumSize: Size(1.sw, 50.h),
// // //                         shape: RoundedRectangleBorder(
// // //                           borderRadius: BorderRadius.circular(12.r),
// // //                         ),
// // //                       ),
// // //                       child: Text(
// // //                         "Verify OTP",
// // //                         style: TextStyle(
// // //                           fontSize: 18.sp,
// // //                           fontWeight: FontWeight.bold,
// // //                           color: Colors.white,
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //         );
// // //       },
// // //     );
// // //   }
// // // }

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../requests/auth_requests.dart';
// import '../home_screens/home_screens.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen>
//     with SingleTickerProviderStateMixin {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController otpController = TextEditingController();
//   late AnimationController _fadeController;
//   late Animation<double> _fadeAnimation;
//   bool isLoading = false;
//   final AuthRequests _authRequests = AuthRequests();

//   // Define color scheme
//   final primaryColor = const Color(0xFF2A2D3E);
//   final accentColor = const Color(0xFF6C63FF);
//   final backgroundColor = const Color(0xFFF5F5F7);

//   @override
//   void initState() {
//     super.initState();
//     _fadeController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     );
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
//     );
//     _fadeController.forward();
//   }

//   @override
//   void dispose() {
//     _fadeController.dispose();
//     emailController.dispose();
//     otpController.dispose();
//     super.dispose();
//   }

//   Future<void> setLoginStatus() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setBool('isLoggedIn', true);
//     } catch (e) {
//       print('Error setting login status: $e');
//       showAnimatedToast("Error saving login status");
//     }
//   }

//   void showAnimatedToast(String message) {
//     final overlay = Overlay.of(context);
//     final overlayEntry = OverlayEntry(
//       builder: (context) => Positioned(
//         bottom: 50.h,
//         left: 20.w,
//         right: 20.w,
//         child: TweenAnimationBuilder<double>(
//           tween: Tween(begin: 0.0, end: 1.0),
//           duration: const Duration(milliseconds: 500),
//           builder: (context, value, child) {
//             return Transform.translate(
//               offset: Offset(0, (1 - value) * 50),
//               child: Opacity(
//                 opacity: value,
//                 child: Container(
//                   padding:
//                       EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
//                   decoration: BoxDecoration(
//                     color: Colors.black87,
//                     borderRadius: BorderRadius.circular(25.r),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 8,
//                         offset: const Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Text(
//                     message,
//                     style: TextStyle(color: Colors.white, fontSize: 16.sp),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );

//     overlay.insert(overlayEntry);
//     Future.delayed(const Duration(seconds: 2), () {
//       overlayEntry.remove();
//     });
//   }

//   Future<void> _sendOtp() async {
//     if (emailController.text.isEmpty) {
//       showAnimatedToast("Please enter an email");
//       return;
//     }

//     setState(() {
//       isLoading = true;
//     });

//     try {
//       final response =
//           await _authRequests.emailOtp(emailController.text.trim());

//       if (response.status == 'success') {
//         showAnimatedToast("OTP has been sent successfully!");
//         _showOtpDialog();
//       } else {
//         showAnimatedToast(response.message);
//       }
//     } catch (e) {
//       print('Error sending OTP: $e');
//       showAnimatedToast("Error sending OTP");
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   void _verifyOtp() async {
//     if (otpController.text.isEmpty) {
//       showAnimatedToast("Please enter the OTP");
//       return;
//     }

//     try {
//       final response = await _authRequests.verifyOtp(
//         emailController.text.trim(),
//         otpController.text.trim(),
//       );

//       if (response.status == 'success') {
//         await setLoginStatus();
//         showAnimatedToast("Login Successful!");
//         if (mounted) {
//           Navigator.pushReplacement(
//             context,
//             PageRouteBuilder(
//               pageBuilder: (context, animation1, animation2) => HomeScreen(),
//               transitionsBuilder: (context, animation1, animation2, child) {
//                 return FadeTransition(opacity: animation1, child: child);
//               },
//               transitionDuration: const Duration(milliseconds: 500),
//             ),
//           );
//         }
//       } else {
//         showAnimatedToast(response.message);
//       }
//     } catch (e) {
//       print('Error verifying OTP: $e');
//       showAnimatedToast("Error verifying OTP");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               backgroundColor,
//               Colors.white,
//               backgroundColor,
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 24.w),
//               child: FadeTransition(
//                 opacity: _fadeAnimation,
//                 child: Column(
//                   children: [
//                     SizedBox(height: 50.h),
//                     _buildLogoSection(),
//                     SizedBox(height: 40.h),
//                     _buildWelcomeText(),
//                     SizedBox(height: 40.h),
//                     _buildLoginCard(),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLogoSection() {
//     return Hero(
//       tag: 'app_logo',
//       child: Container(
//         padding: EdgeInsets.all(20.w),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(30.r),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 20,
//               offset: const Offset(0, 10),
//             ),
//           ],
//         ),
//         child: Image.asset(
//           'assets/images/imagetoimage.png',
//           height: 120.h,
//         ),
//       ),
//     );
//   }

//   Widget _buildWelcomeText() {
//     return AnimatedTextKit(
//       animatedTexts: [
//         TypewriterAnimatedText(
//           'Transform Your Images',
//           textStyle: TextStyle(
//             fontSize: 28.sp,
//             fontWeight: FontWeight.bold,
//             color: primaryColor,
//             letterSpacing: 1.2,
//           ),
//           speed: const Duration(milliseconds: 100),
//         ),
//       ],
//       totalRepeatCount: 1,
//     );
//   }

//   Widget _buildLoginCard() {
//     return Container(
//       padding: EdgeInsets.all(24.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(30.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 20,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Text(
//             "Login to Continue",
//             style: TextStyle(
//               fontSize: 20.sp,
//               fontWeight: FontWeight.w600,
//               color: primaryColor,
//             ),
//           ),
//           SizedBox(height: 24.h),
//           _buildEmailInput(),
//           SizedBox(height: 24.h),
//           _buildLoginButton(),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmailInput() {
//     return Container(
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(15.r),
//       ),
//       child: TextFormField(
//         controller: emailController,
//         decoration: InputDecoration(
//           hintText: "Enter your email",
//           hintStyle: TextStyle(color: primaryColor.withOpacity(0.5)),
//           prefixIcon: Icon(Icons.email, color: accentColor),
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15.r),
//             borderSide: BorderSide.none,
//           ),
//           filled: true,
//           fillColor: Colors.transparent,
//         ),
//         keyboardType: TextInputType.emailAddress,
//         style: TextStyle(color: primaryColor),
//       ),
//     );
//   }

//   Widget _buildLoginButton() {
//     return Container(
//       width: double.infinity,
//       height: 55.h,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15.r),
//         gradient: LinearGradient(
//           colors: [accentColor, accentColor.withOpacity(0.8)],
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: accentColor.withOpacity(0.3),
//             blurRadius: 15,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: ElevatedButton(
//         onPressed: isLoading ? null : _sendOtp,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.transparent,
//           shadowColor: Colors.transparent,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15.r),
//           ),
//         ),
//         child: isLoading
//             ? SizedBox(
//                 width: 24.w,
//                 height: 24.w,
//                 child: CircularProgressIndicator(
//                   color: Colors.white,
//                   strokeWidth: 3,
//                 ),
//               )
//             : Text(
//                 "Send OTP",
//                 style: TextStyle(
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//       ),
//     );
//   }

//   void _showOtpDialog() {
//     otpController.dispose();
//     showGeneralDialog(
//       context: context,
//       barrierDismissible: true,
//       barrierLabel: '',
//       transitionDuration: const Duration(milliseconds: 400),
//       pageBuilder: (context, animation1, animation2) {
//         return Container();
//       },
//       transitionBuilder: (context, animation1, animation2, child) {
//         return ScaleTransition(
//           scale: Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(
//             parent: animation1,
//             curve: Curves.elasticOut,
//           )),
//           child: FadeTransition(
//             opacity: animation1,
//             child: Dialog(
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//               child: Container(
//                 padding: EdgeInsets.all(24.w),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(30.r),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 20,
//                       offset: const Offset(0, 10),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(
//                       Icons.lock_outline,
//                       size: 48.w,
//                       color: accentColor,
//                     ),
//                     SizedBox(height: 16.h),
//                     Text(
//                       "Enter OTP",
//                       style: TextStyle(
//                         fontSize: 24.sp,
//                         fontWeight: FontWeight.bold,
//                         color: primaryColor,
//                       ),
//                     ),
//                     SizedBox(height: 8.h),
//                     Text(
//                       "Enter the verification code sent to your email",
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         color: primaryColor.withOpacity(0.6),
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: 24.h),
//                     _buildOtpInput(),
//                     SizedBox(height: 24.h),
//                     _buildVerifyButton(),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildOtpInput() {
//     return Container(
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(15.r),
//       ),
//       child: TextFormField(
//         controller: otpController,
//         decoration: InputDecoration(
//           hintText: "Enter 6-digit OTP",
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(15.r),
//             borderSide: BorderSide.none,
//           ),
//           filled: true,
//           fillColor: Colors.transparent,
//           counterText: "",
//         ),
//         keyboardType: TextInputType.number,
//         maxLength: 6,
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           fontSize: 24.sp,
//           letterSpacing: 8,
//           fontWeight: FontWeight.bold,
//           color: primaryColor,
//         ),
//       ),
//     );
//   }

//   Widget _buildVerifyButton() {
//     return Container(
//       width: double.infinity,
//       height: 55.h,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15.r),
//         gradient: LinearGradient(
//           colors: [accentColor, accentColor.withOpacity(0.8)],
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: accentColor.withOpacity(0.3),
//             blurRadius: 15,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: ElevatedButton(
//         onPressed: _verifyOtp,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.transparent,
//           shadowColor: Colors.transparent,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15.r),
//           ),
//         ),
//         child: Text(
//           "Verify OTP",
//           style: TextStyle(
//             fontSize: 18.sp,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../requests/auth_requests.dart';
import '../home_screens/home_screens.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  bool isLoading = false;
  final AuthRequests _authRequests = AuthRequests();

  // Updated color scheme for better visual appeal
  final primaryColor = Colors.black;
  final accentColor = const Color(0xFF6C63FF);
  final backgroundColor = const Color(0xFFF8F9FA);

  final String testEmail = 'sales@techflux.in';
  final String testOtp = '678797';

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    emailController.dispose();
    otpController.dispose();
    super.dispose();
  }

  Future<void> setLoginStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
    } catch (e) {
      debugPrint('Error setting login status: $e');
      if (mounted) showAnimatedToast("Error saving login status");
    }
  }

  void navigateToHome() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => HomeScreen(),
        transitionsBuilder: (context, animation1, animation2, child) {
          return FadeTransition(opacity: animation1, child: child);
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  void showAnimatedToast(String message) {
    if (!mounted) return;

    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50.h,
        left: 20.w,
        right: 20.w,
        child: Material(
          color: Colors.transparent,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 500),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, (1 - value) * 50),
                child: Opacity(
                  opacity: value,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(25.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      message,
                      style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 2), () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }

  Future<void> _sendOtp() async {
    if (emailController.text.isEmpty) {
      showAnimatedToast("Please enter an email");
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(emailController.text)) {
      showAnimatedToast("Please enter a valid email");
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Check for test email
      if (emailController.text.trim() == testEmail) {
        showAnimatedToast("OTP has been sent successfully!");
        _showOtpDialog();
        return;
      }

      final response =
          await _authRequests.emailOtp(emailController.text.trim());

      if (!mounted) return;

      if (response.status == 'success') {
        showAnimatedToast("OTP has been sent successfully!");
        _showOtpDialog();
      } else {
        showAnimatedToast(response.message);
      }
    } catch (e) {
      debugPrint('Error sending OTP: $e');
      if (mounted) showAnimatedToast("Error sending OTP");
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _verifyOtp() async {
    if (otpController.text.isEmpty) {
      showAnimatedToast("Please enter the OTP");
      return;
    }

    if (otpController.text.length != 6) {
      showAnimatedToast("Please enter a valid 6-digit OTP");
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();

      // Check for test credentials
      if (emailController.text.trim() == testEmail &&
          otpController.text.trim() == testOtp) {
        await setLoginStatus();
        await prefs.setString('user_email', emailController.text.trim());
        print(
            'Email saved (test login): ${emailController.text.trim()}'); // Proper logging
        showAnimatedToast("Login Successful!");
        await requestPermissions();
        navigateToHome();
        return;
      }

      final response = await _authRequests.verifyOtp(
        emailController.text.trim(),
        otpController.text.trim(),
      );

      if (!mounted) return;

      if (response.status == 'success') {
        await setLoginStatus();
        // Add email saving for regular login
        await prefs.setString('user_email', emailController.text.trim());
        print(
            'Email saved (regular login): ${emailController.text.trim()}'); // Proper logging
        showAnimatedToast("Login Successful!");
        await requestPermissions();
        navigateToHome();
      } else {
        showAnimatedToast(response.message);
      }
    } catch (e) {
      debugPrint('Error verifying OTP: $e');
      if (mounted) showAnimatedToast("Error verifying OTP");
    }
  }

  static Future<bool> requestPermissions() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo? androidInfo;

    try {
      androidInfo = await deviceInfo.androidInfo;
    } catch (e) {
      debugPrint('Error getting device info: $e');
      return false;
    }

    // For Android 13 and above (SDK 33+)
    if (androidInfo.version.sdkInt >= 33) {
      final photos = await Permission.photos.request();
      // final videos = await Permission.videos.request();
      // final audio = await Permission.audio.request();

      return photos.isGranted;
    }
    // For Android 10 and above (SDK 29-32)
    else if (androidInfo.version.sdkInt >= 29) {
      final storage = await Permission.storage.request();
      final accessMedia = await Permission.accessMediaLocation.request();

      return storage.isGranted && accessMedia.isGranted;
    }
    // For Android 9 and below
    else {
      final storage = await Permission.storage.request();
      return storage.isGranted;
    }
  }

  // Future<void> _requestPermissions() async {
  //   try {
  //     // Check and request storage permission
  //     if (!await Permission.storage.isGranted) {
  //       final storageStatus = await Permission.storage.request();
  //       if (storageStatus.isPermanentlyDenied) {
  //         _showPermissionDeniedDialog("Storage");
  //       }
  //     }

  //     // Check and request photos permission
  //     if (!await Permission.photos.isGranted) {
  //       final photosStatus = await Permission.photos.request();
  //       if (photosStatus.isPermanentlyDenied) {
  //         _showPermissionDeniedDialog("Photos");
  //       }
  //     }

  //     // Check and request media library permission (for iOS)
  //     if (!await Permission.mediaLibrary.isGranted) {
  //       final mediaLibraryStatus = await Permission.mediaLibrary.request();
  //       if (mediaLibraryStatus.isPermanentlyDenied) {
  //         _showPermissionDeniedDialog("Media Library");
  //       }
  //     }
  //   } catch (e) {
  //     print("Error requesting permissions: $e");
  //   }
  // }

  void _showPermissionDeniedDialog(String permission) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("$permission Permission Denied"),
        content: Text(
            "This app requires $permission permission to function properly. Please enable it in the app settings."),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          TextButton(
            child: Text("Open Settings"),
            onPressed: () {
              openAppSettings(); // Open app settings
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          height: screenHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                backgroundColor,
                Colors.white,
                backgroundColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: screenHeight - 60),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 40.h),
                      _buildLogoSection(),
                      // SizedBox(height: 30.h),
                      // _buildWelcomeText(),
                      SizedBox(height: 40.h),
                      _buildLoginCard(),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection() {
    return Hero(
      tag: 'app_logo',
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(
            color: Colors.red.shade200,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Image.asset(
          'assets/images/image_logo.png',
          height: 150.h,
          width: 150.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildLoginCard() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.red.shade300,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome Back",
            style: TextStyle(
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "Sign in with your email to continue",
            style: TextStyle(
              fontSize: 14.sp,
              color: primaryColor,
            ),
          ),
          SizedBox(height: 24.h),
          _buildEmailInput(),
          SizedBox(height: 24.h),
          _buildLoginButton(),
        ],
      ),
    );
  }

  Widget _buildEmailInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Email Address",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(
              color: primaryColor.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: "Enter your email",
              hintStyle: TextStyle(color: primaryColor.withOpacity(0.5)),
              prefixIcon: Icon(
                Icons.email_outlined,
                color: Colors.red.shade200,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.transparent,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            ),
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: primaryColor),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      height: 55.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: Color.fromARGB(255, 215, 70, 70),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.3),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : _sendOtp,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          padding: EdgeInsets.zero,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: isLoading
              ? SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Continue with Email",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 20.w),
                  ],
                ),
        ),
      ),
    );
  }

  void _showOtpDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation1, animation2) => Container(),
      transitionBuilder: (context, animation1, animation2, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(CurvedAnimation(
            parent: animation1,
            curve: Curves.elasticOut,
          )),
          child: FadeTransition(
            opacity: animation1,
            child: Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: accentColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.lock_outline_rounded,
                          size: 32.w,
                          color: Colors.red.shade200,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        "Enter Verification Code",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "We've sent a verification code to",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: primaryColor.withOpacity(0.6),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        emailController.text,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: primaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24.h),
                      _buildOtpInput(),
                      SizedBox(height: 24.h),
                      _buildVerifyButton(),
                      SizedBox(height: 16.h),
                      TextButton(
                        onPressed: isLoading ? null : _sendOtp,
                        child: Text(
                          "Resend Code",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.red.shade200,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.red.shade200,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOtpInput() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: primaryColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: TextFormField(
        controller: otpController,
        decoration: InputDecoration(
          hintText: "• • • • • •",
          hintStyle: TextStyle(
            fontSize: 24.sp,
            letterSpacing: 8,
            color: primaryColor.withOpacity(0.3),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.transparent,
          counterText: "",
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        ),
        keyboardType: TextInputType.number,
        maxLength: 6,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24.sp,
          letterSpacing: 8,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        onChanged: (value) {
          if (value.length == 6) {
            FocusScope.of(context).unfocus();
          }
        },
      ),
    );
  }

  Widget _buildVerifyButton() {
    return Container(
      width: double.infinity,
      height: 55.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        gradient: LinearGradient(
          colors: [accentColor, accentColor.withOpacity(0.8)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _verifyOtp,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red.shade200,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Verify & Continue",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 8.w),
            Icon(Icons.arrow_forward, color: Colors.white, size: 20.w),
          ],
        ),
      ),
    );
  }
}
