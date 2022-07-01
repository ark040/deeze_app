import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:deeze_app/widgets/audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/deeze_model.dart';

class RingtonesCard extends StatefulWidget {
  final List<HydraMember> listHydra;
  final int index;
  final String ringtoneName;
  final String file;
  Duration? duration;
  Duration? position;
  final AudioPlayer audioPlayer;
  bool isPlaying;
  final VoidCallback onTap;
  final Function(double) onChange;
  RingtonesCard(
      {Key? key,
      required this.ringtoneName,
      required this.index,
      required this.file,
      required this.onTap,
      required this.onChange,
      required this.audioPlayer,
      this.duration,
      this.isPlaying = false,
      this.position,
      required this.listHydra})
      : super(key: key);

  @override
  State<RingtonesCard> createState() => _RingtonesCardState();
}

class _RingtonesCardState extends State<RingtonesCard> {
  List mygradientList = const [
    LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        colors: [
          Color(0xFF289987),
          Color(0xFF727b64),
        ]),
    LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        colors: [
          Color(0xFF5951af),
          Color(0xFF5f5b8c),
        ]),
    LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        colors: [
          Color(0xFF5d8897),
          Color(0xFF4f4d7e),
        ]),
    LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFF5048dd),
          Color(0xFF89c0d3),
        ]),
    LinearGradient(
        begin: Alignment.centerRight,
        end: Alignment.centerLeft,
        colors: [
          Color(0xFF5952af),
          Color(0xFF5e5b8c),
        ]),
  ];
  final _random = Random();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    var element = mygradientList[_random.nextInt(mygradientList.length)];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CustomAudioPlayer(
              listHydra: widget.listHydra,
              index: widget.index,
            ),
          ),
        );
      },
      child: SliderTheme(
        data: SliderThemeData(
          trackHeight: 70,
          thumbShape: SliderComponentShape.noOverlay,
          overlayShape: SliderComponentShape.noOverlay,
          valueIndicatorShape: SliderComponentShape.noOverlay,
          trackShape: const RectangularSliderTrackShape(),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
              height: 70,
              width: screenWidth,
              decoration: BoxDecoration(
                gradient: element,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Stack(
                children: [
                  Slider(
                      activeColor: const Color(0xFF4d047d),
                      inactiveColor: Colors.transparent,
                      min: 0,
                      max: widget.duration!.inSeconds.toDouble(),
                      value: widget.position!.inSeconds.toDouble(),
                      onChanged: (value) async {
                        widget.onChange(value);
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: widget.onTap,
                              child: Container(
                                height: 45,
                                width: 45,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF798975)),
                                child: widget.isPlaying
                                    ? Icon(Icons.pause, color: Colors.white)
                                    : Image.asset("assets/Triangle.png"),
                                // child: Icon(
                                //   isPlaying ? Icons.pause : Icons.play_arrow_sharp,
                                //   color: Colors.white,
                                // ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              widget.ringtoneName,
                              style: GoogleFonts.archivo(
                                fontStyle: FontStyle.normal,
                                color: Colors.white,
                                fontSize: 14,
                                wordSpacing: -0.07,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                              size: 25,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.arrow_downward,
                                  color: Colors.white,
                                  size: 11,
                                ),
                                Text(
                                  "23k",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    wordSpacing: -0.07,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
