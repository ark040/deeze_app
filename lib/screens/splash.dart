import 'dart:async';

import 'package:deeze_app/screens/wallpapers/wallpapers.dart';
import 'package:flutter/material.dart';

import 'screens.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const WallPapers(
            type: "WALLPAPER",
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4d047d),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/logo.png",
            ),
            const SizedBox(
              height: 10,
            ),
            Image.asset(
              "assets/Ringtones_Wallpape.png",
            ),
          ],
        ),
      ),
    );
  }
}
