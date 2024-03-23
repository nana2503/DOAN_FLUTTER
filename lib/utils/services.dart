import "dart:convert";
// import "dart:ffi";
import "package:http/http.dart" as http;

class AppUtils {
  static const String baseApi = "http://192.168.1.50:8080/api/v1";
  static Future<Map<String, dynamic>> registerUser(
      String username, String phoneNumber, String password) async {
    final response = await http
        .post(Uri.parse("$baseApi/register"), headers: <String, String>{
      'ContentType': 'application/json',
    }, body: <String, String>{
      'userId': username,
      'username': username,
      'phone': phoneNumber,
      'password': password
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Đăng ký thất bại!');
    }
  }

  static Future<Map<String, dynamic>> hanldeLogin(
      String valueLogin, String password) async {
    final response =
        await http.post(Uri.parse("$baseApi/login"), headers: <String, String>{
      'ContentType': 'application/json',
    }, body: <String, String>{
      'valueLogin': valueLogin,
      'password': password
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Đăng nhập thất bại');
    }
  }

  static Future<Map<String, dynamic>> handleLogout() async {
    final response = await http.post(Uri.parse("$baseApi/logout"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Lỗi đăng xuất!!!');
    }
  }

  static Future<Map<String, dynamic>> HandleUpdate(
      String userId,
      String phone,
      String username,
      String password,
      String address,
      String sex,
      String classId) async {
    final response = await http.post(Uri.parse("$baseApi/update"),
        headers: <String, String>{
          'ContentType': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'userId': userId,
          'phone': phone,
          'username': username,
          'password': password,
          'address': address,
          'sex': sex,
          'class': classId
        }));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Đăng nhập thất bại');
    }
  }
}
