import 'package:flutter/material.dart';
import 'package:gymapp/login/login_screen.dart';
import '../navbar.dart';
import 'package:gymapp/data/api.dart';
import 'setup5.dart'; // Import Setup5

class Setup4 extends StatefulWidget {
  final int id;

  Setup4({required this.id});
  @override
  _Setup4State createState() => _Setup4State();
}

class _Setup4State extends State<Setup4> {
  PageController _controller = PageController();
  int _currentPage = 0;
  int _selectedAgeIndex = 12; // Chỉ số tuổi được chọn (12 là giá trị mặc định)
  final ApiService _apiService = ApiService(); // Thêm ApiService

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
            child: buildPage4(
              title: 'Bạn Bao Nhiêu Tuổi?',
              buttonText: 'Tiếp Theo',
              buttonAction: () async {
                // Chọn giá trị tuổi từ chỉ số
                int selectedAge = _selectedAgeIndex + 10;

                // Cập nhật tuổi lên API
                try {
                  await _apiService.updateAge(widget.id, selectedAge);

                  // Chuyển đến Setup5 và truyền dữ liệu
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Setup5(
                        id: widget.id,
                        // Có thể thêm các tham số khác nếu cần
                      ),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to update age: $e')),
                  );
                }
              },
              content: buildAgeSelection(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage4({
    required String title,
    required String buttonText,
    required VoidCallback buttonAction,
    required Widget content,
  }) {
    return Container(
      color: Colors.black,
      child: Column(
        children: <Widget>[
          SizedBox(height: 200),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 150),
          Expanded(
            child: content,
          ),
          SizedBox(height: 200),
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
              buttonText,
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildAgeSelection() {
    List<String> ages = List.generate(91, (index) => (index + 10).toString());

    return Container(
      height: 70,
      color: Color(0xFFB3A0FF),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: ages.asMap().entries.map((entry) {
            int index = entry.key;
            String age = entry.value;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedAgeIndex = index;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _selectedAgeIndex == index ? Colors.yellow : Colors.transparent,
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  age,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
