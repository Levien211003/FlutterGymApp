import 'package:flutter/material.dart';
import 'playchallenge.dart';

class Challenge extends StatefulWidget {
  @override
  _ChallengeState createState() => _ChallengeState();
}

class _ChallengeState extends State<Challenge> {
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
            imagePath: 'assets/images/Challenge1.png',
            title: 'Thử thách 30 ngày plank',
            subtitle: '',
            buttonLabel: 'Bắt Đầu',
            buttonAction: () {
              _controller.nextPage(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            },
            iconPath: 'assets/icons/icon2.png',
          ),
          buildWorkoutPage(),
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
                    color: Color(0xFFB3A0FF),
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


  //Page2
  Widget buildWorkoutPage() {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Trở về màn hình trước đó
          },
        ),
        title: Text('Thử thách 30 ngày plank'),
        titleTextStyle: TextStyle(color: Color(0xFFE2F163)),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                color: Color(0xFF44462E),
                borderRadius: BorderRadius.circular(0),
              ),
              padding: EdgeInsets.all(20.0),
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        image: DecorationImage(
                          image: AssetImage('assets/images/Challenge2.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Plank Cho Người Mới',
                          style: TextStyle(color: Color(0xFFE2F163),
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            SizedBox(width: 0),
                            Icon(Icons.local_fire_department,
                                color: Colors.red),
                            Text(
                              '120 calo',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),

                            SizedBox(width: 18),
                            Icon(Icons.timelapse,
                                color: Colors.red),
                            Text(
                              '2 phút',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ],

                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            buildWorkoutRound('Vòng 1', [
              buildWorkoutItem('Plank Lần 1', '00:10', 'Lặp lại 3x'),
              buildWorkoutItem('Plank Lần 2', '00:10', 'Lặp lại 2x'),
              buildWorkoutItem('Plank Lần 3', '00:10', 'Lặp lại 2x'),
            ]),
            buildWorkoutRound('Vòng 2', [
              buildWorkoutItem('Giải Lao', '00:10', 'Lặp lại 2x'),
              buildWorkoutItem('Plank Lần 4', '00:10', 'Lặp lại 3x'),
            ]),
          ],
        ),
      ),
    );
  }

  Widget buildWorkoutRound(String roundTitle, List<Widget> workouts) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            roundTitle,
            style: TextStyle(color: Colors.yellow, fontSize: 24),
          ),
          SizedBox(height: 8),
          Column(children: workouts),
        ],
      ),
    );
  }

  Widget buildWorkoutItem(String title, String time, String repetition) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.play_circle_filled, color: Colors.purple),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlayChallenge()),
              );
            },
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
              Text(
                repetition,
                style: TextStyle(color: Colors.purple, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


