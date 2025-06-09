import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth_repository.dart';
import '../views/otp_verification_view.dart';
import '../views/reset_password_view.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository;

  AuthController(this._authRepository);

  final isLoading = false.obs;
  String _otpCode = '';
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


  // Forgot Password Controllers
  final forgotPasswordEmailController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  // OTP Controllers (4 digits)
  late List<TextEditingController> otpControllers;
  late List<FocusNode> otpFocusNodes;



  // Forgot Password Observables
  var resetEmailSent = false.obs;
  var otpTimer = 0.obs;

  @override
  void onInit() {
    super.onInit();
    otpControllers = List.generate(4, (index) => TextEditingController());
    otpFocusNodes = List.generate(4, (index) => FocusNode());
    checkAuthStatus();
  }

  // Forgot Password Methods
  Future<void> sendResetOtp() async {
    if (forgotPasswordEmailController.text.isEmpty) {
      Get.snackbar(
        'خطأ',
        'يرجى إدخال البريد الإلكتروني',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Basic email validation
    if (!GetUtils.isEmail(forgotPasswordEmailController.text)) {
      Get.snackbar(
        'خطأ',
        'يرجى إدخال بريد إلكتروني صحيح',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      // Call the real API to send OTP to email
      await _authRepository.sendForgotPasswordOtp(
        email: forgotPasswordEmailController.text,
      );

      Get.snackbar(
        'تم الإرسال',
        'تم إرسال رمز التحقق إلى بريدك الإلكتروني',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );

      // Navigate to OTP verification screen
      Get.to(() => OtpVerificationView(email: forgotPasswordEmailController.text));

      // Start timer
      _startOtpTimer();

    } catch (e) {
      Get.snackbar(
        'خطأ',
        e.toString().contains('message') ? e.toString() : 'حدث خطأ أثناء إرسال رمز التحقق',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp() async {
    String otp = otpControllers.map((controller) => controller.text).join();

    if (otp.length != 4) {
      Get.snackbar(
        'خطأ',
        'يرجى إدخال رمز التحقق كاملاً',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Store the OTP for later use in password reset
    _otpCode = otp;

    Get.snackbar(
      'تم التحقق',
      'يمكنك الآن إدخال كلمة المرور الجديدة',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    // Navigate to reset password screen
    Get.off(() => ResetPasswordView(email: forgotPasswordEmailController.text));
  }

  Future<void> resendOtp(String email) async {
    try {
      isLoading.value = true;

      // Call the real API to resend OTP
      await _authRepository.sendForgotPasswordOtp(email: email);

      Get.snackbar(
        'تم الإرسال',
        'تم إعادة إرسال رمز التحقق',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Clear OTP fields
      _clearOtpFields();

      // Restart timer
      _startOtpTimer();

    } catch (e) {
      Get.snackbar(
        'خطأ',
        e.toString().contains('message') ? e.toString() : 'حدث خطأ أثناء إعادة الإرسال',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword(String email) async {
    // Validation
    if (newPasswordController.text.isEmpty) {
      Get.snackbar(
        'خطأ',
        'يرجى إدخال كلمة المرور الجديدة',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (confirmPasswordController.text.isEmpty) {
      Get.snackbar(
        'خطأ',
        'يرجى تأكيد كلمة المرور',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'خطأ',
        'كلمة المرور غير متطابقة',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (newPasswordController.text.length < 8) {
      Get.snackbar(
        'خطأ',
        'كلمة المرور يجب أن تكون 8 أحرف على الأقل',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    try {
      isLoading.value = true;

      // Call the real API to reset password
      await _authRepository.resetPassword(
        email: email,
        code: _otpCode,
        password: newPasswordController.text,
        passwordConfirmation: confirmPasswordController.text,
      );

      Get.snackbar(
        'تم التغيير',
        'تم تغيير كلمة المرور بنجاح',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );

      // Clear all controllers
      _clearForgotPasswordControllers();

      // Navigate back to login (remove all previous screens)
      Get.offAllNamed(AppRoutes.LOGIN);

    } catch (e) {
      Get.snackbar(
        'خطأ',
        e.toString().contains('message') ? e.toString() : 'حدث خطأ أثناء تغيير كلمة المرور',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _startOtpTimer() {
    otpTimer.value = 120; // 2 minutes
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (otpTimer.value > 0) {
        otpTimer.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void _clearOtpFields() {
    for (var controller in otpControllers) {
      controller.clear();
    }
    for (var focusNode in otpFocusNodes) {
      focusNode.unfocus();
    }
  }


  void _clearForgotPasswordControllers() {
    forgotPasswordEmailController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
    _clearOtpFields();
    resetEmailSent.value = false;
    otpTimer.value = 0;
    _otpCode = '';
  }

  @override
  void onClose() {
    mobileController.dispose();
    passwordController.dispose();
    forgotPasswordEmailController.dispose();
    firstNameController.dispose();
    secondNameController.dispose();
    emailController.dispose();
    registerMobileController.dispose();
    registerPasswordController.dispose();
    forgotPasswordEmailController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();

    // Dispose OTP controllers
    for (var controller in otpControllers) {
      controller.dispose();
    }
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
