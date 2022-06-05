import 'package:deeze_app/screens/login.dart';
import 'package:deeze_app/screens/profile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0xFF4d047d),
                Color(0xFF4d047d),
                Color(0xFF050000),
                Color(0xFF050000),
                Color(0xFF000000),
                Color(0xFF000000),
              ]),
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 220.0),
              child: Image.asset(
                "assets/logo.png",
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Image.asset(
              "assets/pimp_your_android_de.png",
            ),
            const SizedBox(
              height: 70,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => Profile(),
                  ),
                );
              },
              child: Image.asset(
                "assets/google.png",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => Profile(),
                  ),
                );
              },
              child: Image.asset(
                "assets/facebook.png",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => Login(),
                  ),
                );
              },
              child: Image.asset(
                "assets/normal.png",
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => Profile(),
                  ),
                );
              },
              child: Text(
                "New Here? Sign Up >",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
