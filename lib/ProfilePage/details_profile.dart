import 'package:flutter/material.dart';
import 'package:gymapp/model/user.dart'; // Đảm bảo đường dẫn chính xác

class DetailsProfile extends StatefulWidget {
  final User user;

  DetailsProfile({required this.user});

  @override
  _DetailsProfileState createState() => _DetailsProfileState();
}

class _DetailsProfileState extends State<DetailsProfile> {
  bool _isEditing = false;

  late TextEditingController _fullnameController;
  late TextEditingController _emailController;
  late TextEditingController _usernameController;
  late TextEditingController _ageController;
  late TextEditingController _genderController;
  late TextEditingController _heightController;
  late TextEditingController _weightController;
  late TextEditingController _levelController;
  late TextEditingController _mobileNumberController;
  late TextEditingController _mucTieuController;
  late TextEditingController _nicknameController;

  @override
  void initState() {
    super.initState();
    _fullnameController = TextEditingController(text: widget.user.fullname);
    _emailController = TextEditingController(text: widget.user.email);
    _usernameController = TextEditingController(text: widget.user.username);
    _ageController = TextEditingController(text: widget.user.age?.toString());
    _genderController = TextEditingController(text: widget.user.gender);
    _heightController = TextEditingController(text: widget.user.height?.toString());
    _weightController = TextEditingController(text: widget.user.weight?.toString());
    _levelController = TextEditingController(text: widget.user.level);
    _mobileNumberController = TextEditingController(text: widget.user.mobileNumber);
    _mucTieuController = TextEditingController(text: widget.user.mucTieu);
    _nicknameController = TextEditingController(text: widget.user.nickname);
  }

  @override
  void dispose() {
    _fullnameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _levelController.dispose();
    _mobileNumberController.dispose();
    _mucTieuController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() {
    // Lưu các thay đổi ở đây. Bạn có thể gọi API để cập nhật thông tin người dùng.
    setState(() {
      _isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Details', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit),
            onPressed: _isEditing ? _saveChanges : _toggleEdit,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: widget.user.image != null
                    ? NetworkImage(widget.user.image!)
                    : AssetImage("assets/images/avatar.png") as ImageProvider,
              ),
            ),
            SizedBox(height: 20),
            _buildTextField('Full Name', _fullnameController),
            SizedBox(height: 10),
            _buildTextField('Email', _emailController),
            SizedBox(height: 10),
            _buildTextField('Username', _usernameController),
            SizedBox(height: 10),
            _buildTextField('Age', _ageController, keyboardType: TextInputType.number),
            SizedBox(height: 10),
            _buildTextField('Gender', _genderController),
            SizedBox(height: 10),
            _buildTextField('Height (Cm)', _heightController, keyboardType: TextInputType.number),
            SizedBox(height: 10),
            _buildTextField('Weight (Kg)', _weightController, keyboardType: TextInputType.number),
            SizedBox(height: 10),
            _buildTextField('Level', _levelController),
            SizedBox(height: 10),
            _buildTextField('Mobile Number', _mobileNumberController),
            SizedBox(height: 10),
            _buildTextField('Goal', _mucTieuController),
            SizedBox(height: 10),
            _buildTextField('Nickname', _nicknameController),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      enabled: _isEditing,
      style: TextStyle(color: Colors.white), // Màu chữ của TextField
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70), // Màu chữ của label
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white), // Màu viền của TextField
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white), // Màu viền khi được focus
        ),
      ),
      keyboardType: keyboardType,
    );
  }
}
