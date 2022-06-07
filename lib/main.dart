import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:deeze_app/screens/dashboard/dashboard.dart';
import 'package:deeze_app/screens/splash.dart';
import 'package:deeze_app/screens/wallpapers/wallpapers.dart';
import 'package:flutter/material.dart';

import 'screens/categories/categories.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription? connectivitySubcription;
  ConnectivityResult? connectivityResult;

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Wallpaers(),
    );
  }
}
