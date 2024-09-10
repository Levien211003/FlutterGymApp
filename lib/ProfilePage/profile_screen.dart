import 'package:flutter/material.dart';
import 'package:gymapp/data/api.dart'; // Đảm bảo đường dẫn chính xác
import 'package:gymapp/model/user.dart'; // Đảm bảo đường dẫn chính xác
import 'package:gymapp/data/AuthService.dart'; // Đảm bảo đường dẫn chính xác
import 'package:gymapp/login/login_screen.dart';
import 'package:gymapp/ProfilePage/details_profile.dart'; // Đảm bảo đường dẫn chính xác
import 'package:gymapp/FavoritesPage/favorite_screen.dart'; // Đảm bảo đường dẫn chính xác
import 'package:gymapp/ProfilePage/setting_screen.dart'; // Đảm bảo đường dẫn chính xác

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? _user;
  bool _loading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    try {
      final apiService = ApiService();
      final user = await apiService.fetchUserById();
      setState(() {
        _user = user;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
        _errorMessage = 'Failed to load user information.';
        print('Error loading user info: $e');
      });
    }
  }

  Future<void> _logout() async {
    // Hiển thị hộp thoại xác nhận
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Đóng hộp thoại
                try {
                  await AuthService.logoutUser(); // Đăng xuất bằng AuthService

                  // Điều hướng đến màn hình đăng nhập và xóa tất cả các màn hình trước đó
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                        (route) => false,
                  );
                } catch (e) {
                  print('Error logging out: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Logout failed: $e')),
                  );
                }
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng hộp thoại mà không thực hiện đăng xuất
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        body: Center(child: Text(_errorMessage!)),
      );
    }

    if (_user == null) {
      return Scaffold(
        body: Center(child: Text('No user data available.')),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 852,
              decoration: BoxDecoration(
                color: Color(0xFF212020),
                borderRadius: BorderRadius.circular(0),
                border: Border.all(color: Colors.black, width: 0),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 30,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 289,
                      color: Color(0xFFB3A0FF),
                    ),
                  ),
                  Positioned(
                    top: 95,
                    left: MediaQuery.of(context).size.width / 2 - 62.5,
                    child: Container(
                      width: 125,
                      height: 125,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(96.96),
                      ),
                      child: ClipOval(
                        child: _user!.image != null
                            ? Image.network(
                          _user!.image!,
                          fit: BoxFit.cover,
                        )
                            : Image.asset(
                          "assets/images/avatar.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 61,
                    left: 23,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Color(0xFFE2F163),
                            size: 30,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'My Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 221,
                    left: MediaQuery.of(context).size.width / 2 - 50,
                    child: Column(
                      children: [
                        Text(
                          _user?.fullname ?? 'No Fullname',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          _user?.email ?? 'No Email',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 290,
                    left: 36,
                    child: Container(
                      width: MediaQuery.of(context).size.width - 72,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(0xFF896CFE),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _user?.weight != null
                                    ? '${_user!.weight!.toStringAsFixed(1)} Kg'
                                    : 'No Weight Data',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'League Spartan',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Weight',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'League Spartan',
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _user?.age != null
                                    ? '${_user!.age}'
                                    : 'No Age Data',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'League Spartan',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Years old',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'League Spartan',
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _user?.height != null
                                    ? '${_user!.height!.toStringAsFixed(1)} Cm'
                                    : 'No Height Data',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'League Spartan',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Height',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'League Spartan',
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 405,
                    left: 0,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildRow(Icons.account_circle, 'Profile'),
                        SizedBox(height: 10),
                        buildRow(Icons.favorite, 'Favorite'),
                        SizedBox(height: 10),
                        buildRow(Icons.settings, 'Setting'),
                        SizedBox(height: 10),
                        buildRow(Icons.announcement, 'Announcements'),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: _logout, // Thêm hành động đăng xuất khi nhấn vào 'Logout'
                          child: buildRow(Icons.exit_to_app, 'Logout'),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow(IconData icon, String title) {
    return GestureDetector(
      onTap: () {
        if (title == 'Profile') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DetailsProfile(user: _user!)),
          );
        } else if (title == 'Favorite') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FavoriteScreen()),
          );
        }
        else if (title == 'Setting') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingScreen()),
          );
        }else if (title == 'Announcements') {
          // Chuyển hướng đến màn hình thông báo
        } else if (title == 'Logout') {
          _logout(); // Thêm hành động đăng xuất khi nhấn vào 'Logout'
        }

      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: Color(0xFF896CFE),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Center nội dung theo chiều ngang
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
            SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
