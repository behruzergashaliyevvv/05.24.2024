import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PinScreen extends StatefulWidget {
  final VoidCallback onUnlock;
  const PinScreen({super.key, required this.onUnlock});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  final pinController = TextEditingController();
  final pinFocusNode = FocusNode();
  bool isPinSet = false;

  @override
  void initState() {
    super.initState();
    _checkPinStatus();
  }

  Future<void> _checkPinStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isPinSet = prefs.getBool('isPinSet') ?? false;
    });
  }

  Future<void> _savePinStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPinSet', status);
  }

  void _submitPin() async {
    if (isPinSet) {
      // Verify PIN
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? savedPin = prefs.getString('pinCode');
      if (savedPin == pinController.text) {
        widget.onUnlock();
      } else {
        // Incorrect PIN, show error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Incorrect PIN")));
      }
    } else {
      // Set new PIN
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('pinCode', pinController.text);
      await _savePinStatus(true);
      widget.onUnlock();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter PIN"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: pinController,
              focusNode: pinFocusNode,
              keyboardType: TextInputType.number,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Enter 4-digit PIN",
              ),
              maxLength: 4,
              onSubmitted: (_) => _submitPin(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitPin,
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
