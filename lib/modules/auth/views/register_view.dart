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
            SizedBox(height: MediaQuery.of(context).size.height * 0.22),
            Form(
              child: Column(
                children: [
                  Row(),
                  SizedBox(
                    height: 60,
                    width: 275,
                    child: AuthTextField(
                      controller: controller.registerMobileController,
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
                      controller: controller.firstNameController,
                      label: '',
                      hint: AppStrings.firstName,
                      keyboardType: TextInputType.name,),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 60,
                    width: 275,
                    child: AuthTextField(
                      controller: controller.secondNameController,
                      label: '',
                      hint: AppStrings.secondName,
                      keyboardType: TextInputType.name,),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 60,
                    width: 275,
                    child: AuthTextField(
                      controller: controller.emailController,
                      label: '',
                      hint: AppStrings.email,
                      keyboardType: TextInputType.name,),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 60,
                    width: 275,
                    child:  AuthTextField(
                      controller: controller.registerPasswordController,
                      label: '',
                      hint: AppStrings.secretCode,
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(height: 25),
                  Obx(
                    () => controller.isLoading.value ? CircularProgressIndicator(): SizedBox(
                      height: 52,
                      width: 275,
                      child:  CustomButton(
                        text: AppStrings.register,
                        onPressed: () => controller.register(),
                        type: ButtonType.primary,
                      ),
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