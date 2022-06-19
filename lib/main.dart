import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:deeze_app/bloc/deeze_bloc/bloc/category_bloc.dart';
import 'package:deeze_app/screens/dashboard/dashboard.dart';
import 'package:deeze_app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/deeze_bloc/deeze_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<DeezeBloc>(
          create: (BuildContext context) => DeezeBloc(),
        ),
        BlocProvider<CategoryBloc>(
          create: (BuildContext context) => CategoryBloc(),
        ),
      ],
      child:
          MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen()),
    );
  }
}
