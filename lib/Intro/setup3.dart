import 'package:flutter/material.dart';
import 'package:gymapp/login/login_screen.dart';
import '../navbar.dart';
import 'package:gymapp/data/api.dart';
import 'setup4.dart'; // Import Setup4

class Setup3 extends StatefulWidget {
  final int id;

  Setup3({required this.id});
  @override
  _Setup3State createState() => _Setup3State();
}

class _Setup3State extends State<Setup3> {
  PageController _controller = PageController();
  int _currentPage = 0;
  bool _isIcon1Selected = false;
  bool _isIcon2Selected = false;
  String _selectedGender = ""; // Lưu giới tính được chọn
  String _selectedMucTieu = ""; // Thêm biến này để lưu mục tiêu

  int _selectedButtonIndex = -1;
  int _selectedAgeIndex = 12;
  int _selectedWeightIndex = 50;
  int _selectedHeightIndex = 150;
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
            child: buildPage3(
              title: 'Mục Tiêu Của Bạn Là Gì?',
              buttonLabel: 'Tiếp Theo',
                buttonAction: () async {
                  try {
                    await _apiService.updateGoal(widget.id, _selectedMucTieu);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Setup4(id: widget.id),
                      ),
                    );
                  } catch (e) {
                    // Thông báo lỗi hoặc log lỗi
                    print('Error updating MucTieu: $e');
                  }
                }
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage3({
    required String title,
    required String buttonLabel,
    required VoidCallback buttonAction,
  }) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 130),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.yellow,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 90),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width, // Chiều rộng bằng màn hình
              color: Color(0xFF44462E),
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Căn giữa theo chiều dọc
                children: <Widget>[
                  buildSelectableButton('Giảm Cân', 0),
                  buildSelectableButton('Xây Dựng Cơ Bắp', 1),
                  buildSelectableButton('Giữ Dáng', 2),
                ],
              ),
            ),
          ),
          SizedBox(height: 120),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
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
          ),
        ],
      ),
    );
  }

  Widget buildSelectableButton(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedButtonIndex = index;
          _selectedMucTieu = title; // Cập nhật mục tiêu khi người dùng chọn
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: _selectedButtonIndex == index ? Colors.blue : Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: _selectedButtonIndex == index ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
