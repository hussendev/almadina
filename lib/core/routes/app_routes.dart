import 'package:almadina/modules/auth/views/auth_view.dart';
import 'package:get/get.dart';

import '../../modules/auth/bindings/auth_binding.dart';
import '../../modules/auth/views/forgot_password_view.dart';
import '../../modules/auth/views/login_view.dart';
import '../../modules/auth/views/register_view.dart';
import '../../modules/home/bindings/home_binding.dart';
import '../../modules/home/views/home_view.dart';
import '../../modules/splash/bindings/splash_binding.dart';
import '../../modules/splash/views/splash_view.dart';

class AppRoutes {
  static const SPLASH = '/splash';
  static const Auth = '/auth';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const FORGOT_PASSWORD = '/forgot-password';
  static const HOME = '/home';
  static const PROFILE = '/profile';
  static const SETTINGS = '/settings';

  static final routes = [
    GetPage(
      name: SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Auth,
      page: () => const AuthView(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: LOGIN,
      page: () => const LoginView(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
    ),
    GetPage(
      name: REGISTER,
      page: () => const RegisterView(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: HOME,
      page: () =>  HomeView(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}