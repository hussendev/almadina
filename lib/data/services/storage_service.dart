import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../models/user_model.dart';

class StorageService extends GetxService {
  static const String _userBoxName = 'userBox';
  static const String _settingsBoxName = 'settingsBox';

  // User box keys
  static const String _userKey = 'user';
  static const String _tokenKey = 'token';
  static const String _isFirstTime = 'isFirstTime';

  // Settings box keys
  static const String _isDarkModeKey = 'isDarkMode';
  static const String _localeKey = 'locale';

  late Box<dynamic> _userBox;
  late Box<dynamic> _settingsBox;

  Future<StorageService> init() async {
    // Initialize Hive
    final appDocumentDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDir.path);

    // Register adapters
    // Hive.registerAdapter(UserModelAdapter());

    // Open boxes
    _userBox = await Hive.openBox<dynamic>(_userBoxName);
    _settingsBox = await Hive.openBox<dynamic>(_settingsBoxName);

    return this;
  }

  bool isFirstTime() {
    return _userBox.get(_isFirstTime) as bool? ?? true;

  }

  bool isLoggedIn() {
    return _userBox.get(_userKey) != null;
  }

  Future<void> setFirstTime(bool value) async {
    await _userBox.put(_isFirstTime, value);


  }

  // Token Management
  Future<void> saveToken(String token) async {
    await _userBox.put(_tokenKey, token);
  }

  String? getToken() {
    return _userBox.get(_tokenKey) as String?;
  }

  Future<void> removeToken() async {
    await _userBox.delete(_tokenKey);
  }

  bool hasToken() {
    return _userBox.containsKey(_tokenKey);
  }

  // User Management
  Future<void> saveUser(UserModel user) async {
    await _userBox.put(_userKey, user);
  }

  UserModel? getUser() {
    return _userBox.get(_userKey) as UserModel?;
  }

  Future<void> removeUser() async {
    await _userBox.delete(_userKey);
  }

  // Theme Management
  Future<void> saveDarkMode(bool isDarkMode) async {
    await _settingsBox.put(_isDarkModeKey, isDarkMode);
  }

  bool getDarkMode() {
    return _settingsBox.get(_isDarkModeKey, defaultValue: false) as bool;
  }

  // Locale Management
  Future<void> saveLocale(String locale) async {
    await _settingsBox.put(_localeKey, locale);
  }

  String getLocale() {
    return _settingsBox.get(_localeKey, defaultValue: 'ar') as String;
  }

  // Clear data
  Future<void> clearUserData() async {
    await _userBox.clear();
  }

  Future<void> clearAllData() async {
    await _userBox.clear();
    await _settingsBox.clear();
  }

  // Close boxes when app closes
  Future<void> closeBoxes() async {
    await _userBox.close();
    await _settingsBox.close();
  }
}