import 'package:flutter_test_sample/RouteDetail/routes.dart';
import 'package:flutter_test_sample/RouteDetail/screens/loginscreen/login_view.dart';
import 'package:flutter_test_sample/RouteDetail/screens/second_screen/second_screen.dart';
import 'package:get/get.dart';

class AppPages {
  static const initialRoute = Routes.login;
  static final routes = [
    GetPage(name: Routes.login, page: () => LoginScreen()),
    GetPage(name: Routes.secondScreen, page: () => SecondScreen()),

  ];
}
