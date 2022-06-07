import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.4,
      decoration: BoxDecoration(
        image: const DecorationImage(
            image: AssetImage(
              "assets/test.jpg",
            ),
            fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            "Love",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
