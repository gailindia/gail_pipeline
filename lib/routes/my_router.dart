import 'package:gail_pipeline/controller/binding/homebinding.dart';
import 'package:gail_pipeline/ui/homeScreen.dart';
import 'package:gail_pipeline/ui/login_screen.dart';
import 'package:gail_pipeline/ui/splash_screen.dart';
import 'package:get/get.dart';

// class MyRouter {
//   static var welcomeScreen = "/welcomeScreen";
//   static var loginScreen = "/loginScreen";
//   static var homeScreen = "/homeScreen";

//   static var route = [
//     GetPage(name: '/', page: () => SplashScreen()), 
//     GetPage(name: MyRouter.loginScreen, page: () => LoginScreen()),
//     GetPage(name: MyRouter.homeScreen, page: () => Homescreen()),
//   ];
// }

class MyRouter {
  static var splashScreen = "/";
  static var loginScreen = "/loginScreen";
  static var homeScreen = "/homeScreen";

  static var route = [
    GetPage(name: MyRouter.splashScreen, page: () => SplashScreen()),
    GetPage(name: MyRouter.loginScreen, page: () => LoginScreen()),
    GetPage(
      name: MyRouter.homeScreen,
      page: () => Homescreen(),
      binding: HomeBinding(),  
    ),
  ];
}
