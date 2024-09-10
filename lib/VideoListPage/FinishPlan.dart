import 'package:flutter/material.dart';
import 'package:gymapp/HomePage/home_screen.dart';
import 'package:gymapp/VideoListPage/list_screen.dart';
import 'package:gymapp/navbar.dart';

class FinishPlan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon cup
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Image.asset(
              'assets/icons/finishcon.png', // Đường dẫn đến biểu tượng cúp của bạn
              height: 200,
              width: 200,
            ),
          ),
          // Congratulations Text
          Container(
            padding: EdgeInsets.all(20),
            color: Color(0xFFE2F163),
            child: Column(
              children: [
                Text(
                  'Congratulations!',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            '10 Minute',
                            style: TextStyle(color: Colors.black),
                          ),
                          Icon(Icons.timer, color: Colors.black),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '100 Rep',
                            style: TextStyle(color: Colors.black),
                          ),
                          Icon(Icons.fitness_center, color: Colors.black),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Challenge',
                            style: TextStyle(color: Colors.black),
                          ),
                          Icon(Icons.flag, color: Colors.black),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Go to the next workout button
          ElevatedButton(
            onPressed: () {

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Navbar()),
                    (route) => false, // Xóa tất cả các route trước đó
              );
              // Điều hướng tới màn hình bài tập tiếp theo
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF896CFE),
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              'Go to find next workout',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          SizedBox(height: 10),
          // Home button
          ElevatedButton(
            onPressed: () {
              // Điều hướng về màn hình chính
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Navbar()),
                    (route) => false, // Xóa tất cả các route trước đó
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFE2F163),
              padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              'Home',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
