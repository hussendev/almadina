import 'package:get/get.dart';

import '../models/user_model.dart';
import '../providers/api_provider.dart';
import '../services/storage_service.dart';

class AuthRepository {
  final ApiProvider _apiProvider = Get.put(ApiProvider());
  final StorageService _storageService = Get.find<StorageService>();

  Future<bool> isAuthenticated() async {
    return _storageService.hasToken();
  }

  Future<UserModel> login({
    required String phone,
    required String password,
  }) async {
    try {

      final response = await _apiProvider.login(phone, password);

      if (response.statusCode == 200) {
        final user = UserModel.fromJson(response.body['customer']);
        await _saveUserData(user);
        return user;
      } else {
        throw response.body['message'] ?? 'Login failed';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> register({
    required String firstName,
    required String secondName,
    required String mobile,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiProvider.register(firstName:firstName ,seceondName: secondName, mobile: mobile,email: email,password: password);
      if (response.statusCode == 201) {

        final user = UserModel.fromJson(response.body['customer']);
        await _saveUserData(user);
        return user;
      } else {
        throw response.body['message'] ?? 'Registration failed';
      }
    } catch (e) {
      rethrow;
    }
  }

  // Future<void> forgotPassword({required String mobile}) async {
  //   try {
  //     final response = await _apiProvider.forgotPassword(mobile);
  //
  //     if (response.statusCode != 200) {
  //       throw response.body['message'] ?? 'Failed to send reset code';
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
  //
  // Future<void> resetPassword({
  //   required String mobile,
  //   required String code,
  //   required String newPassword,
  // }) async {
  //   try {
  //     final response = await _apiProvider.resetPassword(mobile, code, newPassword);
  //
  //     if (response.statusCode != 200) {
  //       throw response.body['message'] ?? 'Failed to reset password';
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
  //
  Future<void> logout() async {
    try {
      // await _apiProvider.logout();
      await _clearUserData();
    } catch (e) {
      // Even if API fails, clear local data
      await _clearUserData();
      rethrow;
    }
  }

  Future<void> _saveUserData(UserModel user) async {
    await _storageService.saveUser(user);
    await _storageService.saveToken(user.password);
  }

  Future<void> _clearUserData() async {
    await _storageService.clearUserData();
  }

  UserModel? getUserData() {
    return _storageService.getUser();
  }
}