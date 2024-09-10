import 'package:flutter/material.dart';
import 'package:gymapp/NutriScreen/NutriBuild.dart';
import 'package:gymapp/NutriScreen/NutriList.dart';
import 'package:gymapp/NutriScreen/nutri_screen.dart';

class Tips extends StatefulWidget {
  @override
  _TipsState createState() => _TipsState();
}

class _TipsState extends State<Tips> {
  PageController _controller = PageController();
  int _currentPage = 0;

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
          buildPage1(
            imagePath: 'assets/images/Nutri.png',
            title: 'Lợi Ích Của Việc Ăn Sáng Đầy Đủ',
            subtitle: '',
            buttonLabel: 'Finish',
            buttonAction: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NutriBuild()),
              );
            },
            iconPath: 'assets/icons/icon3.png',
          ),
        ],
      ),
    );
  }

  Widget buildPage1({
    required String imagePath,
    required String title,
    required String subtitle,
    required String buttonLabel,
    required VoidCallback buttonAction,
    required String iconPath,
  }) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.yellow),
              onPressed: () {
                Navigator.pop(context); // Trở về màn hình trước đó
              },
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFF44462E),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildLabel('1. Ăn Sáng Thường Xuyên Giúp Quản Lý Cân Nặng'),
                      buildLabel('2. Bữa Sáng Làm Tăng Lượng Chất Dinh Dưỡng Trong Ngày'),
                      buildLabel('3. Bữa Sáng Cân Bằng Giúp Điều Hòa Lượng Đường Trong Máu'),
                      buildLabel('4. Ăn Sáng Đầy Đủ Giúp Cải Thiện Chức Năng Nhận Thức'),
                      buildLabel('5. Bữa Sáng Bổ Dưỡng Giúp Cải Thiện Tâm Trạng'),
                    ],
                  ),
                ),
                SizedBox(height: 20), // khoảng cách giữa container và button
                Container(
                  width: 200,
                  height: 30,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: OutlinedButton(
                    onPressed: buttonAction,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.white.withOpacity(0.8)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      buttonLabel,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
