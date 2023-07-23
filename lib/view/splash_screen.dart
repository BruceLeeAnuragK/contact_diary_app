import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushNamed("intro_screen");
    });
  }

  ImagePicker picker = ImagePicker();
  int initialIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Icon(Icons.interpreter_mode_outlined,
                size: 200, color: Colors.purple),
            CircularProgressIndicator(
              color: Colors.purple,
            ),
            Text(
              "Welcome to the Contact Diary App 📞",
              style: TextStyle(
                fontSize: 24,
                color: Colors.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
