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

class ForgotPasswordView extends GetView<AuthController> {
  const ForgotPasswordView({Key? key}) : super(key: key);

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
            _buildForgotPasswordForm(context),
          ],
        ),
      ),
    );
  }

  Widget _buildForgotPasswordForm(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.22),

            // Title
            Text(
              'نسيت كلمة المرور',
              style: TextStyle(
                fontFamily: GoogleFonts.cairo().fontFamily,
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: AppTheme.textColor,
              ),
            ),

            SizedBox(height: 20.h),

            // Description
            Text(
              'أدخل البريد الإلكتروني لإرسال رمز التحقق',
              style: TextStyle(
                fontFamily: GoogleFonts.cairo().fontFamily,
                fontSize: 16.sp,
                color: AppTheme.greyColor,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 40.h),

            Form(
              child: Column(
                children: [
                  Row(),

                  // Email Input
                  SizedBox(
                    height: 60.h,
                    width: 275.w,
                    child: AuthTextField(
                      backgroundImage: AssetsPath.textFeildBackground,
                      controller: controller.forgotPasswordEmailController,
                      label: '',
                      hint: AppStrings.email,
                      keyboardType: TextInputType.emailAddress,
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // Send Reset Link Button
                  Obx(
                        () => controller.isLoading.value
                        ? CircularProgressIndicator()
                        : SizedBox(
                      height: 52.h,
                      width: 275.w,
                      child: CustomButton(
                        fontSize: 20.sp,
                        text: 'إرسال',
                        onPressed: () => controller.sendResetOtp(),
                      ),
                    ),
                  ),

                  SizedBox(height: 40.h),

                  SizedBox(height: 50.h),

                  // Back to Login
                  _buildBackToLoginSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackToLoginSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'تذكرت كلمة المرور؟',
          style: TextStyle(
            fontFamily: GoogleFonts.cairo().fontFamily,
            fontSize: 16.sp,
            color: AppTheme.textColor,
          ),
        ),
        TextButton(
          onPressed: () => Get.back(),
          child: Text(
            'تسجيل الدخول',
            style: TextStyle(
              fontFamily: GoogleFonts.cairo().fontFamily,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}