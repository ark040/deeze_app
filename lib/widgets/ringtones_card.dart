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
  const RingtonesCard(
      {Key? key,
      required this.ringtoneName,
      required this.index,
      required this.file,
      required this.listHydra})
      : super(key: key);

  @override
  State<RingtonesCard> createState() => _RingtonesCardState();
}

class _RingtonesCardState extends State<RingtonesCard> {
  final audioPlayer = AudioPlayer();

  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    liseten();
    audioPlayer.onDurationChanged.listen((state) {
      setState(() {
        duration = state;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((state) {
      setState(() {
        position = state;
      });
    });
  }

  void liseten() async {
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.dispose();
    isPlaying = false;
    PlayerState.STOPPED;
  }

  List mygradientList = const [
    LinearGradient(colors: [
      Color(0xFF279A88),
      Color(0xFF737B64),
      Color(0xFF4F4C7E),
      Color(0xFF4F4C7E),
    ]),
    LinearGradient(colors: [
      Color(0xFF5951B0),
      Color(0xFF5F5C8C),
      Color(0xFF4F4C7E),
      Color(0xFF4F4C7E),
    ]),
    LinearGradient(colors: [
      Color(0xFF5D8998),
      Color(0xFF4F4C7E),
      Color(0xFF4F4C7E),
      Color(0xFF4F4C7E),
    ]),
    LinearGradient(colors: [
      Color(0xFF89C1D3),
      Color(0xFF5046DE),
      Color(0xFF4F4C7E),
      Color(0xFF4F4C7E),
    ]),
  ];
  final _random = new Random();
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
          trackShape: RectangularSliderTrackShape(),
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
                      max: duration.inSeconds.toDouble(),
                      value: position.inSeconds.toDouble(),
                      onChanged: (value) async {
                        final myposition = Duration(seconds: value.toInt());
                        await audioPlayer.seek(myposition);
                        await audioPlayer.resume();
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: (() async {
                                if (isPlaying) {
                                  await audioPlayer.pause();
                                } else {
                                  await audioPlayer.play(widget.file);
                                }
                              }),
                              child: Container(
                                height: 45,
                                width: 45,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFF798975)),
                                child: isPlaying
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
