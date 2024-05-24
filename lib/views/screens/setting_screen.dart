import 'package:flutter/material.dart';
import 'package:uyishi/utils/app_constants_utils.dart';
import 'package:uyishi/views/widgets/custom_drawer_widget.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class SettingsScreen extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<String> onBackgroundImageChanged;
  final ValueChanged<Color> onAppBarColorChanged;
  final ValueChanged<Color> onScaffoldColorChanged;
  final ValueChanged<double> onTextSizeChanged;
  final ValueChanged<Color> onTextColorChanged;

  const SettingsScreen({
    super.key,
    required this.onThemeChanged,
    required this.onBackgroundImageChanged,
    required this.onAppBarColorChanged,
    required this.onScaffoldColorChanged,
    required this.onTextSizeChanged,
    required this.onTextColorChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final imageController = TextEditingController();

  @override
  void dispose() {
    imageController.dispose();
    super.dispose();
  }

  void pickColor(ValueChanged<Color> onColorChanged, Color currentColor) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick a color!'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: currentColor,
              onColorChanged: onColorChanged,
              showLabel: true,
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Got it'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sozlamalar"),
        actions: [
          IconButton(
            onPressed: () {
              String imageUrl = imageController.text;
              imageController.clear();
              widget.onBackgroundImageChanged(imageUrl);
            },
            icon: const Icon(Icons.save),
          ),
        ],
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
        child: ListView(
          children: [
            SwitchListTile(
              value: AppConstants.themeMode == ThemeMode.dark,
              onChanged: widget.onThemeChanged,
              title: const Text("Tungi holat"),
            ),
            TextField(
              controller: imageController,
              decoration: const InputDecoration(
                labelText: "Background Image URL",
              ),
            ),
            ListTile(
              title: const Text("AppBar Color"),
              trailing: Container(
                width: 30,
                height: 30,
                color: AppConstants.appBarColor,
              ),
              onTap: () => pickColor(widget.onAppBarColorChanged, AppConstants.appBarColor),
            ),
            ListTile(
              title: const Text("Scaffold Color"),
              trailing: Container(
                width: 30,
                height: 30,
                color: AppConstants.scaffoldColor,
              ),
              onTap: () => pickColor(widget.onScaffoldColorChanged, AppConstants.scaffoldColor),
            ),
            ListTile(
              title: const Text("Text Size"),
              trailing: Text(AppConstants.textSize.toString()),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Select Text Size'),
                      content: SingleChildScrollView(
                        child: Slider(
                          value: AppConstants.textSize,
                          min: 10.0,
                          max: 30.0,
                          divisions: 20,
                          label: AppConstants.textSize.toString(),
                          onChanged: (value) {
                            setState(() {
                              AppConstants.textSize = value;
                            });
                            widget.onTextSizeChanged(value);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            ListTile(
              title: const Text("Text Color"),
              trailing: Container(
                width: 30,
                height: 30,
                color: AppConstants.textColor,
              ),
              onTap: () => pickColor(widget.onTextColorChanged, AppConstants.textColor),
            ),
            ListTile(
              title: const Text("Change Language"),
              trailing: const Icon(Icons.language),
              onTap: () {
                // Implement language change functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}
