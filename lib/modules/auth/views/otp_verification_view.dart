import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/theme.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/assets_path.dart';
import '../../shared/widgets/custom_button.dart';
import '../controllers/auth_controller.dart';
import '../widgets/auth_text_field.dart';

class OtpVerificationView extends GetView<AuthController> {
  final String email;

  const OtpVerificationView({
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
            _buildOtpForm(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpForm(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.20),


            // Title
            Text(
              'التحقق من الرمز',
              style: TextStyle(
                fontFamily: GoogleFonts.cairo().fontFamily,
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: AppTheme.textColor,
              ),
            ),

            SizedBox(height: 15.h),

            // Description
            Text(
              'تم إرسال رمز التحقق إلى',
              style: TextStyle(
                fontFamily: GoogleFonts.cairo().fontFamily,
                fontSize: 16.sp,
                color: AppTheme.greyColor,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 8.h),

            // Email Display
            Text(
              email,
              style: TextStyle(
                fontFamily: GoogleFonts.cairo().fontFamily,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 40.h),

            Form(
              child: Column(
                children: [
                  Row(),

                  // OTP Input Fields
                  _buildOtpInputs(context),

                  SizedBox(height: 30.h),

                  // Verify Button
                  Obx(
                        () => controller.isLoading.value
                        ? CircularProgressIndicator()
                        : SizedBox(
                      height: 52.h,
                      width: 275.w,
                      child: CustomButton(
                        fontSize: 20.sp,
                        text: 'تحقق',
                        onPressed: () => controller.verifyOtp(),
                      ),
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // Timer and Resend
                  _buildResendSection(),

                  SizedBox(height: 40.h),

                  // Back button
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      'العودة للخلف',
                      style: TextStyle(
                        fontFamily: GoogleFonts.cairo().fontFamily,
                        fontSize: 16.sp,
                        color: AppTheme.greyColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpInputs(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (index) {
        return Container(
          width: 45.w,
          height: 55.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFFE8DCC0).withOpacity(0.7),
            border: Border.all(
              color: const Color(0xFFD4C5A0).withOpacity(0.8),
              width: 1,
            ),
          ),
          child: TextFormField(
            controller: controller.otpControllers[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            autofocus: index == 0,
            maxLength: 1,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF5D4E37),
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              counterText: '',
              contentPadding: EdgeInsets.zero,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (value) {
              if (value.isNotEmpty) {
                // Move to next field if not the last one
                if (index < 3) {
                  FocusScope.of(context).nextFocus();
                }
                if (index == 3) {
                  bool allFilled = controller.otpControllers.every((c) => c.text.isNotEmpty);
                  if (allFilled) {
                    controller.verifyOtp();
                  }
                }
              } else {
                if (index > 0) {
                  FocusScope.of(context).previousFocus();
                }
              }
            },
            onTap: () {
              // Clear the field when tapped for better UX
              controller.otpControllers[index].selection = TextSelection.fromPosition(
                TextPosition(offset: controller.otpControllers[index].text.length),
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildResendSection() {
    return Obx(
          () => Column(
        children: [
          if (controller.otpTimer.value > 0)
            Text(
              'إعادة الإرسال خلال ${controller.otpTimer.value} ثانية',
              style: TextStyle(
                fontFamily: GoogleFonts.cairo().fontFamily,
                fontSize: 14.sp,
                color: AppTheme.greyColor,
              ),
            )
          else
            Column(
              children: [
                Text(
                  'لم تستلم الرمز؟',
                  style: TextStyle(
                    fontFamily: GoogleFonts.cairo().fontFamily,
                    fontSize: 14.sp,
                    color: AppTheme.greyColor,
                  ),
                ),
                SizedBox(height: 8.h),
                TextButton(
                  onPressed: () => controller.resendOtp(email),
                  child: Text(
                    'إعادة الإرسال',
                    style: TextStyle(
                      fontFamily: GoogleFonts.cairo().fontFamily,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}