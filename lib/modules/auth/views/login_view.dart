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

          ],
        ),
      )

    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.25),
            Form(
              child: Column(
                children: [
                  Row(),
                  SizedBox(
                    height: 60.h,
                    width: 275.w,
                    child: AuthTextField(
                      backgroundImage: AssetsPath.textFeildBackground,
                      controller: controller.mobileController,
                      label: '',
                      hint: AppStrings.mobile,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                   SizedBox(height: 20.h),
                  SizedBox(
                    height: 60.h,
                    width: 275.w,
                    child:  AuthTextField(
                      backgroundImage: AssetsPath.textFeildBackground,
                      controller: controller.passwordController,
                      label: '',
                      hint: AppStrings.secretCode,
                      obscureText: true,
                    ),
                  ),
                   SizedBox(height: 25.h),
                  Obx(
                    () => controller.isLoading.value ? CircularProgressIndicator() :  CustomButton(
                      fontSize: 20.sp,
                      text: AppStrings.login,
                      onPressed: () => controller.login(),
                    ),
                  ),
                   SizedBox(height: 120.h),
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
    return  GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.FORGOT_PASSWORD);
      },
      child: Text(
        'نسيت كلمة المرور',
        style: TextStyle(
          fontFamily: GoogleFonts.cairo().fontFamily,
          fontSize: 20.sp,
          color: AppTheme.textColor,
        ),
      ),
    );
  }
}