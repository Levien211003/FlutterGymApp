import 'package:flutter/material.dart';
import 'package:gymapp/UpToPro/pro_screen.dart';
import 'package:gymapp/VideoListPage/playvideo.dart';
import 'package:gymapp/data/api.dart';
import 'package:gymapp/model/plan.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late Future<List<Plan>> futurePlans;
  List<Plan> _filteredPlans = [];
  TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    futurePlans = ApiService().fetchPlans();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _filteredPlans = _searchController.text.isEmpty
          ? []
          : _filteredPlans.where((plan) => plan.nameplan.toLowerCase().contains(_searchController.text.toLowerCase())).toList();
    });
  }

  void _toggleFavorite(Plan plan) async {
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
        title: Text('Video List', style: TextStyle(color: Color(0xFFE2F163))),
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
              backgroundColor: Color(0xFFE2F163),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Videos Bài Tập button action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFE2F163),
                  ),
                  child: Text('Videos Bài Tập', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Tìm Video Dễ Dàng Hơn',
                  style: TextStyle(color: Color(0xFFE2F163)),
                ),
                IconButton(
                  icon: Icon(Icons.search, color: Color(0xFFE2F163)),
                  onPressed: () {
                    setState(() {
                      _isSearching = !_isSearching;
                    });
                  },
                ),
              ],
            ),
            if (_isSearching)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Nhập tên bài tập...',
                    hintStyle: TextStyle(color: Colors.white54),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE2F163)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFE2F163)),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            Expanded(
              child: FutureBuilder<List<Plan>>(
                future: futurePlans,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No plans available'));
                  } else {
                    List<Plan> displayPlans = _searchController.text.isEmpty
                        ? snapshot.data!
                        : snapshot.data!.where((plan) => plan.nameplan.toLowerCase().contains(_searchController.text.toLowerCase())).toList();

                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: displayPlans.length,
                      itemBuilder: (context, index) {
                        Plan plan = displayPlans[index];
                        return _buildVideoCard(
                          plan: plan,
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoCard({
    required Plan plan,
  }) {
    // Convert time from String to Duration
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
                  left: 1,
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
                            Icon(Icons.timer_sharp, color: Color(0xFFE2F163)),
                            SizedBox(width: 2),
                            Text(
                              '${timeDuration.inMinutes} Phút', // Display duration in minutes
                              style: TextStyle(color: Colors.white54),
                            ),
                            SizedBox(width: 6), // Khoảng cách giữa hai icon
                            Image.asset('assets/icons/icon2.png', height: 20, width: 20),
                            SizedBox(width: 2),
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

  Duration _parseTime(String timeString) {
    // Assuming timeString is in "hh:mm" format
    final timeParts = timeString.split(':');
    final hours = int.parse(timeParts[0]);
    final minutes = int.parse(timeParts[1]);
    return Duration(hours: hours, minutes: minutes);
  }
}
