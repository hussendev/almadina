import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../app/theme.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/assets_path.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/loading_indicator.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
   HomeView({Key? key}) : super(key: key);

  final authController= Get.put(AuthRepository());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              AssetsPath.homeBackground,
              width: 390.w,
              height: 990.h,
              fit: BoxFit.fill,
            ),
            _buildHomeContent(context),
          ],
        ),
      ),

    );
  }

  Widget _buildHomeContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          SizedBox(
            height: 52,
            width: 275,
            child:  CustomButton(
              fontSize: 18.sp,
              text: AppStrings.home,
              onPressed: ()async =>await controller.launchURL('https://al-madenah.com/') ,
            ),
          ),
          SizedBox(height: 50.h),
          SizedBox(
            height: 52,
            width: 275,
            child:  CustomButton(
              fontSize: 18.sp,
              text: AppStrings.discount,
              onPressed: ()async =>await controller.launchURL('https://al-madenah.com/') ,
            ),
          ),
          SizedBox(height: 50.h),
          SizedBox(
            height: 52,
            width: 275,
            child:  CustomButton(
              fontSize: 18.sp,
              text: AppStrings.logout,
              onPressed: ()async{
                await authController.logout();
              },
              // onPressed: () => controller.login(),
            ),
          ),

        ],
      ),
    );
  }
}