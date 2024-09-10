import 'package:flutter/material.dart';
import 'package:gymapp/data/api.dart';
import 'setup8.dart'; // Import Setup8

class Setup7 extends StatefulWidget {
  final int id;

  Setup7({required this.id});

  @override
  _Setup7State createState() => _Setup7State();
}

class _Setup7State extends State<Setup7> {
  PageController _controller = PageController();
  int _currentPage = 0;
  int _selectedButtonIndex = -1; // Chỉ số cấp độ được chọn
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
            child: buildPage7(
              title: 'Chọn Cấp Độ Bài Tập',
              buttonLabel: 'Tiếp Theo',
              buttonAction: () async {
                // Chọn cấp độ dựa vào chỉ số
                String level;
                switch (_selectedButtonIndex) {
                  case 0:
                    level = 'Beginner';
                    break;
                  case 1:
                    level = 'Intermediate';
                    break;
                  case 2:
                    level = 'Advanced';
                    break;
                  default:
                    level = '';
                }

                // Gọi API để cập nhật cấp độ
                try {
                  await _apiService.updateLevel(widget.id, level);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Setup8(
                        id: widget.id,
                      ),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Lỗi khi cập nhật cấp độ: $e')),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage7({
    required String title,
    required String buttonLabel,
    required VoidCallback buttonAction,
  }) {
    return Container(
      color: Colors.black,
      height: 600,
      child: Column(
        children: <Widget>[
          SizedBox(height: 130),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 80),
          Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              children: <Widget>[
                buildSelectableButton2('Mới Bắt Đầu', 0),
                buildSelectableButton2('Trung Bình', 1),
                buildSelectableButton2('Nâng Cao', 2),
              ],
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

  Widget buildSelectableButton2(String text, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedButtonIndex = index;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        decoration: BoxDecoration(
          color: _selectedButtonIndex == index ? Colors.yellow : Colors.white,
          border: Border.all(color: Color(0xFF896CFE), width: 1.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Color(0xFF896CFE),
            fontSize: 18,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
