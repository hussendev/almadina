import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository;

  AuthController(this._authRepository);

  final isLoading = false.obs;
  final error = RxnString(null);
  final Rxn<UserModel> user = Rxn<UserModel>();

  // Form controllers for login
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();

  // Form controllers for register
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final registerMobileController = TextEditingController();
  final emailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final secretCodeController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    checkAuthStatus();
  }

  @override
  void onClose() {
    mobileController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    secondNameController.dispose();
    emailController.dispose();
    registerMobileController.dispose();
    registerPasswordController.dispose();
    secretCodeController.dispose();
    super.onClose();
  }

  Future<void> checkAuthStatus() async {
    try {
      final isAuthenticated = await _authRepository.isAuthenticated();
      if (isAuthenticated) {
        user.value = _authRepository.getUserData();
        Get.offAllNamed(AppRoutes.HOME);
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }

  Future<void> login() async {
    // Get.offAllNamed(AppRoutes.HOME);
    if (mobileController.text.isEmpty || passwordController.text.isEmpty) {
      error.value = 'الرجاء إدخال جميع البيانات المطلوبة';
      return;
    }

    try {
      isLoading.value = true;
      error.value = null;

      final result = await _authRepository.login(
        phone: mobileController.text,
        password: passwordController.text,
      );

      user.value = result;
      clearLoginForm();

      Get.offAllNamed(AppRoutes.HOME);
      Get.snackbar(
        'نجاح',
        'تم تسجيل الدخول بنجاح',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      error.value = e.toString();
      Get.snackbar(
        'خطأ',
        error.value ?? 'حدث خطأ أثناء تسجيل الخروج',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void clearLoginForm() {
    mobileController.clear();
    passwordController.clear();
  }

  void clearRegisterForm() {
    firstNameController.clear();
    secondNameController.clear();
    registerMobileController.clear();
    emailController.clear();
    registerPasswordController.clear();
    secretCodeController.clear();
  }


  Future<void> register() async {
    print(registerMobileController.text.isEmpty);
    // print(firstNameController.text.isEmpty ||secondNameController.text.isEmpty||emailController.text.isEmpty||
    //     registerMobileController.text.isEmpty ||
    //     registerPasswordController.text.isEmpty);
    if (firstNameController.text.isEmpty ||secondNameController.text.isEmpty||emailController.text.isEmpty||
        registerMobileController.text.isEmpty ||
        registerPasswordController.text.isEmpty) {
      error.value = 'الرجاء إدخال جميع البيانات المطلوبة';
      return;
    }

    try {
      isLoading.value = true;
      error.value = null;

      final result = await _authRepository.register(
        firstName: firstNameController.text,
        secondName: secondNameController.text,
        mobile: registerMobileController.text,
        email: emailController.text,
        password: registerPasswordController.text,
      );

      user.value = result;
      clearRegisterForm();

      Get.offAllNamed(AppRoutes.HOME);
      Get.snackbar(
        'نجاح',
        'تم التسجيل بنجاح',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      error.value = e.toString();
      print(error.value);
      Get.snackbar(
        'خطأ',
        error.value ?? 'حدث خطأ أثناء التسجيل',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }



  // Future<void> forgotPassword(String mobile) async {
  //   if (mobile.isEmpty) {
  //     error.value = 'الرجاء إدخال رقم الجوال';
  //     return;
  //   }
  //
  //   try {
  //     isLoading.value = true;
  //     error.value = null;
  //
  //     await _authRepository.forgotPassword(mobile: mobile);
  //
  //     Get.snackbar(
  //       'نجاح',
  //       'تم إرسال رمز التحقق إلى رقم الجوال',
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.green,
  //       colorText: Colors.white,
  //     );
  //   } catch (e) {
  //     error.value = e.toString();
  //     Get.snackbar(
  //       'خطأ',
  //       error.value ?? 'حدث خطأ أثناء إرسال رمز التحقق',
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> logout() async {
    try {
      isLoading.value = true;
      error.value = null;

      await _authRepository.logout();
      user.value = null;

      Get.offAllNamed(AppRoutes.LOGIN);
      Get.snackbar(
        'نجاح',
        'تم تسجيل الخروج بنجاح',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      error.value = e.toString();
      Get.snackbar(
        'خطأ',
        error.value ?? 'حدث خطأ أثناء تسجيل الخروج',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;


    }
  }
}
