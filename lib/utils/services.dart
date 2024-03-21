import "dart:convert";
import "package:http/http.dart" as http;

class AppUtils {
  static const String baseApi = "http://localhost:8080/api/v1";
  static Future<Map<String, dynamic>> registerUser(
      String username, String phoneNumber, String password) async {
    final response = await http
        .post(Uri.parse("$baseApi/register"), headers: <String, String>{
      'ContentType': 'application/json',
      'Access-Control-Allow-Origin': 'true'
    }, body: <String, String>{
      'userId': username,
      'username': username,
      'phone': phoneNumber,
      'password': password
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Đăng ký thất bại!!');
    }
  }
}
