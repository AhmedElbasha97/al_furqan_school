// ignore_for_file: file_names
import 'package:al_furqan_school/globals/CommonSetting.dart';
import 'package:al_furqan_school/services/api_client.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  final String _loginPath = 'login.php';

  Future<String?> login({
    String? userName,
    String? type,
    String? password,
  }) async {
    final token = await FirebaseMessaging.instance.getToken();

    try {
      final response = await ApiClient.instance.dio.get(
        _loginPath,
        queryParameters: {
          'type': type,
          'username': userName,
          'password': password,
          'token': token ?? '',
        },
      );

      if (response.data['status'] == 'true') {
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('id', response.data['info']['id'] ?? '');
        prefs.setString('name', response.data['info']['name'] ?? '');
        prefs.setString('type', type ?? '');

        // Store parent credentials with encryption (not plaintext).
        if (type == 'PARENTS') {
          await _secureStorage.write(key: 'usernameParent', value: userName);
          await _secureStorage.write(key: 'passwordParent', value: password);
        }

        if (type == 'STUDENT') {
          prefs.setString('class', response.data['info']['class'] ?? '');
        }

        return 'done';
      } else {
        return response.data['msg']?.toString() ?? 'حدث خطأ';
      }
    } on Exception {
      return 'حدث خطأ في الاتصال بالخادم';
    }
  }

  /// Clears all secure credentials from encrypted storage (call on sign-out).
  static Future<void> clearSecureCredentials() async {
    await _secureStorage.deleteAll();
  }
}
