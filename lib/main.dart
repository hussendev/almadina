import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'app/theme.dart';
import 'core/routes/app_routes.dart';
import 'data/models/user_model.dart';
import 'data/services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register adapters
  Hive.registerAdapter(UserModelAdapter());

  // Initialize services
  await initServices();

  runApp(const MyApp());
}

Future<void> initServices() async {
  await Get.putAsync(() => StorageService().init());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'المدينة',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          
          themeMode: ThemeMode.light,
          locale: const Locale('ar'),
          fallbackLocale: const Locale('ar'),
          translations: AppTranslations(),
          initialRoute: AppRoutes.SPLASH,
          getPages: AppRoutes.routes,
          defaultTransition: Transition.fadeIn,
        );
      },
    );
  }
}

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'ar': {
      'app_name': 'المدينة',
      'login': 'دخول',
      'register': 'تسجيل',
      // Add more translations as needed
    },
    'en': {
      'app_name': 'Al-Madina',
      'login': 'Login',
      'register': 'Register',
      // Add more translations as needed
    },
  };
}