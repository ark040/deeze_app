import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ndialog/ndialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ringtone_set/ringtone_set.dart';

import '../models/deeze_model.dart';
import 'audio_select_dialog.dart';
import 'elevated_button_widget.dart';
import 'more_audio_dialog.dart';

class CustomAudioPlayer extends StatefulWidget {
  final List<HydraMember> listHydra;
  final int index;
  const CustomAudioPlayer(
      {Key? key, required this.listHydra, required this.index})
      : super(key: key);

  @override
  State<CustomAudioPlayer> createState() => _CustomAudioPlayerState();
}

class _CustomAudioPlayerState extends State<CustomAudioPlayer> {
  final CarouselController _controller = CarouselController();

  animateToSilde(int index) => _controller.animateToPage(
        index,
        duration: Duration(milliseconds: 100),
        curve: Curves.linear,
      );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => animateToSilde(widget.index));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  late int activeIndex = widget.index;
  String myfile = "";
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0xFF965a90),
                Color(0xFF815d84),
                Color(0xFF56425d),
                Color(0xFF17131f),
                Color(0xFF17131f),
                Color(0xFF17131f),
              ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.listHydra[activeIndex].name!,
              style: GoogleFonts.archivo(
                fontStyle: FontStyle.normal,
                color: Colors.white,
                fontSize: 20,
                wordSpacing: -0.1,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CarouselSlider.builder(
              carouselController: _controller,
              itemCount: widget.listHydra.length,
              itemBuilder: (context, index, realIndex) {
                final file = widget.listHydra[index].file;
                final name = widget.listHydra[index].name;
                // myfile = index == 0
                //     ? widget.listHydra[0].file!
                //     : widget.listHydra[index - 1].file!;
                return BuildPlay(
                  activeIndex: activeIndex,
                  file: file!,
                  index: index,
                  name: name!,
                  userName: widget.listHydra[index].user!.firstName!,
                  userProfileUrl: widget.listHydra[index].user!.image,
                );
              },
              options: CarouselOptions(
                  height: 272,
                  pageSnapping: true,
                  viewportFraction: 0.73,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(() {
                      myfile = widget.listHydra[index].file!;
                      activeIndex = index;
                    });
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      widget.listHydra[activeIndex].user?.image != null
                          ? CircleAvatar(
                              radius: 15,
                              backgroundImage: NetworkImage(
                                widget.listHydra[activeIndex].user!.image!,
                              ),
                            )
                          : const CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 15,
                            ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        widget.listHydra[activeIndex].user!.firstName!,
                        style: GoogleFonts.archivo(
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                          fontSize: 15,
                          wordSpacing: -0.05,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.arrow_downward,
                          color: Colors.white,
                          size: 13,
                        ),
                        Text(
                          "23k",
                          style: GoogleFonts.archivo(
                              fontStyle: FontStyle.normal, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 45,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return MoreAudioDialog(
                            file: myfile,
                            fileName: widget.listHydra[activeIndex].name!,
                            userName:
                                widget.listHydra[activeIndex].user!.firstName!,
                            userImage:
                                widget.listHydra[activeIndex].user!.image!,
                          );
                        });
                  },
                  child: const Icon(
                    Icons.more_horiz,
                    color: Colors.grey,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                GestureDetector(
                  onTap: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return AudioSelectDialog(file: myfile);
                        });
                  },
                  child: Container(
                    height: 43,
                    width: 43,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child: const Icon(
                      Icons.phone_callback,
                      size: 25,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                const Icon(
                  Icons.share_outlined,
                  color: Colors.grey,
                  size: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BuildPlay extends StatefulWidget {
  final String file;
  final String name;
  final String userName;
  final String? userProfileUrl;
  final int index;
  final int activeIndex;
  const BuildPlay(
      {Key? key,
      required this.file,
      required this.name,
      required this.index,
      required this.userName,
      this.userProfileUrl,
      required this.activeIndex})
      : super(key: key);

  @override
  State<BuildPlay> createState() => _BuildPlayState();
}

class _BuildPlayState extends State<BuildPlay> {
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 272,
        thumbShape: SliderComponentShape.noOverlay,
        overlayShape: SliderComponentShape.noOverlay,
        valueIndicatorShape: SliderComponentShape.noOverlay,
        trackShape: RectangularSliderTrackShape(),
      ),
      child: Container(
        width: 254,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xFF9f5c96),
                Color(0xFF93b1b9),
              ]),
          borderRadius: BorderRadius.circular(6),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                        height: 88,
                        width: 88,
                        margin: EdgeInsets.only(left: screenWidth * 0.2),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFFa28eac),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow_sharp,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: double.infinity,
                  width: 61,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          Color(0xFF9a83a6),
                          Color(0xFF93b4bb),
                        ]),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ),
                  ),
                  child: widget.activeIndex == widget.index
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 15, right: 15),
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: Image.asset("assets/image_heart.png")),
                        )
                      : SizedBox.shrink(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
