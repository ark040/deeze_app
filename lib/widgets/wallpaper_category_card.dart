import 'package:cached_network_image/cached_network_image.dart';
import 'package:deeze_app/widgets/wallpaper_dispaly.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/deeze_model.dart';
import '../screens/ringtone/ringtone_by_category.dart';
import '../screens/wallpapers/wallapaper_by_category.dart';

class WallpaperCategoryCard extends StatelessWidget {
  final image;
  final name;
  final int id;
  const WallpaperCategoryCard({
    Key? key,
    this.image,
    this.name,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return image == ""
        ? GestureDetector(
            onTap: (() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WallpaperByCategory(
                    type: name,
                    id: id,
                  ),
                ),
              );
            }),
            child: Container(
              width: screenWidth * 0.4,
              decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage(
                      "assets/no_image.jpg",
                    ),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          )
        : GestureDetector(
            onTap: (() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WallpaperByCategory(
                    type: name,
                    id: id,
                  ),
                ),
              );
            }),
            child: SizedBox(
              width: screenWidth * 0.4,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: image,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
  }
}
