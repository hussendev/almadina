// import 'package:get/get.dart';
//
// import '../utils/app_theme.dart';
//
// class AppService extends GetxService {
//   static const String _firstTimeKey = 'first_time';
//   static const String _themeKey = 'is_dark_mode';
//   // late SharedPreferences _prefs;
//
//   // Observable for theme mode
//   final RxBool isDarkMode = false.obs;
//
//   Future<AppService> init() async {
//     // _prefs = await SharedPreferences.getInstance();
//
//     // Load saved theme mode
//     // isDarkMode.value = _prefs.getBool(_themeKey) ?? false;
//
//     return this;
//   }
//
//   // bool isFirstTime() {
//   //   return _prefs.getBool(_firstTimeKey) ?? true;
//   // }
//   //
//   // Future<void> setFirstTime(bool value) async {
//   //   await _prefs.setBool(_firstTimeKey, value);
//   // }
//   //
//   // // Save theme mode preference
//   // Future<void> saveThemeMode(bool isDark) async {
//   //   await _prefs.setBool(_themeKey, isDark);
//   //   isDarkMode.value = isDark;
//   //   Get.changeTheme(isDark ? AppTheme.darkTheme : AppTheme.lightTheme);
//   // }
//   //
//   // // Get saved theme mode
//   // bool getThemeMode() {
//   //   return _prefs.getBool(_themeKey) ?? false;
//   // }
// }