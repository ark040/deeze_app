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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
            height: 65,
            width: screenWidth,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
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
                      GestureDetector(
                        onTap: (() async {
                          if (isPlaying) {
                            await audioPlayer.pause();
                          } else {
                            await audioPlayer.play(widget.file);
                          }
                        }),
                        child: Container(
                          height: 35,
                          width: 35,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xFF798975)),
                          child: Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow_sharp,
                            color: Colors.white,
                          ),
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
                        size: 20,
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
            )),
      ),
    );
  }
}
