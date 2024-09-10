import 'package:flutter/material.dart';
import 'package:gymapp/ProfilePage/profile_screen.dart';
import 'package:gymapp/UpToPro/pro_screen.dart';
import '../ChallengeScreen/challenge.dart';
import 'package:gymapp/VideoListPage/list_screen.dart';
import 'package:gymapp/NutriScreen/nutri_screen.dart';
import 'package:gymapp/login/login_screen.dart';
import 'package:gymapp/data/api.dart';
import 'package:gymapp/model/plan.dart';
import 'package:gymapp/VideoListPage/playvideo.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedLevel = 'Người Bắt Đầu'; // Mặc định chọn "Người Bắt Đầu"
  final ApiService _apiService = ApiService(); // Tạo đối tượng ApiService

  Future<List<Plan>> fetchPlans() async {
    return await _apiService.fetchPlans(); // Gọi phương thức fetchPlans từ ApiService
  }

  Future<List<Plan>> fetchPlansBySelectedLevel() async {
    String level;
    switch (selectedLevel) {
      case 'Người Bắt Đầu':
        level = 'Beginner';
        break;
      case 'Trung Bình':
        level = 'Intermediate';
        break;
      case 'Nâng Cao':
        level = 'Advanced';
        break;
      default:
        level = 'Beginner'; // Mặc định nếu cấp độ không hợp lệ
    }
    return await _apiService.fetchPlansByLevel(level);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        // Bao bọc Column bằng SingleChildScrollView
        child: Container(
          padding: EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '    Home Workout',
                      style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis, // Thêm thuộc tính này để cắt bớt văn bản nếu quá dài
                    ),
                  ),
                  Hero(
                    tag: 'proButton', // Tag duy nhất cho Hero animation
                    child: ElevatedButton.icon(
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
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Image.asset('assets/icons/baitap.png', height: 30, width: 30),
                      Text('Bài tập', style: TextStyle(color: Color(0xFFE2F163))),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ListScreen()));
                    },
                    child: Column(
                      children: [
                        Image.asset('assets/icons/tiendo.png', height: 30, width: 30),
                        Text('Tiến Độ', style: TextStyle(color: Color(0xFFB3A0FF))),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NutriScreen()));
                    },
                    child: Column(
                      children: [
                        Image.asset('assets/icons/thucpham.png', height: 30, width: 30),
                        Text('Thực phẩm', style: TextStyle(color: Color(0xFFB3A0FF))),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                    },
                    child: Column(
                      children: [
                        Image.asset('assets/icons/canhan.png', height: 30, width: 30),
                        Text('Cá nhân', style: TextStyle(color: Color(0xFFB3A0FF))),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                '      Danh sách gợi ý',
                style: TextStyle(color: Colors.yellow, fontSize: 16),
              ),
              Container(
                color: Colors.black,
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(top: 8.0),
                child: FutureBuilder<List<Plan>>(
                  future: fetchPlans(), // Gọi phương thức fetchPlans để lấy dữ liệu
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Có lỗi xảy ra!'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('Không có dữ liệu'));
                    } else {
                      final plans = snapshot.data!;
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: plans.map((plan) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => PlayVideo(plan: plan)),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.black, width: 1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      width: 157,
                                      height: 134,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          plan.imageplan,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          height: 100, // Adjust the height as needed
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      plan.nameplan,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Challenge()),
                  );
                },
                child: Container(
                  color: Color(0xFF44462E),
                  padding: EdgeInsets.all(16.0),
                  margin: EdgeInsets.symmetric(vertical: 8.0), // Điều chỉnh khoảng cách
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF212020), // Màu nền cho container bọc bên ngoài
                      borderRadius: BorderRadius.circular(20), // Bo góc cho container bọc bên ngoài
                    ),
                    padding: EdgeInsets.all(12.0), // Khoảng cách giữa container bên ngoài và bên trong
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2, // Độ rộng cho phần Text
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Thử Thách Plank',
                                style: TextStyle(color: Colors.yellow, fontSize: 28),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Plank With Hip Twist',
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3, // Độ rộng cho phần hình ảnh
                          child: Container(
                            height: 150,
                            width: 90,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20), // Bo góc 20px
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20), // Bo góc 20px cho hình ảnh
                              child: Image.asset('assets/images/Challenge2.png', fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                color: Colors.black,
                padding: EdgeInsets.all(0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedLevel = 'Người Bắt Đầu';
                        });
                      },
                      child: Text(
                        'Người Bắt Đầu',
                        style: TextStyle(
                          color: selectedLevel == 'Người Bắt Đầu' ? Color(0xFFE2F163) : Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedLevel = 'Trung Bình';
                        });
                      },
                      child: Text(
                        'Trung Bình',
                        style: TextStyle(
                          color: selectedLevel == 'Trung Bình' ? Color(0xFFE2F163) : Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedLevel = 'Nâng Cao';
                        });
                      },
                      child: Text(
                        'Nâng Cao',
                        style: TextStyle(
                          color: selectedLevel == 'Nâng Cao' ? Color(0xFFE2F163) : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              FutureBuilder<List<Plan>>(
                future: fetchPlansBySelectedLevel(), // Gọi phương thức fetchPlansBySelectedLevel để lấy dữ liệu
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Có lỗi xảy ra!'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Không có dữ liệu'));
                  } else {
                    final plans = snapshot.data!;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: plans.map((plan) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PlayVideo(plan: plan)),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black, width: 1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    width: 157,
                                    height: 134,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        plan.imageplan,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 100, // Adjust the height as needed
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    plan.nameplan,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
