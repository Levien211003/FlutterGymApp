import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gymapp/model/user.dart';

class AuthService {
  static const String baseUrl = 'http://10.20.15.158:7059/';

  // Lưu token vào SharedPreferences
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  // Lấy token từ SharedPreferences
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Lưu thông tin người dùng vào SharedPreferences
  static Future<void> saveUserInfo(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_info', jsonEncode(user.toJson()));
    await saveUserId(user.id); // Lưu ID người dùng
  }

  // Lấy thông tin người dùng từ SharedPreferences
  static Future<User?> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final userInfo = prefs.getString('user_info');
    if (userInfo != null) {
      return User.fromJson(jsonDecode(userInfo));
    }
    return null;
  }

  // Lưu ID người dùng vào SharedPreferences
  static Future<void> saveUserId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', id);
  }

  // Lấy ID người dùng từ SharedPreferences
  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  // Đăng nhập người dùng và lưu token cùng với thông tin người dùng
  static Future<void> loginUser(String username, String password) async {
    final url = Uri.parse('${baseUrl}api/Users/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Login response data: $responseData');

        if (responseData.containsKey('id') &&
            responseData.containsKey('username') &&
            responseData.containsKey('email') &&
            responseData.containsKey('token')) {

          final user = User.fromJson(responseData);
          await saveToken(user.token);
          await saveUserInfo(user); // Lưu thông tin người dùng và ID
          print('User logged in successfully');
        } else {
          print('Invalid response data: $responseData');
          throw Exception('Invalid response data');
        }
      } else {
        print('Failed to login user: ${response.statusCode} ${response.body}');
        throw Exception('Failed to login user');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  // Gửi yêu cầu đã xác thực với token
  static Future<void> makeAuthenticatedRequest() async {
    final token = await getToken();
    if (token == null) {
      print('No token found');
      return;
    }
    final url = Uri.parse('${baseUrl}api/Protected/securedata');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      print('Request successful: ${response.body}');
    } else {
      print('Request failed: ${response.statusCode} ${response.body}');
    }
  }
  static Future<void> logoutUser() async {
    final url = Uri.parse('${baseUrl}api/Users/logout');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Logout successful');

        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();
      } else {
        print('Failed to log out: ${response.statusCode} ${response.body}');
        throw Exception('Failed to log out');
      }
    } catch (e) {
      print('Error logging out: $e');
      throw Exception('Error logging out');
    }
  }}
