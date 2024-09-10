import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/Intro/setup.dart';
import '../Intro/setup1.dart';
import 'login_screen.dart';
import 'package:gymapp/data/api.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  Future<void> _register() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (!email.endsWith('@gmail.com')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email must end with @gmail.com')),
      );
      return;
    }

    if (password.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password must be at least 8 characters long')),
      );
      return;
    }

    if (password != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      final int id = await _apiService.registerUser(
        _usernameController.text,
        _emailController.text,
        _passwordController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration successful')),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Setup1(id: id),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212020),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 40),
            _buildTitle('Mời Nhập Thông Tin'),
            SizedBox(height: 20),
            _buildForm(),
            SizedBox(height: 20),
            _buildTermsAndPolicy(),
            SizedBox(height: 20),
            _buildSignupButton(),
            SizedBox(height: 10),
            _buildLoginPrompt(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios, color: Color(0xFFE2F163)),
          ),
          Spacer(),
          Text(
            'Tạo Tài Khoản',
            style: TextStyle(
              color: Color(0xFFE2F163),
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildForm() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF44462E),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField('Username', _usernameController),
          _buildTextField('Email', _emailController),
          _buildTextField('Password', _passwordController, obscureText: true),
          _buildTextField('Confirm Password', _confirmPasswordController, obscureText: true),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildTermsAndPolicy() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'By continuing, you agree to ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
          children: [
            _buildLink('Terms of Use', () {}),
            TextSpan(
              text: ' and ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            _buildLink('Privacy Policy.', () {}),
          ],
        ),
      ),
    );
  }

  TextSpan _buildLink(String text, VoidCallback onTap) {
    return TextSpan(
      text: text,
      style: TextStyle(
        color: Color(0xFFE2F163),
        fontSize: 14,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
      ),
      recognizer: TapGestureRecognizer()..onTap = onTap,
    );
  }

  Widget _buildSignupButton() {
    return Ink(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(30),
      ),
      child: InkResponse(
        onTap: _register,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          child: Text(
            'Đăng Ký',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Đã có tài khoản?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
          child: Text(
            'Login',
            style: TextStyle(
              color: Color(0xFFE2F163),
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
