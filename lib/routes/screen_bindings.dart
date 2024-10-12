import 'package:get/get.dart';
import 'package:khabar/controller/details_controller.dart';
import 'package:khabar/controller/home_controller.dart';

import '../controller/splash_controller.dart';



class ScreenBindings implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut(() => SplashController() );
    Get.lazyPut(() => HomeController() );
    Get.lazyPut(() => DetailsController());


  }


}