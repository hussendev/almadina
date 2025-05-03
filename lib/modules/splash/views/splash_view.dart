import 'package:almadina/core/constants/app_strings.dart';
import 'package:almadina/core/constants/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        AssetsPath.splashBackground,
        width: 390.w,
        height: 990.h,
        fit: BoxFit.fill,
      ),
    );
  }
}