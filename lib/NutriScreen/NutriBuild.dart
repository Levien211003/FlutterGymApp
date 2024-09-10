import 'package:flutter/material.dart';
import 'package:gymapp/ProfilePage/profile_screen.dart';
import 'package:gymapp/NutriScreen/NutriList.dart';

class NutriBuild extends StatefulWidget {
  @override
  _NutriBuildState createState() => _NutriBuildState();
}

class _NutriBuildState extends State<NutriBuild> {
  int _selectedCalories = 0;
  int _selectedTime = 0;
  int _selectedMeal = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212020),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Color(0xFFE2F163)),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Row(
                    children: [
                      Icon(Icons.search, color: Color(0xFFE2F163)),
                      SizedBox(width: 16),
                      IconButton(
                        icon: Icon(Icons.account_circle, color: Color(0xFFE2F163)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProfileScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              buildTitle("     Lượng Calo"),
              buildRadioGroup(0),
              SizedBox(height: 30),
              buildTitle("     Thời Gian Chế Biến"),
              buildRadioGroup(1),
              SizedBox(height: 30),
              buildTitle("     Bữa Ăn"),
              buildMealRadioGroup(),
              SizedBox(height: 50),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NutriList()),
                    );
                  },
                  child: Container(
                    width: 157,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFFE2F163),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        'Tạo',
                        style: TextStyle(
                          color: Color(0xFF232222),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          color: Color(0xFFE2F163),
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget buildRadioGroup(int group) {
    List<String> options;
    int selectedValue;
    void Function(int?) onChanged;

    switch (group) {
      case 0:
        options = ['Nhỏ hơn 250 calories', '250-500 calories', 'Lớn hơn 500 calories'];
        selectedValue = _selectedCalories;
        onChanged = (value) => setState(() => _selectedCalories = value!);
        break;
      case 1:
        options = ['Ít hơn 15 minutes', '15-30 minutes', 'Nhiều hơn 30 minutes'];
        selectedValue = _selectedTime;
        onChanged = (value) => setState(() => _selectedTime = value!);
        break;
      default:
        return SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: options.asMap().entries.map((entry) {
        int idx = entry.key;
        String text = entry.value;
        return RadioListTile(
          value: idx,
          groupValue: selectedValue,
          onChanged: onChanged,
          title: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
          activeColor: Color(0xFFE2F163),
        );
      }).toList(),
    );
  }

  Widget buildMealRadioGroup() {
    List<String> options = ['Sáng', 'Trưa', 'Tối'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: options.asMap().entries.map((entry) {
        int idx = entry.key;
        String text = entry.value;
        return Row(
          children: [
            Radio<int>(
              value: idx,
              groupValue: _selectedMeal,
              onChanged: (value) => setState(() => _selectedMeal = value!),
              activeColor: Color(0xFFE2F163),
            ),
            Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ],
        );
      }).toList(),
    );
  }
}

