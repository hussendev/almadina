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

            ],
          ),
        )
    );
  }

  Widget _buildRegisterForm(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            Form(
              child: Column(
                children: [
                  Row(),
                  SizedBox(
                    height: 60.h,
                    width: 275.w,
                    child: AuthTextField(
                      backgroundImage: AssetsPath.textFeildBackground,
                      controller: controller.registerMobileController,
                      label: '',
                      hint: AppStrings.mobile,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                   SizedBox(height: 15.h),
                  SizedBox(
                    height:60.h,
                    width: 275.w,
                    child: AuthTextField(
                      backgroundImage: AssetsPath.textFeildBackground,
                      controller: controller.firstNameController,
                      label: '',
                      hint: AppStrings.firstName,
                      keyboardType: TextInputType.name,),
                  ),
                   SizedBox(height: 15.h),
                  SizedBox(
                    height: 60.h,
                    width: 275.w,
                    child: AuthTextField(
                      backgroundImage: AssetsPath.textFeildBackground,
                      controller: controller.emailController,
                      label: '',
                      hint: AppStrings.email,
                      keyboardType: TextInputType.name,),
                  ),
                   SizedBox(height: 15.h),
                  SizedBox(
                    height: 60.h,
                    width: 275.w,
                    child:  AuthTextField(
                      backgroundImage: AssetsPath.textFeildBackground,
                      controller: controller.registerPasswordController,
                      label: '',
                      hint: AppStrings.secretCode,
                      obscureText: true,
                    ),
                  ),
                   SizedBox(height: 20.h),
                  Obx(
                    () => controller.isLoading.value ? const CircularProgressIndicator(): SizedBox(
                      height: 52.h,
                      width: 275.w,
                      child:  CustomButton(
                        fontSize: 22.sp,
                        text: AppStrings.register,
                        onPressed: () => controller.register(),
                      ),
                    ),
                  ),
                  // _buildLoginSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}