import 'package:flutter/material.dart';
import 'package:gymapp/UpToPro/pro_screen.dart';
import 'finishchallenge.dart';

class PlayChallenge extends StatefulWidget {
  @override
  _PlayChallengeState createState() => _PlayChallengeState();
}

class _PlayChallengeState extends State<PlayChallenge> {
  @override
  Widget build(BuildContext context) {
    // Tính toán chiều cao của container bọc hình ảnh
    double imageContainerHeight = MediaQuery.of(context).size.height * 5 / 8.5;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.yellow),
                    onPressed: () {
                      Navigator.pop(context); // Quay về màn hình trước đó
                    },
                  ),
                  Text('', style: TextStyle(color: Colors.yellow)),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Điều hướng tới ProScreen khi button được nhấn
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProScreen()),
                      );
                    },
                    icon: Image.asset('assets/icons/crown.png', height: 30, width: 30),
                    label: Text('Pro', style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Center(
                  child: Container(
                    height: imageContainerHeight,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFF44462E), // Màu viền ngoài
                      borderRadius: BorderRadius.circular(20), // Độ cong của viền ngoài
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        'assets/images/Challenge1.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.purple,
                    child: Icon(Icons.play_arrow, color: Colors.white, size: 40),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25), // Thêm SizedBox cho khoảng cách 25 pixels
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.2,
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Color(0xFFE2F163),
              borderRadius: BorderRadius.circular(20), // Apply circular radius to all corners
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Plank Lần 1',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Điều hướng đến FinishChallenge khi nhấn vào Finish
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => FinishChallenge()),
                        );
                      },
                      child: Text(
                        'Finish',
                        style: TextStyle(color: Color(0xFF896CFE), fontSize: 29),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10), // Apply circular radius to all corners
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.timer, color: Colors.black),
                          SizedBox(width: 5),
                          Text('30 Seconds', style: TextStyle(color: Colors.black)),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.replay, color: Colors.black),
                          SizedBox(width: 5),
                          Text('3 Reps', style: TextStyle(color: Colors.black)),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.flag, color: Colors.black),
                          SizedBox(width: 5),
                          Text('Challenge', style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 25), // Thêm khoảng cách phía dưới của container

        ],
      ),
    );
  }
}
