import 'package:flutter/material.dart';
import 'package:gymapp/data/api.dart';
import 'setup7.dart'; // Import Setup7

class Setup6 extends StatefulWidget {
  final int id;

  Setup6({required this.id});

  @override
  _Setup6State createState() => _Setup6State();
}

class _Setup6State extends State<Setup6> {
  PageController _controller = PageController();
  int _currentPage = 0;
  int _selectedHeightIndex = 0; // Đổi giá trị mặc định nếu cần
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
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
            child: buildPage6(
              title: 'Chọn Chiều Cao',
              buttonText: 'Tiếp Theo',
              buttonAction: () async {
                // Tính toán chiều cao từ index được chọn
                double selectedHeight = _selectedHeightIndex + 150.0;

                try {
                  // Gọi API để cập nhật chiều cao
                  await _apiService.updateHeight(widget.id, selectedHeight);
                  // Điều hướng đến trang tiếp theo
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Setup7(id: widget.id),
                    ),
                  );
                } catch (e) {
                  // Xử lý lỗi nếu cần
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to update height: $e')),
                  );
                }
              },
              content: buildHeightSelection(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage6({
    required String title,
    required String buttonText,
    required VoidCallback buttonAction,
    required Widget content,
  }) {
    return Container(
      color: Colors.black,
      height: 600,
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
          Expanded(
            child: Center(child: content),
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
              buttonText,
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildHeightSelection() {
    List<String> heights = List.generate(
        200, (index) => (index + 150).toString() + ' CM');

    return Container(
      width: 250,
      height: 500,
      color: Color(0xFFB3A0FF),
      padding: EdgeInsets.symmetric(vertical: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: heights
              .asMap()
              .entries
              .map((entry) {
            int index = entry.key;
            String height = entry.value;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedHeightIndex = index;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _selectedHeightIndex == index ? Colors.yellow : Colors
                      .transparent,
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  height,
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
