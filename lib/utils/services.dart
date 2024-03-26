//lib/service.dart
import "dart:convert";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;

class AppUtils {
  static const String baseApi = "http://172.19.200.147:8080/api/v1";
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
      Uri.parse("$baseApi/user/read"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Thất bại khi gọi API!');
    }
  }

  static Future<Map<String, dynamic>> getUserByID(String userId) async {
    final response = await http
        .post(Uri.parse("$baseApi/user/getById"), headers: <String, String>{
      'ContentType': 'application/json',
    }, body: <String, String>{
      'userId': userId,
    });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Tìm người thất bại');
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
    // print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Cập nhật thất bại');
    }
  }

  static Future<Map<String, dynamic>> getTablePoint(String role) async {
    try {
      final responsePoint = await http.get(
        Uri.parse("$baseApi/point/read"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      final responseSubject = await http.get(
        Uri.parse("$baseApi/subject/read"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      if (responsePoint.statusCode == 200 &&
          responseSubject.statusCode == 200) {
        final pointData = jsonDecode(responsePoint.body)['DT'];
        final subjectData = jsonDecode(responseSubject.body)['DT'];

        final userPoints =
            pointData.where((point) => point['userId'] == role).toList();

        final subjectMap = Map.fromIterable(
          subjectData,
          key: (subject) => subject['subjectId'],
          value: (subject) => subject['subjectName'],
        );

        for (var point in userPoints) {
          final subjectId = point['subjectId'];
          point['subjectName'] = subjectMap[subjectId];
        }

        return {'points': userPoints};
      } else {
        throw Exception('Thất bại khi gọi API!');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }
}
