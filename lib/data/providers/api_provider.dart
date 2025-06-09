import 'dart:convert';
import 'package:get/get.dart';

import '../services/storage_service.dart';

class ApiProvider extends GetConnect {
  final String _baseUrl = 'https://al-madenah.com/api';

  @override
  void onInit() {
    httpClient.baseUrl = _baseUrl;
    httpClient.timeout = const Duration(seconds: 30);

    // Request modifiers
    httpClient.addRequestModifier<dynamic>((request) {
      final token = Get.find<StorageService>().getToken();
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'application/json';
      return request;
    });

    // Response modifiers
    httpClient.addResponseModifier((request, response) {
      printInfo(
        info: 'Status Code: ${response.statusCode}\n'
            'Data: ${response.bodyString?.substring(0, response.bodyString!.length > 100 ? 100 : response.bodyString!.length)}...',
      );

      return response;
    });

    super.onInit();
  }

  Future<Response> login(String phone, String password) async {
    final body = jsonEncode({
      'phone': phone,
      'password': password,
    });
    return await post('/customers/login', body);
  }

  Future<Response> register(
      {
        required String firstName,
        required String seceondName,
        required String email,
        required String mobile,
        required String password}) async {
    final body = jsonEncode({
      'first_name': firstName,
      'last_name': seceondName,
      'email': email,
      'phone': mobile,
      'password': password,
    });
    return await post('/customers/signup', body);
  }

  Future<Response> sendForgotPasswordOtp(String email) async {
    try {
      final response = await post(
        '/customers/forgot-code',
        {
          'email': email,
        },
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Reset password with OTP
  Future<Response> resetPassword({
    required String email,
    required String code,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final response = await post(
        '/customers/reset-password',
        {
          'email': email,
          'code': code,
          'password': password,
          'passwordConfirmation': passwordConfirmation,
        },
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
  Future<Response> logout() async {
    return await post('/auth/logout', null);
  }
  //
  // Future<Response> getUserProfile() async {
  //   return await get('/user/profile');
  // }
  //
  // Future<Response> updateUserProfile(Map<String, dynamic> data) async {
  //   return await put('/user/profile', jsonEncode(data));
  // }
}