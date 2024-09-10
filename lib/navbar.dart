import 'package:flutter/material.dart';
import 'HomePage/home_screen.dart';
import 'UpToPro/pro_screen.dart';
import 'package:gymapp/VideoListPage/list_screen.dart';
import 'FavoritesPage/favorite_screen.dart';
import 'ProfilePage/profile_screen.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int navBarIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      navBarIndex = index;
      print(navBarIndex); // Thêm dòng này để kiểm tra giá trị của navBarIndex
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Colors.pink,
        textSelectionTheme: Theme.of(context).textSelectionTheme.copyWith(cursorColor: Colors.pink),
      ),
      child: Scaffold(
        body: Stack(
          children: [
            Visibility(
              visible: navBarIndex == 0,
              child: HomeScreen(),
            ),
            Visibility(
              visible: navBarIndex == 1,
              child: ListScreen(),
            ),
            Visibility(
              visible: navBarIndex == 2,
              child: FavoriteScreen(),
            ),
            Visibility(
              visible: navBarIndex == 3,
              child: ProfileScreen(),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: navBarIndex,
          backgroundColor: Color(0xFF44462E), // Đặt màu nền cho thanh navbar
          selectedItemColor: Colors.white, // Đặt màu cho mục được chọn
          unselectedItemColor: Colors.grey, // Đặt màu cho mục không được chọn
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
