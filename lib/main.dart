import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khabar/routes/app_pages.dart';
import 'package:khabar/routes/screen_bindings.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

import 'app_data/data/local_data.dart';



void main() async {

  runApp(const MyApp());
  await MySharedPref.init();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    /// Check if the app is running on the web
    if (kIsWeb) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        initialBinding: ScreenBindings(),
        title: 'Khabar App',
        theme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
          colorSchemeSeed: Colors.white,
        ),
      );
    } else {
      /// Check if the app is running on iOS or any other platform
      final isIOS = Platform.isIOS;
      if (isIOS) {
        return GetCupertinoApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          initialBinding: ScreenBindings(),
          title: 'Khabar App',
          theme: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
              textStyle: GoogleFonts.poppins(),
            ),
          ),
        );
      } else {
        return ScreenUtilInit(
          designSize: const Size(360, 640),
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
            initialBinding: ScreenBindings(),
            title: 'Khabar App',
            theme: ThemeData(
              useMaterial3: true,
              textTheme: GoogleFonts.poppinsTextTheme(
                Theme.of(context).textTheme,
              ),
              colorSchemeSeed: Colors.white,
            ),
          ),
        );
      }
    }
  }
}


