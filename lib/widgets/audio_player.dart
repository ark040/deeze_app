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
import 'elevated_button_widget.dart';

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

  String myfile = "";
  @override
  Widget build(BuildContext context) {
    print(widget.index);
    animateToSilde(5);
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
            CarouselSlider.builder(
              carouselController: _controller,
              itemCount: widget.listHydra.length,
              itemBuilder: (context, index, realIndex) {
                final file = widget.listHydra[index].file;
                final name = widget.listHydra[index].name;
                myfile = index == 0
                    ? widget.listHydra[0].file!
                    : widget.listHydra[index - 1].file!;
                return BuildPlay(
                  file: file!,
                  index: index,
                  name: name!,
                  userName: widget.listHydra[index].user!.firstName!,
                  userProfileUrl: widget.listHydra[index].user!.image,
                );
              },
              options: CarouselOptions(
                height: 500,
                pageSnapping: true,
                initialPage: 0,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return AudioSelectDialog(file: myfile);
                        });
                  },
                  child: const Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                Container(
                  height: 37,
                  width: 37,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: const Icon(
                    Icons.add_call,
                    size: 18,
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                const Icon(
                  Icons.share_outlined,
                  color: Colors.white,
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
  const BuildPlay(
      {Key? key,
      required this.file,
      required this.name,
      required this.index,
      required this.userName,
      this.userProfileUrl})
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

    liseten(); // audioPlayer.onDurationChanged.listen((state) {
    //   setState(() {
    //     duration = state;
    //   });
    // });
    // audioPlayer.onAudioPositionChanged.listen((state) {
    //   setState(() {
    //     position = state;
    //   });
    // });
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
    return Column(
      children: [
        Text(
          widget.name,
          style: GoogleFonts.archivo(
            fontStyle: FontStyle.normal,
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          height: 320,
          width: 280,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color(0xFF9f5c96),
                  Color(0xFF93b1b9),
                ]),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
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
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFa28eac),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white),
                  ),
                  child: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow_sharp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Slider(
        //   min: 0,
        //   max: duration.inSeconds.toDouble(),
        //   value: position.inSeconds.toDouble(),
        //   onChanged: onChanged,
        // ),
        // Row(children: [
        //   Text(formatTime())
        // ],)
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  widget.userProfileUrl != null
                      ? CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage(widget.userProfileUrl!),
                        )
                      : const CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 15,
                        ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.userName,
                    style: GoogleFonts.archivo(
                      fontStyle: FontStyle.normal,
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
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
      ],
    );
  }
}

class AudioSelectDialog extends StatefulWidget {
  final String file;
  const AudioSelectDialog({Key? key, required this.file}) : super(key: key);

  @override
  State<AudioSelectDialog> createState() => _AudioSelectDialogState();
}

class _AudioSelectDialogState extends State<AudioSelectDialog> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {}
  Future<bool> downloadFile(String url) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File("${appStorage.path}/video.mp3");
    try {
      final response = await Dio().get(url,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveTimeout: 0));
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      raf.close();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            height: 340,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      bool success = false;
                      ProgressDialog pd = ProgressDialog(
                        context,
                        message: Text(
                          "Please Wait!",
                          style: GoogleFonts.archivo(
                            fontStyle: FontStyle.normal,
                            color: Colors.black,
                          ),
                        ),
                      );
                      pd.show();
                      try {
                        success = await RingtoneSet.setRingtoneFromNetwork(
                            widget.file);
                      } on PlatformException {
                        success = false;
                      }
                      var snackBar;
                      if (success) {
                        snackBar = const SnackBar(
                          content: Text("Ringtone set successfully!"),
                        );
                        Navigator.of(context).pop();
                      } else {
                        snackBar = const SnackBar(content: Text("Error"));
                        Navigator.of(context).pop();
                      }
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.call_end_sharp,
                          color: Colors.black,
                          size: 25,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "SET RINGTONE",
                          style: GoogleFonts.archivo(
                            fontStyle: FontStyle.normal,
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () async {
                      bool success = false;
                      ProgressDialog pd = ProgressDialog(
                        context,
                        message: Text(
                          "Please Wait!",
                          style: GoogleFonts.archivo(
                            fontStyle: FontStyle.normal,
                            color: Colors.black,
                          ),
                        ),
                      );
                      pd.show();
                      try {
                        success = await RingtoneSet.setNotificationFromNetwork(
                            widget.file);
                      } on PlatformException {
                        success = false;
                      }
                      var snackBar;
                      if (success) {
                        snackBar = const SnackBar(
                          content:
                              Text("Notifications sound  set successfully!"),
                        );
                        Navigator.of(context).pop();
                      } else {
                        snackBar = const SnackBar(content: Text("Error"));
                        Navigator.of(context).pop();
                      }
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.notifications,
                          color: Colors.black,
                          size: 25,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "SET NOTIFICATION",
                          style: GoogleFonts.archivo(
                            fontStyle: FontStyle.normal,
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () async {
                      bool success = false;
                      ProgressDialog pd = ProgressDialog(
                        context,
                        message: Text(
                          "Please Wait!",
                          style: GoogleFonts.archivo(
                            fontStyle: FontStyle.normal,
                            color: Colors.black,
                          ),
                        ),
                      );
                      pd.show();
                      try {
                        success =
                            await RingtoneSet.setAlarmFromNetwork(widget.file);
                      } on PlatformException {
                        success = false;
                      }
                      var snackBar;
                      if (success) {
                        snackBar = const SnackBar(
                          content: Text("Alarm sound  set successfully!"),
                        );
                        Navigator.of(context).pop();
                      } else {
                        snackBar = const SnackBar(content: Text("Error"));
                        Navigator.of(context).pop();
                      }
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.alarm,
                          color: Colors.black,
                          size: 25,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "SET ALARM SOUND",
                          style: GoogleFonts.archivo(
                            fontStyle: FontStyle.normal,
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 25,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "SET TO CONTACT",
                        style: GoogleFonts.archivo(
                          fontStyle: FontStyle.normal,
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () async {
                      ProgressDialog pd = ProgressDialog(
                        context,
                        message: Text(
                          "Please Wait!",
                          style: GoogleFonts.archivo(
                            fontStyle: FontStyle.normal,
                            color: Colors.black,
                          ),
                        ),
                      );
                      pd.show();
                      final sucess = await downloadFile(widget.file);
                      var snackBar;
                      if (sucess) {
                        print("sucess");
                        snackBar = const SnackBar(
                          content: Text("Your File  successfully Downloaded"),
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                        height: 37,
                        // margin: EdgeInsets.only(left: 20),
                        width: MediaQuery.of(context).size.width * 0.58,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: <Color>[
                                Color(0xFF7209b7),
                                Color(0xFF5c3fcc),
                              ]),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "SAVE TO MEDIA",
                          style: GoogleFonts.archivo(
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}