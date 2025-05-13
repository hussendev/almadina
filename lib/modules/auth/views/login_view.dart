import 'package:almadina/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/theme.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/assets_path.dart';
import '../../../core/routes/app_routes.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/loading_indicator.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_text_field.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              AssetsPath.loginBackground,
              width: 390.w,
              height: 990.h,
              fit: BoxFit.fill,
            ),
            _buildLoginForm(context),
            // if (controller.isLoading.value)
            //   const FullScreenLoader(
            //     message: 'جاري تسجيل الدخول...',
            //   ),
          ],
        ),
      )
      // body: Obx(() {
      //   return SafeArea(
      //     child: Stack(
      //       children: [
      //         Image.asset(
      //           AssetsPath.loginBackground,
      //           width: 390.w,
      //           height: 990.h,
      //           fit: BoxFit.fill,
      //         ),
      //
      //         // _buildLoginForm(context),
      //         // if (controller.isLoading.value)
      //         //   const FullScreenLoader(
      //         //     message: 'جاري تسجيل الدخول...',
      //         //   ),
      //       ],
      //     ),
      //   );
      // }),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.27),
            Form(
              child: Column(
                children: [
                  Row(),
                  SizedBox(
                    height: 60,
                    width: 275,
                    child: AuthTextField(
                      controller: controller.mobileController,
                      label: '',
                      hint: AppStrings.mobile,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 60,
                    width: 275,
                    child:  AuthTextField(
                      controller: controller.passwordController,
                      label: '',
                      hint: AppStrings.secretCode,
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Obx(
                    () => controller.isLoading.value ? CircularProgressIndicator() : SizedBox(
                      height: 52,
                      width: 275,
                      child:  CustomButton(
                        text: AppStrings.login,
                        onPressed: () => controller.login(),
                        type: ButtonType.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  _buildRegisterSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'نسيت كلمة المرور',
                style: TextStyle(
                  fontFamily: GoogleFonts.cairo().fontFamily,
            fontSize: 16,
            color: AppTheme.textColor,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          '||',
          style: TextStyle(
            fontFamily: GoogleFonts.cairo().fontFamily,
            fontSize: 16,
            color: AppTheme.textColor,
          ),
        ),
        TextButton(

          onPressed: () => Get.toNamed(AppRoutes.REGISTER),
          child: const Text(
            AppStrings.register,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}