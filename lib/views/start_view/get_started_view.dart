import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khabar/utils/colors.dart';
import 'package:lottie/lottie.dart';

import '../../routes/app_pages.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/news.json',
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),
                AutoSizeText(
                  'Stay Informed!',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color:AppColors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Subtitle Text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: AutoSizeText(
                    'Get the latest news updates from trusted sources around the globe at your fingertips.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      textStyle:TextStyle(
                        fontSize: 16,
                        color: AppColors.black.withOpacity(0.6),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
      
                ElevatedButton(
                  onPressed: () {
                    Get.offNamed(Routes.NAVBAR);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 60,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    backgroundColor:AppColors.red,
                  ),
                  child: Text(
                    'Get Started',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 18,
                        color:AppColors.whit,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}