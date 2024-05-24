import 'package:flutter/material.dart';
import 'package:uyishi/utils/app_constants_utils.dart';
import 'package:uyishi/views/screens/home_screen.dart';
import 'package:uyishi/views/screens/pin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isPinSet = prefs.getBool('isPinSet') ?? false;
  runApp(MyApp(isPinSet: isPinSet));
}

class MyApp extends StatefulWidget {
  final bool isPinSet;
  const MyApp({super.key, required this.isPinSet});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void toggleThemeMode(bool value) {
    setState(() {
      AppConstants.themeMode = value ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void changeBackgroundImage(String imageUrl) {
    if (imageUrl.trim().isNotEmpty) {
      setState(() {
        AppConstants.backgroundImageUrl = imageUrl;
      });
    }
  }

  void changeAppBarColor(Color color) {
    setState(() {
      AppConstants.appBarColor = color;
    });
  }

  void changeScaffoldColor(Color color) {
    setState(() {
      AppConstants.scaffoldColor = color;
    });
  }

  void changeTextSize(double size) {
    setState(() {
      AppConstants.textSize = size;
    });
  }

  void changeTextColor(Color color) {
    setState(() {
      AppConstants.textColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: AppConstants.appBarColor,
        ),
        scaffoldBackgroundColor: AppConstants.scaffoldColor,
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            fontSize: AppConstants.textSize,
            color: AppConstants.textColor,
          ),
        ),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: AppConstants.themeMode,
      home: widget.isPinSet
          ? PinScreen(onUnlock: () => setState(() {}))
          : HomeScreen(
              onThemeChanged: toggleThemeMode,
              onBackgroundImageChanged: changeBackgroundImage,
              onAppBarColorChanged: changeAppBarColor,
              onScaffoldColorChanged: changeScaffoldColor,
              onTextSizeChanged: changeTextSize,
              onTextColorChanged: changeTextColor,
            ),
    );
  }
}
