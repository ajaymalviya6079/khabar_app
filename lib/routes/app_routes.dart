part of 'app_pages.dart';


abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const STARTED = _Paths.STARTED;
  static const NAVBAR = _Paths.NAVBAR;
  static const DETAILS = _Paths.DETAILS;


}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash';
  static const STARTED = '/started';
  static const NAVBAR = '/navBar';
  static const DETAILS = '/details';


}
