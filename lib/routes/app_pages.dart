import 'package:get/get.dart';
import 'package:khabar/routes/screen_bindings.dart';
import 'package:khabar/views/details/details_view.dart';
import 'package:khabar/views/start_view/get_started_view.dart';
import 'package:khabar/views/splash/splash_view.dart';
import 'package:khabar/widgets/bottom_navbar/bottom_navbar.dart';
part 'app_routes.dart';



class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: ScreenBindings(),
    ),
    GetPage(
      name: _Paths.STARTED,
      page: () => const GetStartedScreen(),
      binding: ScreenBindings(),
    ),

    GetPage(
      name: _Paths.NAVBAR,
      page: () => const CustomBottomNavigationBar(),
      binding: ScreenBindings(),
    ),


    GetPage(
      name: _Paths.DETAILS,
      page: () => const DetailView(),
      binding: ScreenBindings(),
    ),


  ];
}
