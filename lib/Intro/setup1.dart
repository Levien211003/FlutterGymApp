import 'package:flutter/material.dart';
import 'package:gymapp/Intro/setup2.dart';
import 'package:gymapp/login/login_screen.dart';
import '../navbar.dart';
import 'package:gymapp/data/api.dart';

class Setup1 extends StatefulWidget {
  final int id;

  Setup1({required this.id});
  @override
  _Setup1State createState() => _Setup1State();
}

class _Setup1State extends State<Setup1> {
  PageController _controller = PageController();
  int _currentPage = 0;
  int _selectedAgeIndex = 12;

  final ApiService _apiService = ApiService(); // Thêm ApiService

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Lắng nghe sự thay đổi vị trí cuộn của ScrollController
    _scrollController.addListener(() {
      // Tính index của số tuổi được chọn dựa vào vị trí cuộn
      int index = (_scrollController.offset ~/ 100)
          .toInt(); // Đổi tùy theo khoảng cách mà con chọn
      setState(() {
        _selectedAgeIndex = index;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _navigateToSetup2() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Setup2(id: widget.id),
      ),
    );
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
            child: buildPage1(
              imagePath: 'assets/images/Setup1.png',
              title: 'No Pain No Gain.',
              title2: 'Don\'t Give Up!',
              title3: 'Kiên trì là',
              title4: 'Chìa khóa để tiến bộ.',
              buttonLabel: 'Tiếp Theo',
              buttonAction: _navigateToSetup2,
            ),
          ),
          // Thêm các trang khác ở đây nếu cần
        ],
      ),
    );
  }

  Widget buildPage1({
    required String imagePath,
    required String title,
    required String title2,
    required String title3,
    required String title4,
    required String buttonLabel,
    required VoidCallback buttonAction,
  }) {
    return Container(
      color: Colors.black,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Image.asset(
              imagePath,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 5, // 50% của màn hình
            child: Container(
              padding: EdgeInsets.all(0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    title2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 50, width: 50),
                  Container(
                    width: MediaQuery.of(context).size.width, // Chiều rộng bằng màn hình
                    color: Color(0xFF44462E),
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    child: Column(
                      children: <Widget>[
                        Text(
                          title3,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          title4,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: buttonAction,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black.withOpacity(0.8),
                      foregroundColor: Colors.white, // Màu chữ
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.white, width: 1.2), // Viền trắng
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    child: Text(
                      buttonLabel,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
