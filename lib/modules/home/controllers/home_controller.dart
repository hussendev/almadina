import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      // Show error message if URL couldn't be launched
      Get.snackbar(
        'خطأ',
        'لا يمكن فتح الرابط',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
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