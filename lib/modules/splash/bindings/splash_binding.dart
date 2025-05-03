import 'package:get/get.dart';

import '../../../data/services/storage_service.dart';
import '../controllers/splash_controller.dart';
class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(StorageService(), permanent: true); // Use put instead of putAsync
    Get.put(SplashController());  // Use put instead of lazyPut
  }
}