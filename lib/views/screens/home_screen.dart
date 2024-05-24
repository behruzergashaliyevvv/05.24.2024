import 'package:flutter/material.dart';
import 'package:uyishi/utils/app_constants_utils.dart';
import 'package:uyishi/views/widgets/custom_drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> onBackgroundImageChanged;
  final ValueChanged<Color> onAppBarColorChanged;
  final ValueChanged<Color> onScaffoldColorChanged;
  final ValueChanged<double> onTextSizeChanged;
  final ValueChanged<Color> onTextColorChanged;

  const HomeScreen({
    super.key,
    required this.onThemeChanged,
    required this.onBackgroundImageChanged,
    required this.onAppBarColorChanged,
    required this.onScaffoldColorChanged,
    required this.onTextSizeChanged,
    required this.onTextColorChanged,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bosh Sahifa"),
      ),
      drawer: CustomDrawer(
        onThemeChanged: widget.onThemeChanged,
        onBackgroundImageChanged: widget.onBackgroundImageChanged,
        onAppBarColorChanged: widget.onAppBarColorChanged,
        onScaffoldColorChanged: widget.onScaffoldColorChanged,
        onTextSizeChanged: widget.onTextSizeChanged,
        onTextColorChanged: widget.onTextColorChanged,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: AppConstants.backgroundImageUrl.isEmpty
              ? null
              : DecorationImage(
                  image: NetworkImage(AppConstants.backgroundImageUrl),
                ),
        ),
      ),
    );
  }
}
