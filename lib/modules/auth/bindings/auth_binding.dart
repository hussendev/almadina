import 'package:get/get.dart';

import '../../../data/repositories/auth_repository.dart';
import '../controllers/auth_controller.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepository());
    Get.put(AuthController(Get.find<AuthRepository>()), permanent: true,);
  }
}