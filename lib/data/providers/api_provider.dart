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

  Future<Response> forgotPassword(String email) async {
    final body = jsonEncode({
      'email': email,
    });
    return await post('/customers/forgot-password', body);
  }

  // Future<Response> resetPassword(String mobile, String code, String newPassword) async {
  //   final body = jsonEncode({
  //     'mobile': mobile,
  //     'code': code,
  //     'new_password': newPassword,
  //   });
  //   return await post('/auth/reset-password', body);
  // }
  //
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