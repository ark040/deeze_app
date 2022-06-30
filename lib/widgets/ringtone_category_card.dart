import 'package:cached_network_image/cached_network_image.dart';
import 'package:deeze_app/widgets/wallpaper_dispaly.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/deeze_model.dart';
import '../screens/ringtone/ringtone_by_category.dart';

class RingtoneCategoryCard extends StatelessWidget {
  final image;
  final name;
  final int id;
  const RingtoneCategoryCard({
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
                  builder: (context) => RingtoneByCategory(
                    type: name,
                    id: id,
                  ),
                ),
              );
            }),
            child: Container(
              width: 116.4,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Color(0x01000000),
                      Color(0x34000000),
                      Color(0xFF4F4C7E),
                      Color(0xFF030303),
                    ]),
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
                    style: GoogleFonts.archivo(
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                      fontSize: 15,
                      wordSpacing: 0.19,
                      fontWeight: FontWeight.w600,
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
                  builder: (context) => RingtoneByCategory(
                    type: name,
                    id: id,
                  ),
                ),
              );
            }),
            child: SizedBox(
              width: 116.4,
              child: Stack(
                children: [
                  Container(
                    width: 116.4,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Color(0x01000000),
                            Color(0x34000000),
                            Color(0xFF4F4C7E),
                            Color(0xFF030303),
                          ]),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: image,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Text(
                        name,
                        style: GoogleFonts.archivo(
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                          fontSize: 15,
                          wordSpacing: 0.19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
