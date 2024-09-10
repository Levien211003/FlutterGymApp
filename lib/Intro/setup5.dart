import 'package:flutter/material.dart';
import 'package:gymapp/login/login_screen.dart';
import '../navbar.dart';
import 'package:gymapp/data/api.dart';
import 'setup6.dart'; // Import Setup6

class Setup5 extends StatefulWidget {
  final int id;

  Setup5({
    required this.id,
  });

  @override
  _Setup5State createState() => _Setup5State();
}

class _Setup5State extends State<Setup5> {
  PageController _controller = PageController();
  int _currentPage = 0;

  int _selectedWeightIndex = 0; // Chỉ số cân nặng được chọn
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
            child: buildPage5(
              title: 'Chọn Cân Nặng',
              buttonText: 'Tiếp Theo',
              buttonAction: () async {
                // Lấy cân nặng từ chỉ số
                double selectedWeight = _selectedWeightIndex + 50.0;

                // Gọi API để cập nhật cân nặng
                try {
                  await _apiService.updateWeight(widget.id, selectedWeight);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Setup6(
                        id: widget.id,
                        // Truyền các dữ liệu cần thiết
                      ),
                    ),
                  );
                } catch (e) {
                  // Xử lý lỗi nếu cần
                  print('Failed to update weight: $e');
                }
              },
              content: buildWeightSelection(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage5({
    required String title,
    required String buttonText,
    required VoidCallback buttonAction,
    required Widget content,
  }) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Colors.white, width: 1.2),
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

  Widget buildWeightSelection() {
    List<String> weights = List.generate(
        200, (index) => (index + 50).toString() + ' KG');

    return Container(
      height: 70,
      color: Color(0xFFB3A0FF),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: weights
              .asMap()
              .entries
              .map((entry) {
            int index = entry.key;
            String weight = entry.value;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedWeightIndex = index;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _selectedWeightIndex == index
                      ? Colors.yellow
                      : Colors.transparent,
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  weight,
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
