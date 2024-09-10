import 'package:flutter/material.dart';
import 'package:gymapp/NutriScreen/NutriBuild.dart';

class NutriScreen extends StatefulWidget {
  @override
  _NutriState createState() => _NutriState();
}

class _NutriState extends State<NutriScreen> {
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
            title: 'Thực Phẩm',
            subtitle: '',
            buttonLabel: 'Tiếp Tục',
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
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.2,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFF44462E),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        iconPath,
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(width: 10), // khoảng cách giữa icon và text
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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



}


