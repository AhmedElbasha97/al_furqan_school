// ignore_for_file: file_names
import 'package:al_furqan_school/models/new/requests.dart';
import 'package:al_furqan_school/services/api_client.dart';

class ContactUsService {
  Future<String?> sendComplain(
    String name,
    String message,
    String email,
    String subject,
    String mobile,
  ) async {
    try {
      final response = await ApiClient.instance.dio.post(
        'contact.php',
        queryParameters: {
          'name': name,
          'email': email,
          'subject': subject,
          'message': message,
          'mobile': mobile,
        },
      );
      return Requsts.fromJson(response.data).status;
    } on Exception {
      return null;
    }
  }
}
