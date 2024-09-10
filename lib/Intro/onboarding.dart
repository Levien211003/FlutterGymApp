 import 'package:flutter/material.dart';
import 'package:gymapp/login/signup_screen.dart';
 import 'setup.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
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
          GestureDetector(
            onTap: () {
              _controller.nextPage(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            },
          child: 
          buildPage1(
              imagePath: 'assets/images/Onboarding1.png',
              title: 'Welcome to',
              title2: 'THE QUAMON',
              title3: 'FITNESS',
              subtitle: '',
              buttonLabel: '',
              buttonAction: () {},
              logoPath: 'assets/images/logo.png',
            ),
          ),
          buildPage2(
            imagePath: 'assets/images/Onboarding2.png',
            title: 'Bắt Đầu Hành Trình Hướng Tới\nMột Lối Sống Năng Động Hơn',
            subtitle: '',
            buttonLabel: 'Tiếp Tục',
            buttonAction: () {
              _controller.nextPage(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            },
            iconPath: 'assets/icons/icon2.png',
          ),
           buildPage3(
            imagePath: 'assets/images/Onboarding3.png',
            title: 'Tìm Lời Khuyên Về Dinh Dưỡng Phù Hợp Với Lối Sống',
            subtitle: '',
            buttonLabel: 'Tiếp Tục',
            buttonAction: () {
              _controller.nextPage(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            },
         iconPath: 'assets/icons/icon3.png',

          ),
           buildPage4(
            imagePath: 'assets/images/Onboarding4.png',
            title: 'Một Cộng Đồng Dành Cho Bạn, Thử Thách Bản Thân',
            subtitle: '',
            buttonLabel: 'Bắt Đầu',
            buttonAction: () {
              // Navigate to the Setup screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignupScreen()),
              );
            },
          iconPath: 'assets/icons/icon4.png',

          ), 
        ],
      ),
    );
  }
Widget buildPage1({
    required String imagePath,
    required String title,
    required String title2,
    required String title3,
    required String subtitle,
    required String buttonLabel,
    required VoidCallback buttonAction,
    required String logoPath,
  }) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              imagePath,
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
            top: 20,
            right: 40,
            child: TextButton(
              onPressed: () {},
              child: Text(
                '',//bosungsau
                style: TextStyle(color: Colors.yellow),
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 250,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.yellow,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                   Padding(
                      padding: const EdgeInsets.only(left: 155.0, top: 0.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          title2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 150.0, top: 0.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          title3,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    if (subtitle.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            subtitle,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ),
                    if (buttonLabel.isNotEmpty)
                      ElevatedButton(
                        onPressed: buttonAction,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black.withOpacity(0.8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        ),
                        child: Text(
                          buttonLabel,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 440,
            left: 100,
            child: Image.asset(
              logoPath,
              width: 80,
              height: 80,
            ),
          ),
        ],
      ),
    );
  }
Widget buildPage2({
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
            fit: BoxFit.fitWidth,
          ),
        ),
    
        Positioned(
          left: 0,
          right: 0,
          bottom: 360,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 450,
              height: 150,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFF44462E), // Mã màu #44462E
                borderRadius: BorderRadius.circular(0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          bottom: 300,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 200,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: OutlinedButton(
                onPressed: buttonAction,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white.withOpacity(0.8)), // Viền màu trắng trong suốt
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
          ),
        ),
        Positioned(
            top: 320,
            left: 200,
            child: Image.asset(
              iconPath,
              width: 40,
              height: 40,
            ),
          ),
      ],
    ),
  );
}
Widget buildPage3({
  required String imagePath,
  required String title,
  required String subtitle,
  required String buttonLabel,
  required VoidCallback buttonAction,
      required String iconPath,

})
{
  return Scaffold(
    body: Stack(
      children: <Widget>[
        Positioned.fill(
          child: Image.asset(
            imagePath,
            fit: BoxFit.fitWidth,
          ),
        ),
    
        Positioned(
          left: 0,
          right: 0,
          bottom: 360,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 500,
              height: 150,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFF44462E), // Mã màu #44462E
                borderRadius: BorderRadius.circular(0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          bottom: 300,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 200,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: OutlinedButton(
                onPressed: buttonAction,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white.withOpacity(0.8)), // Viền màu trắng trong suốt
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
          ),
        ),
        Positioned(
            top: 320,
            left: 200,
            child: Image.asset(
              iconPath,
              width: 40,
              height: 40,
            ),
          ),
      ],
    ),
  );
}
Widget buildPage4({
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
            fit: BoxFit.fitWidth,
          ),
        ),
    
        Positioned(
          left: 0,
          right: 0,
          bottom: 360,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 500,
              height: 150,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFF44462E), // Mã màu #44462E
                borderRadius: BorderRadius.circular(0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (subtitle.isNotEmpty)
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          bottom: 300,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 200,
              height: 30,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: OutlinedButton(
                onPressed: buttonAction,
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.white.withOpacity(0.8)), // Viền màu trắng trong suốt
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
          ),
        ),
        Positioned(
            top: 320,
            left: 200,
            child: Image.asset(
              iconPath,
              width: 40,
              height: 40,
            ),
          ),
      ],
    ),
  );
}



}