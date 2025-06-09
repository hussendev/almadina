import 'package:almadina/core/routes/app_routes.dart';
import 'package:get/get.dart';

import '../../../data/services/storage_service.dart';

class SplashController extends GetxController {
  final _appService = Get.find<StorageService>();

  @override
  void onInit() {
    super.onInit();
    handleNavigation();
  }

  Future<void> handleNavigation() async {
    await Future.delayed(const Duration(seconds: 2)); // Splash screen duration

    if (_appService.isFirstTime()) {
      await _appService.setFirstTime(false);
      Get.offAllNamed(AppRoutes.Auth);
    } else {
      //check if user is logged in
      if (_appService.isLoggedIn()) {
        Get.offAllNamed(AppRoutes.HOME);
      } else {
        Get.offAllNamed(AppRoutes.Auth);
      }

    }
  }
}