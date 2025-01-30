// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_to_image/screens/splash_screens/splash_screens.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(375, 812),
//       minTextAdapt: true,
//       builder: (context, child) {
//         return MaterialApp(
//             title: 'Flutter Demo',
//             debugShowCheckedModeBanner: false,
//             theme: ThemeData(
//               scaffoldBackgroundColor: Colors.white,
//               colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//               useMaterial3: true,
//             ),
//             home: SplashScreens());
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_to_image/screens/splash_screens/splash_screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> setOptimalDisplayMode() async {
  final List<DisplayMode> supported = await FlutterDisplayMode.supported;
  final DisplayMode active = await FlutterDisplayMode.active;

  final List<DisplayMode> sameResolution = supported
      .where(
        (DisplayMode m) => m.width == active.width && m.height == active.height,
      )
      .toList()
    ..sort(
      (DisplayMode a, DisplayMode b) => b.refreshRate.compareTo(a.refreshRate),
    );

  final DisplayMode mostOptimalMode =
      sameResolution.isNotEmpty ? sameResolution.first : active;

  await FlutterDisplayMode.setPreferredMode(mostOptimalMode);
}

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Run all initialization tasks in parallel
  // MobileAds.instance.updateRequestConfiguration(
  //   RequestConfiguration(tagForChildDirectedTreatment: 1),
  // );
  // await MobileAds.instance.initialize();
  await Future.wait([
    SharedPreferences.getInstance(),
    MobileAds.instance.initialize(),
    setOptimalDisplayMode(),
  ]);
}

void main() async {
  await initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Define primary and secondary colors
  // static const Color primaryColor = Color(0xFF2193b0);
  // static const Color secondaryColor = Color(0xFF6dd5ed);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.red.shade300,
              primary: Colors.red.shade300,
              secondary: Colors.red.shade300,
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.red.shade300,
              foregroundColor: Colors.white,
            ),
            useMaterial3: true,
          ),
          home: const SplashScreens(),
        );
      },
    );
  }
}
