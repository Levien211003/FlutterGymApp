import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:gymapp/model/plan.dart';
import 'package:gymapp/VideoListPage/finishplan.dart'; // Đảm bảo import đúng FinishPlan
import 'package:gymapp/UpToPro/pro_screen.dart';

class PlayVideo extends StatefulWidget {
  final Plan plan; // Nhận đối tượng Plan từ màn hình trước

  PlayVideo({required this.plan});

  @override
  _PlayVideoState createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.plan.idyoutube,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.amber,
              progressColors: ProgressBarColors(
                playedColor: Colors.amber,
                handleColor: Colors.amberAccent,
              ),
              onReady: () {
                _controller.addListener(() {});
              },
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
                      widget.plan.nameplan, // Sử dụng nameplan từ đối tượng Plan
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Điều hướng đến FinishPlan khi nhấn vào Finish
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FinishPlan(), // Đảm bảo widget.plan là một đối tượng Plan hợp lệ
                          ),
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
                          Text('${widget.plan.time}', style: TextStyle(color: Colors.black)), // Sử dụng time từ đối tượng Plan
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.replay, color: Colors.black),
                          SizedBox(width: 5),
                          Text('${widget.plan.repeat}', style: TextStyle(color: Colors.black)), // Sử dụng repeat từ đối tượng Plan
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.flag, color: Colors.black),
                          SizedBox(width: 5),
                          Text('${widget.plan.level}', style: TextStyle(color: Colors.black)), // Sử dụng level từ đối tượng Plan
                        ],
                      ),
                    ],
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
