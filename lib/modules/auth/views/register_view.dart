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

class RegisterView extends GetView<AuthController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Colors.transparent,
    //     elevation: 0,
    //     leading: IconButton(
    //       icon: const Icon(Icons.arrow_back_ios, color: AppTheme.textColor),
    //       onPressed: () => Get.back(),
    //     ),
    //   ),
    //   body: Obx(() {
    //     return SafeArea(
    //       child: Stack(
    //         children: [
    //           _buildRegisterForm(context),
    //           if (controller.isLoading.value)
    //             const FullScreenLoader(
    //               message: 'جاري التسجيل...',
    //             ),
    //         ],
    //       ),
    //     );
    //   }),
    // );

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
              _buildRegisterForm(context),
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

  Widget _buildRegisterForm(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.22),
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
                    child: AuthTextField(
                      controller: controller.mobileController,
                      label: '',
                      hint: AppStrings.name,
                      keyboardType: TextInputType.name,),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 60,
                    width: 275,
                    child: AuthTextField(
                      controller: controller.mobileController,
                      label: '',
                      hint: AppStrings.email,
                      keyboardType: TextInputType.name,),
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
                  SizedBox(
                    height: 52,
                    width: 275,
                    child:  CustomButton(
                      text: AppStrings.register,
                      onPressed: () => controller.login(),
                      type: ButtonType.primary,
                    ),
                  ),
                  const SizedBox(height: 60),
                  _buildLoginSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  Widget _buildLoginSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Text(
          AppStrings.alreadyHaveAccount,
          style: TextStyle(
            fontSize: 16,
            fontFamily: GoogleFonts.cairo().fontFamily,
            color: AppTheme.textColor,
          ),
        ),
        TextButton(
          onPressed: () => Get.offAllNamed(AppRoutes.LOGIN),
          child: const Text(
            AppStrings.login,
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