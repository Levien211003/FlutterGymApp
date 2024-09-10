import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gymapp/model/user.dart';
import 'package:gymapp/model/plan.dart';
import 'package:gymapp/model/nutri.dart';
import 'package:gymapp/data/AuthService.dart';


class ApiService {
  final String baseUrl = "http://10.20.15.158:7059/";

  Future<int> registerUser(String username, String email, String password) async {
    final url = Uri.parse('${baseUrl}api/Users/register');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        // Lấy id từ phản hồi JSON
        final responseData = jsonDecode(response.body);
        return responseData['id'];
      } else {
        print('Failed to register user: ${response.statusCode} ${response.body}');
        throw Exception('Failed to register user');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  // Phương thức gửi thông tin bổ sung
  //setup2
  Future<void> updateGender(int id, String gender) async {
    final url = Uri.parse('${baseUrl}api/Users/$id/gender');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(gender),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to update gender');
    }
  }

//setup3
  Future<void> updateGoal(int id, String goal) async {
    final url = Uri.parse('${baseUrl}api/Users/$id/MucTieu');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(goal),
    );

    if (response.statusCode == 204) {
      // No Content: Thành công
      print('Goal updated successfully.');
    } else if (response.statusCode == 404) {
      // Not Found: Người dùng không tồn tại
      throw Exception('User not found');
    } else {
      // Lỗi khác
      throw Exception('Failed to update goal');
    }
  }
//setup4
  Future<void> updateAge(int id, int age) async {
    final url = Uri.parse('${baseUrl}api/Users/$id/Age');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(age),
    );

    if (response.statusCode == 204) {
      // No Content: Thành công
      print('Age updated successfully.');
    } else if (response.statusCode == 404) {
      // Not Found: Người dùng không tồn tại
      throw Exception('User not found');
    } else {
      // Lỗi khác
      throw Exception('Failed to update age');
    }
  }
//setup5
  Future<void> updateWeight(int id, double weight) async {
    final response = await http.put(
      Uri.parse('${baseUrl}api/Users/$id/Weight'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(weight),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to update weight');
    }
  }
  //setup6
  Future<void> updateHeight(int id, double height) async {
    final response = await http.put(
      Uri.parse('${baseUrl}api/Users/$id/Height'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(height),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to update weight');
    }
  }
//setup7
  Future<void> updateLevel(int id, String level) async {
    final response = await http.put(
      Uri.parse('${baseUrl}api/Users/$id/Level'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(level),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to update level');
    }
  }
//setup8
  Future<void> updateUser(int id, String fullname, String nickname, String mobileNumber, String image) async {
    final response = await http.put(
      Uri.parse('${baseUrl}api/users/$id/DetailUser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'fullname': fullname,
        'nickname': nickname,
        'mobileNumber': mobileNumber,
        'image': image,
      }),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to update user');
    }
  }

  Future<User?> fetchUserById() async {
    try {
      final id = await AuthService.getUserId();
      if (id == null) {
        throw Exception('User ID not found');
      }

      final token = await AuthService.getToken();
      if (token == null) {
        throw Exception('Auth token not found');
      }

      final url = Uri.parse('${AuthService.baseUrl}api/Users/$id');
      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final userJson = jsonDecode(response.body);
        return User.fromJson(userJson);
      } else {
        throw Exception('Failed to load user by ID');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }


  // Phương thức lấy danh sách người dùng
  Future<List<User>> fetchUsers() async {
    final url = Uri.parse('${baseUrl}api/Users');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  Future<void> loginUser(String username, String password) async {
    final url = Uri.parse('${baseUrl}api/Users/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final token = responseData['Token'];
        final user = User.fromJson(responseData); // Đảm bảo User.fromJson xử lý tất cả các thuộc tính
        await AuthService.saveToken(token); // Lưu token vào SharedPreferences
        await AuthService.saveUserInfo(user); // Lưu thông tin người dùng vào SharedPreferences
        print('User logged in successfully');
      } else {
        print('Failed to login user: ${response.statusCode} ${response.body}');
        throw Exception('Failed to login user');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  Future<void> makeAuthenticatedRequest() async {
    final token = await AuthService.getToken();
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

  Future<void> updateFavoriteStatus(int id, bool favorite) async {
    final url = Uri.parse('${baseUrl}api/PlanList/$id');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'favorite': favorite,
        }),
      );
      if (response.statusCode == 200) {
        print('Favorite status updated successfully');
      } else {
        print(
            'Failed to update favorite status: ${response.statusCode} ${response
                .body}');
        throw Exception('Failed to update favorite status');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }


  Future<List<Plan>> fetchPlans() async {
    final url = Uri.parse('${baseUrl}api/Planlist');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Plan.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load plans');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }
  Future<List<Plan>> fetchPlansByLevel(String level) async {
    final response = await http.get(Uri.parse('${baseUrl}api/PlanList/level/$level'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((data) => Plan.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load plans');
    }
  }

  Future<void> updateFavoriteStatusNutri(int id, bool favorite) async {
    final url = Uri.parse('${baseUrl}api/NutriList/$id');
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'favorite': favorite,
        }),
      );
      if (response.statusCode == 200) {
        print('Favorite status updated successfully');
      } else {
        print(
            'Failed to update favorite status: ${response.statusCode} ${response
                .body}');
        throw Exception('Failed to update favorite status');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  Future<List<Nutri>> fetchNutriList() async {
    final url = Uri.parse('${baseUrl}api/NutriList');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        print(data);
        print('Fetched Nutri List: $data'); // In dữ liệu JSON trả về
        return data.map((json) => Nutri.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load nutri list');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  // danh sách plaa yêu thích
  Future<List<Plan>> fetchFavoritePlans() async {
    final url = Uri.parse('${baseUrl}api/Favorite/plans');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Plan.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load favorite plans');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }

  // danh sách Nutri yêu thích
  Future<List<Nutri>> fetchFavoriteNutris() async {
    final url = Uri.parse('${baseUrl}api/Favorite/nutris');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Nutri.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load favorite nutris');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }
}