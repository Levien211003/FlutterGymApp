import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gymapp/login/login_screen.dart';
import '../navbar.dart';
import 'package:gymapp/data/api.dart';

class Setup8 extends StatefulWidget {
  final int id;

  Setup8({required this.id});

  @override
  _Setup8State createState() => _Setup8State();
}

class _Setup8State extends State<Setup8> {
  PageController _controller = PageController();
  File? _imageFile; // Biến để lưu hình ảnh đã chọn

  final ApiService _apiService = ApiService();
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (int page) {
          // Có thể sử dụng biến `_currentPage` nếu cần
        },
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _controller.nextPage(
                duration: Duration(milliseconds: 400),
                curve: Curves.easeInOut,
              );
            },
            child: buildPage8(
              title: 'Cập Nhật Thông Tin',
              buttonLabel: 'Bắt Đầu',
              buttonAction: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage8({required String title, required String buttonLabel, required VoidCallback buttonAction}) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 60),
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 60),
            Container(
              width: double.infinity,
              height: 150,
              color: Color(0xFF896CFE),
              child: Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 48,
                        backgroundImage: _imageFile != null
                            ? FileImage(_imageFile!)
                            : AssetImage('assets/images/canhan.png') as ImageProvider,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage, // Gọi hàm chọn hình ảnh
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(height: 20),
            Text(
              'Full name',
              style: TextStyle(color: Color(0xFF896CFE)),
            ),
            SizedBox(height: 5),
            TextField(
              controller: _fullnameController,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Nickname',
              style: TextStyle(color: Color(0xFF896CFE)),
            ),
            SizedBox(height: 5),
            TextField(
              controller: _nicknameController,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Mobile Number',
              style: TextStyle(color: Color(0xFF896CFE)),
            ),
            SizedBox(height: 5),
            TextField(
              controller: _mobileNumberController,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: buttonAction,
              child: Text(
                buttonLabel,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
