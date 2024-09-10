import 'package:flutter/material.dart';
import '../HomePage/home_screen.dart'; // Import HomeScreen để chuyển về khi nhấn nút back



class ProScreen extends StatefulWidget {
  @override
  _ProScreenState createState() => _ProScreenState();
}

class _ProScreenState extends State<ProScreen> {
  int selectedOption = -1; // Biến để lưu trữ tùy chọn được chọn

  @override
  Widget build(BuildContext context) {
    // Get the height and width of the screen
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top), // Để đảm bảo nút back không bị che bởi phần status bar
            width: screenWidth,
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.yellow), // Thay đổi màu của icon thành vàng
                onPressed: () {
                  Navigator.pop(context); // Trở về HomeScreen khi nhấn nút back
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: screenWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Row 1: Container with border and crown logo
                  Hero(
                    tag: 'proButton',
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,// Sử dụng cùng tag với Hero ở màn hình trước
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset('assets/icons/crown.png', height: 30, width: 30),
                          SizedBox(width: 8),
                          Text(
                            'Pro',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ),
                  // Row 2: Container with yellow background and text
                  Container(
                    height: screenHeight * 0.2,
                    width: screenWidth,
                    color: Color(0xFF44462E),
                    alignment: Alignment.center,
                    child: Text(
                      'Up to Pro.\nDùng phòng tập offline kèm PT!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFD4EE00),
                        fontSize: 18,
                      ),
                    ),
                  ),
                  // Row 3: Container with pricing options
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        PricingOption(
                          title: '2 Tháng',
                          price: '999 VND',
                          isSelected: selectedOption == 0,
                          onTap: () {
                            setState(() {
                              selectedOption = 0;
                            });
                          },
                        ),
                        PricingOption(
                          title: '6 Tháng',
                          price: '1999 VND',
                          isSelected: selectedOption == 1,
                          onTap: () {
                            setState(() {
                              selectedOption = 1;
                            });
                          },
                        ),
                        PricingOption(
                          title: '1 Năm',
                          price: '2999 VND',
                          isSelected: selectedOption == 2,
                          onTap: () {
                            setState(() {
                              selectedOption = 2;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  // Row 4: Payment button
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Thanh Toán',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class PricingOption extends StatelessWidget {
  final String title;
  final String price;
  final bool isSelected;
  final VoidCallback onTap;

  PricingOption({
    required this.title,
    required this.price,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: screenWidth * 0.9, // Đặt chiều rộng là 90% của chiều rộng màn hình
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.yellow : Colors.blue,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              price,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}