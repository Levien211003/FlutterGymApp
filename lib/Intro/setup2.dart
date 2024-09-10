import 'package:flutter/material.dart';
import 'package:gymapp/Intro/setup3.dart';
import 'package:gymapp/login/login_screen.dart';
import '../navbar.dart';
import 'package:gymapp/data/api.dart';

class Setup2 extends StatefulWidget {
  final int id;

  Setup2({required this.id});
  @override
  _Setup2State createState() => _Setup2State();
}

class _Setup2State extends State<Setup2> {
  PageController _controller = PageController();
  int _currentPage = 0;
  bool _isIcon1Selected = false;
  bool _isIcon2Selected = false;
  String _selectedGender = ""; // Lưu giới tính được chọn

  final ApiService _apiService = ApiService(); // Thêm ApiService

  void _navigateToSetup3() async {
    try {
      await _apiService.updateGender(widget.id, _selectedGender);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Setup3(
            id: widget.id,
          ),
        ),
      );
    } catch (e) {
      // Handle error, ví dụ: hiển thị thông báo lỗi
      print('Error updating gender: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _controller.nextPage(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            },
            child: buildPage2(
              imagePath: 'assets/images/Setup2.png',
              title: 'Giới Tính Của Bạn Là?',
              title3: 'Hãy cho chúng tôi biết thêm về bạn',
              buttonLabel: 'Tiếp Theo',
              buttonAction: _navigateToSetup3,
              iconPath1: 'assets/icons/gender1.png',
              iconPath2: 'assets/icons/gender2.png',
            ),
          ),
          // Thêm các trang khác ở đây nếu cần
        ],
      ),
    );
  }

  Widget buildPage2({
    required String imagePath,
    required String title,
    required String title3,
    required String buttonLabel,
    required VoidCallback buttonAction,
    required String iconPath1,
    required String iconPath2,
  }) {
    return Container(
      color: Colors.black,
      child: Column(
        children: <Widget>[
          SizedBox(height: 50),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: MediaQuery.of(context).size.width,
            color: Color(0xFF44462E),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              children: <Widget>[
                Text(
                  title3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.yellow,
                    fontStyle: FontStyle.italic,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Image.asset(
              imagePath,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isIcon1Selected = true;
                    _isIcon2Selected = false;
                    _selectedGender = "Male";
                  });
                },
                child: Image.asset(
                  iconPath1,
                  width: _isIcon1Selected ? 100 : 70,
                  height: _isIcon1Selected ? 100 : 70,
                ),
              ),
              SizedBox(width: 50),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isIcon1Selected = false;
                    _isIcon2Selected = true;
                    _selectedGender = "Female";
                  });
                },
                child: Image.asset(
                  iconPath2,
                  width: _isIcon2Selected ? 100 : 70,
                  height: _isIcon2Selected ? 100 : 70,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: buttonAction,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black.withOpacity(0.8),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Colors.white, width: 1.2),
              ),
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            ),
            child: Text(
              buttonLabel,
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
