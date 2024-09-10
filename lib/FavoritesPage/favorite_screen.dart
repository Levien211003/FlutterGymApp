import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gymapp/UpToPro/pro_screen.dart';
import 'package:gymapp/VideoListPage/playvideo.dart';
import 'package:gymapp/model/plan.dart';
import 'package:gymapp/model/nutri.dart';
import 'package:gymapp/data/api.dart';
class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<dynamic> favorites = [];
  bool showPlans = true;

  @override
  void initState() {
    super.initState();
    _fetchFavorites();
  }

  Future<void> _fetchFavorites() async {
    ApiService apiService = ApiService();
    List<dynamic> favoriteItems;
    if (showPlans) {
      favoriteItems = await apiService.fetchFavoritePlans();
    } else {
      favoriteItems = await apiService.fetchFavoriteNutris();
      favoriteItems = favoriteItems.where((nutri) => nutri.favorite).toList();
    }
    setState(() {
      favorites = favoriteItems;
    });
  }

  Future<void> toggleFavoriteStatus(Nutri nutri) async {
    final newStatus = !nutri.favorite;
    await ApiService().updateFavoriteStatusNutri(nutri.id, newStatus);
    setState(() {
      nutri.favorite = newStatus;
    });
  }

  Future<void> _toggleFavorite(Plan plan) async {
    final updatedFavoriteStatus = !plan.favorite;
    await ApiService().updateFavoriteStatus(plan.id, updatedFavoriteStatus);
    setState(() {
      plan.favorite = updatedFavoriteStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Favorites',
          style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.bold),
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Sort By', style: TextStyle(color: Colors.yellow)),
                SizedBox(width: 18),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showPlans = true;
                      _fetchFavorites();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: showPlans ? Colors.yellow : Colors.white,
                    side: BorderSide(color: Colors.purple),
                  ),
                  child: Text('Plan', style: TextStyle(color: Color(0xFF896CFE))),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showPlans = false;
                      _fetchFavorites();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: showPlans ? Colors.white : Colors.yellow,
                    side: BorderSide(color: Colors.purple),
                  ),
                  child: Text('Nutri', style: TextStyle(color: Color(0xFF896CFE))),
                ),
              ],
            ),
          ),
          Expanded(
            child: showPlans ? _buildPlanGrid() : _buildNutriList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        Plan plan = favorites[index];
        return _buildVideoCard(plan: plan);
      },
    );
  }

  Widget _buildNutriList() {
    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        Nutri nutri = favorites[index];
        return buildNutriItem(nutri);
      },
    );
  }
  Widget _buildVideoCard({required Plan plan}) {
    final timeDuration = _parseTime(plan.time);

    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
            child: Image.network(
              plan.imageplan,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 100, // Adjust the height as needed
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => _toggleFavorite(plan),
                    child: Icon(
                      Icons.star,
                      color: plan.favorite ? Colors.yellow : Colors.grey,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PlayVideo(plan: plan)),
                      );
                    },
                    child: Icon(Icons.play_circle_fill, color: Color(0xFF896CFE)),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100, // Adjust width as needed
                          child: Text(
                            plan.nameplan,
                            style: TextStyle(color: Color(0xFFE2F163), fontWeight: FontWeight.bold),
                            maxLines: 2, // Add this to handle long text
                            overflow: TextOverflow.ellipsis, // Add this to handle long text
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.local_fire_department, color: Color(0xFFE2F163)),
                            SizedBox(width: 4),
                            Text(
                              '${timeDuration.inMinutes} Phút', // Display duration in minutes
                              style: TextStyle(color: Colors.white54),
                            ),
                            SizedBox(width: 16), // Khoảng cách giữa hai icon
                            Image.asset('assets/icons/icon2.png', height: 20, width: 20),
                            SizedBox(width: 8),
                            Text(
                              plan.repeat,
                              style: TextStyle(color: Colors.white54),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNutriItem(Nutri nutri) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
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
                              Text(_formatDuration(nutri.timeCook)),
                              SizedBox(width: 10),
                              Icon(Icons.whatshot, size: 16),
                              SizedBox(width: 5),
                              Text('${nutri.calo} Cal'),
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
                            'assets/images/nutri/${nutri.meal.toLowerCase()}.png',
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
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

    Duration _parseTime(String timeString) {
    final timeParts = timeString.split(':');
    final hours = int.parse(timeParts[0]);
    final minutes = int.parse(timeParts[1]);
    return Duration(hours: hours, minutes: minutes);
  }
}
