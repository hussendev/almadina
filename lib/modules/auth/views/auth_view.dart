import 'package:almadina/main.dart';
import 'package:almadina/modules/auth/views/login_view.dart';
import 'package:almadina/modules/auth/views/register_view.dart';
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

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              Image.asset(
                AssetsPath.homeBackground,
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
                  const Row(),
                  CustomButton(
                    text: AppStrings.login,
                      fontSize: 20.sp,
                    onPressed: (){
                      Get.toNamed(
                        AppRoutes.LOGIN
                      );
                    },
                  ),

                   SizedBox(
                    height: 30.h
                  ),
                  CustomButton(

                    fontSize: 22.sp,
                    text: AppStrings.register,
                    onPressed: (){
                      Get.toNamed(
                          AppRoutes.REGISTER
                      );
                    },
                  ),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}