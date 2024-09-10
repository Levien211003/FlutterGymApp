import 'package:flutter/material.dart';
import 'package:gymapp/model/nutri.dart';

class DetailNutri extends StatelessWidget {
  final Nutri nutri;

  DetailNutri({required this.nutri});

  @override
  Widget build(BuildContext context) {
    // Xác định đường dẫn hình ảnh từ tài nguyên local
    String imagePath = 'assets/images/nutri/${nutri.meal.toLowerCase()}.png';

    return Scaffold(
      backgroundColor: Colors.black, // Màu nền của màn hình
      appBar: AppBar(
        backgroundColor: Colors.black, // Màu nền của AppBar
        elevation: 0,
        title: Text(
          nutri.meal,
          style: TextStyle(
            color: Color(0xFFE2F163), // Màu tiêu đề
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(
          color:  Color(0xFF896CFE), // Màu sắc của tất cả các biểu tượng trong AppBar
        ),
        actions: [
          IconButton(
            icon: Icon(
              nutri.favorite ? Icons.star : Icons.star_border,
              color: nutri.favorite ? Colors.yellow : Colors.grey, // Màu biểu tượng sao
              size: 30,
            ),
            onPressed: () {
              // Cập nhật trạng thái yêu thích khi nhấn vào biểu tượng
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40), // Khoảng cách trên cùng

          // Phần container chứa hình ảnh
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
            color: Color(0xFF44462E),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.29,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 50), // Khoảng cách giữa container và thời gian nấu ăn, calo

          // Phần thời gian nấu ăn và calo
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            color: Colors.black,
            child: Row(
              children: [
                Icon(Icons.access_time, color: Color(0xFF896CFE), size: 40), // Màu icon đồng hồ
                SizedBox(width: 10),
                Text(
                  _formatDuration(nutri.timeCook),
                  style: TextStyle( fontSize: 18,color: Colors.white),
                ),
                SizedBox(width: 20),
                Icon(Icons.whatshot, color:  Color(0xFF896CFE), size: 40), // Màu icon lửa
                SizedBox(width: 10),
                Text(
                  '${nutri.calo} Cal',
                  style: TextStyle( fontSize: 18,color: Colors.white),
                ),
              ],
            ),
          ),

          SizedBox(height: 20), // Khoảng cách giữa thời gian nấu ăn, calo và "Cách thực hiện"

          // Phần "Cách thực hiện"
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Cách thực hiện',
              style: TextStyle(
                color: Color(0xFFE2F163),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(height: 10), // Khoảng cách giữa tiêu đề và nội dung

          // Phần hướng dẫn thực hiện
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              nutri.howToCook,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),

          SizedBox(height: 20), // Khoảng cách dưới cùng
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
  }
}
