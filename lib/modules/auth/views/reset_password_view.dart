import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/theme.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/assets_path.dart';
import '../../shared/widgets/custom_button.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_text_field.dart';

class ResetPasswordView extends GetView<AuthController> {
  final String email;

  const ResetPasswordView({
    Key? key,
    required this.email,
  }) : super(key: key);

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
            _buildResetPasswordForm(context),
          ],
        ),
      ),
    );
  }

  Widget _buildResetPasswordForm(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),


            // Title
            Text(
              'إعادة تعيين كلمة المرور',
              style: TextStyle(
                fontFamily: GoogleFonts.cairo().fontFamily,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
                color: AppTheme.textColor,
              ),
            ),

            SizedBox(height: 15.h),

            // Description
            Text(
              'أدخل كلمة المرور الجديدة',
              style: TextStyle(
                fontFamily: GoogleFonts.cairo().fontFamily,
                fontSize: 16.sp,
                color: AppTheme.greyColor,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 10.h),

            Form(
              child: Column(
                children: [
                  Row(),

                  // New Password Input
                  SizedBox(
                    height: 60.h,
                    width: 275.w,
                    child: AuthTextField(
                      backgroundImage: AssetsPath.textFeildBackground,
                      controller: controller.newPasswordController,
                      label: '',
                      hint: 'كلمة المرور الجديدة',
                      obscureText: true,
                    ),
                  ),

                  SizedBox(height: 10.h),

                  // Confirm Password Input
                  SizedBox(
                    height: 60.h,
                    width: 275.w,
                    child: AuthTextField(
                      backgroundImage: AssetsPath.textFeildBackground,
                      controller: controller.confirmPasswordController,
                      label: '',
                      hint: 'تأكيد كلمة المرور',
                      obscureText: true,
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // Reset Password Button
                  Obx(
                        () => controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : SizedBox(
                      height: 52.h,
                      width: 275.w,
                      child: CustomButton(
                        fontSize: 20.sp,
                        text: 'تغيير',
                        onPressed: () => controller.resetPassword(email),
                      ),
                    ),
                  ),


                  // Password Requirements
                  // _buildPasswordRequirements(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordRequirements() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'متطلبات كلمة المرور:',
            style: TextStyle(
              fontFamily: GoogleFonts.cairo().fontFamily,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppTheme.textColor,
            ),
          ),
          SizedBox(height: 8.h),
          _buildRequirement('• على الأقل 8 أحرف'),
          _buildRequirement('• تحتوي على حرف كبير وصغير'),
          _buildRequirement('• تحتوي على رقم واحد على الأقل'),
          _buildRequirement('• تحتوي على رمز خاص (!@#\$%^&*)'),
        ],
      ),
    );
  }

  Widget _buildRequirement(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: GoogleFonts.cairo().fontFamily,
          fontSize: 12.sp,
          color: AppTheme.greyColor,
        ),
      ),
    );
  }
}