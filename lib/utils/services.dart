//lib/service.dart
import "dart:convert";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;

class AppUtils {
  static const String baseApi = "http://localhost:8080/api/v1";
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

  static Future<Map<String, dynamic>> fetchUser() async {
    final response = await http.get(
      Uri.parse("$baseApi/user/read"), // Đường dẫn API fetchAllUser
      headers: <String, String>{
        'Content-Type': 'application/json', // Định dạng dữ liệu gửi đi
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Thất bại khi gọi API!');
    }
  }

// static Future<Map<String, dynamic>> fetchUser(String userId) async {
//   final response = await http.get(
//     Uri.parse("$baseApi/api/v1/user/read"), // Đường dẫn API fetchAllUser
//     headers: <String, String>{
//       'Content-Type': 'application/json', // Định dạng dữ liệu gửi đi
//     },
//   );

//   if (response.statusCode == 200) {
//     final List<dynamic> userList = jsonDecode(response.body);
//     // Lọc ra user đã đăng nhập
//     final Map<String, dynamic>? loggedInUser = userList.firstWhere((user) => user['userId'] == userId, orElse: () => null);
//     if (loggedInUser != null) {
//       return loggedInUser;
//     } else {
//       throw Exception('Không tìm thấy thông tin của user đã đăng nhập!');
//     }
//   } else {
//     throw Exception('Thất bại khi gọi API!');
//   }
// }
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

  static Future<Map<String, dynamic>> getListAllUser() async {
    final response = await http.get(Uri.parse("$baseApi/user/read"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Lấy dữ liệu thất bại!!");
    }
  }

  static Future<Map<String, dynamic>> HandleUpdate(String userId,
      String username, String address, String sex, String className) async {
    final response = await http.put(
      Uri.parse("$baseApi/user/update"),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'userId': userId,
        'username': username,
        'address': address,
        'sex': sex,
        'className': className,
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Cập nhật thất bại');
    }
  }
}
