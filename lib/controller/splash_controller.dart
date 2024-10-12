
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../app_data/data/local_data.dart';
import '../routes/app_pages.dart';
import 'app_base_controller/app_base_conroller.dart';

class SplashController extends AppBaseController{

  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 3));
    await checkLoginStatus();

  }

  Future<void> checkLoginStatus() async {
    bool isLogin = MySharedPref.getLoginStatus();
    if (isLogin) {
      // Get.offNamed(Routes.BOTTOMNAV);
    } else {
      Get.offNamed(Routes.STARTED);
    }
  }



}