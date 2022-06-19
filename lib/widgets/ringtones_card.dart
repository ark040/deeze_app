import 'package:deeze_app/widgets/audio_player.dart';
import 'package:flutter/material.dart';

import '../models/deeze_model.dart';

class RingtonesCard extends StatelessWidget {
  final List<HydraMember> listHydra;
  final int index;
  final String ringtoneName;
  final String file;
  const RingtonesCard(
      {Key? key,
      required this.ringtoneName,
      required this.index,
      required this.file,
      required this.listHydra})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CustomAudioPlayer(
                      listHydra: listHydra,
                      index: index,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
            height: 65,
            width: screenWidth,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                Color(0xFF279A88),
                Color(0xFF737B64),
                Color(0xFF4F4C7E),
                Color(0xFF4F4C7E),
              ]),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 35,
                        width: 35,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFF798975)),
                        child: const Icon(
                          Icons.play_arrow_sharp,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        ringtoneName,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(
                        "assets/heart.png",
                        height: 30,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.arrow_downward,
                            color: Colors.white,
                            size: 15,
                          ),
                          Text(
                            "23k",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
