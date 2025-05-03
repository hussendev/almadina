import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth_repository.dart';

class HomeController extends GetxController {
  final AuthRepository _authRepository;

  HomeController(this._authRepository);

  final isLoading = false.obs;
  final error = RxnString(null);
  final Rxn<UserModel> user = Rxn<UserModel>();

  final selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  void getUserData() {
    try {
      isLoading.value = true;
      user.value = _authRepository.getUserData();
    } catch (e) {
      error.value = e.toString();
      printError(info: 'Error getting user data: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;
      await _authRepository.logout();
      Get.offAllNamed(AppRoutes.LOGIN);
    } catch (e) {
      error.value = e.toString();
      Get.snackbar(
        'خطأ',
        'حدث خطأ أثناء تسجيل الخروج',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}