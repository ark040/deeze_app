import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final image;
  final name;
  const CategoryCard({Key? key, this.image, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth * 0.4,
      decoration: BoxDecoration(
        image: image == ""
            ? const DecorationImage(
                image: AssetImage(
                  "assets/no_image.jpg",
                ),
                fit: BoxFit.cover)
            : DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            name,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
