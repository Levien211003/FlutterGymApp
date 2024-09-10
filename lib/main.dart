import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Thêm dòng này
import 'package:gymapp/HomePage/home_screen.dart';
import 'package:gymapp/UpToPro/pro_screen.dart';
import 'Intro/onboarding.dart';
import 'package:gymapp/data/api.dart';  // Thêm dòng này
import 'package:gymapp/data/theme_notifier.dart'; // Thêm dòng này

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeNotifier(), // Thêm dòng này
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
            title: 'Onboarding Screens',
            theme: themeNotifier.currentTheme,
            home: Onboarding(), // Thay đổi HomePage() thành Onboarding() hoặc màn hình chính khác bạn muốn hiển thị
          );
        },
      ),
    );
  }
}
