import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app_data/constant.dart';
import '../../controller/splash_controller.dart';


class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: -150,
              right: -150,
              child: Container(
                width: 300,
                height: 300,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Constants.logo, width:180, height:180).animate().fade().slideY(
                      duration: 500.ms,
                      begin: 1, curve: Curves.easeInSine
                    ),
                  AutoSizeText(
                    'News Update',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ).animate().fade().slideY(
                      duration: 500.ms,
                      begin: 1, curve: Curves.easeInSine
                  ),
                  // App tagline
                  const SizedBox(height: 8),
                  AutoSizeText(
                    'Your News.\nYour Language.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ).animate().fade().slideY(
                      duration: 500.ms,
                      begin: 1, curve: Curves.easeInSine
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



