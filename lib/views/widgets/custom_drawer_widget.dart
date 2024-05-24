import 'package:flutter/material.dart';
import 'package:uyishi/views/screens/home_screen.dart';
import 'package:uyishi/views/screens/setting_screen.dart';

class CustomDrawer extends StatelessWidget {
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> onBackgroundImageChanged;
  final ValueChanged<Color> onAppBarColorChanged;
  final ValueChanged<Color> onScaffoldColorChanged;
  final ValueChanged<double> onTextSizeChanged;
  final ValueChanged<Color> onTextColorChanged;

  const CustomDrawer({
    super.key,
    required this.onThemeChanged,
    required this.onBackgroundImageChanged,
    required this.onAppBarColorChanged,
    required this.onScaffoldColorChanged,
    required this.onTextSizeChanged,
    required this.onTextColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.amber,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Mehmonxonalar"),
                Text("MENYU"),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return HomeScreen(
                      onThemeChanged: onThemeChanged,
                      onBackgroundImageChanged: onBackgroundImageChanged,
                      onAppBarColorChanged: onAppBarColorChanged,
                      onScaffoldColorChanged: onScaffoldColorChanged,
                      onTextSizeChanged: onTextSizeChanged,
                      onTextColorChanged: onTextColorChanged,
                    );
                  },
                ),
              );
            },
            title: const Text("Bosh sahifa"),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (ctx) {
                    return SettingsScreen(
                      onThemeChanged: onThemeChanged,
                      onBackgroundImageChanged: onBackgroundImageChanged,
                      onAppBarColorChanged: onAppBarColorChanged,
                      onScaffoldColorChanged: onScaffoldColorChanged,
                      onTextSizeChanged: onTextSizeChanged,
                      onTextColorChanged: onTextColorChanged,
                    );
                  },
                ),
              );
            },
            title: const Text("Sozlamalar"),
            trailing: const Icon(
              Icons.keyboard_arrow_right,
            ),
          ),
        ],
      ),
    );
  }
}
