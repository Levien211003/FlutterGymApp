import 'package:flutter/material.dart';
import 'package:gymapp/NutriScreen/Thongbao.dart';
import 'package:gymapp/HomePage/home_screen.dart';
import 'package:gymapp/navbar.dart';
import 'package:gymapp/data/api.dart';
import 'package:gymapp/model/nutri.dart';
import 'package:gymapp/NutriScreen/details_nutri.dart';

class NutriList extends StatefulWidget {
  @override
  _NutriListState createState() => _NutriListState();
}

class _NutriListState extends State<NutriList> {
  late Future<List<Nutri>> futureNutriList;

  @override
  void initState() {
    super.initState();
    futureNutriList = ApiService().fetchNutriList();
  }

  Future<void> toggleFavoriteStatus(Nutri nutri) async {
    final newStatus = !nutri.favorite;
    await ApiService().updateFavoriteStatusNutri(nutri.id, newStatus);
    setState(() {
      nutri.favorite = newStatus;
    });
  }

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
                    icon: Icon(Icons.arrow_back_ios, color: Color(0xFFE2F163)),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Navbar()),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.search, color: Color(0xFFE2F163)),
                      SizedBox(width: 16),
                      Icon(Icons.account_circle, color: Color(0xFFE2F163)),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Center(
                child: Text(
                  'Bữa Sáng Dành Cho Bạn',
                  style: TextStyle(
                    color: Color(0xFFE2F163),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 40),
              FutureBuilder<List<Nutri>>(
                future: futureNutriList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Failed to load nutri list'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No data available'));
                  } else {
                    return Column(
                      children: snapshot.data!.map((nutri) {
                        return buildFoodItem(
                          nutri,
                          _formatDuration(nutri.timeCook),
                          '${nutri.calo} Cal',
                          'assets/images/nutri/${nutri.meal.toLowerCase()}.png',
                        );
                      }).toList(),
                    );
                  }
                },
              ),
              SizedBox(height: 50),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Thongbao()),
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
                        'Thông Báo',
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

  Widget buildFoodItem(Nutri nutri, String time, String cal, String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailNutri(nutri: nutri),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Icon(Icons.circle, color: Colors.purple),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nutri.meal,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.access_time, size: 16),
                              SizedBox(width: 5),
                              Text(time),
                              SizedBox(width: 10),
                              Icon(Icons.whatshot, size: 16),
                              SizedBox(width: 5),
                              Text(cal),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(
                        children: [
                          Image.asset(
                            imagePath,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              icon: Icon(
                                nutri.favorite ? Icons.star : Icons.star_border,
                                color: nutri.favorite ? Colors.yellow : Colors.grey,
                              ),
                              onPressed: () => toggleFavoriteStatus(nutri),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
