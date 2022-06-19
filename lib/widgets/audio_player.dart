import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
  @override
  Widget build(BuildContext context) {
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
        child: CarouselSlider.builder(
          itemCount: widget.listHydra.length,
          itemBuilder: (context, index, realIndex) {
            final file = widget.listHydra[index].file;
            final name = widget.listHydra[index].name;
            return BuildPlay(
              file: file!,
              index: index,
              name: name!,
            );
          },
          options: CarouselOptions(height: 600, enableInfiniteScroll: false),
        ),
      ),
    );
  }
}

class BuildPlay extends StatefulWidget {
  final String file;
  final String name;
  final int index;
  const BuildPlay(
      {Key? key, required this.file, required this.name, required this.index})
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
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.PLAYING;
      });
    });
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.name,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          height: 300,
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
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 15,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Abdul",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 13),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Row(
                  children: const [
                    Icon(
                      Icons.arrow_downward,
                      color: Colors.white,
                      size: 13,
                    ),
                    Text(
                      "23k",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 60,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                showCupertinoModalPopup(
                    context: context,
                    builder: (context) {
                      return AudioSelectDialog(
                        file: widget.file,
                      );
                    });
              },
              child: Image.asset(
                "assets/circlemenu.png",
                height: 25,
                width: 20,
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            Image.asset(
              "assets/call.png",
              height: 40,
            ),
            const SizedBox(
              width: 40,
            ),
            const Icon(
              Icons.share_outlined,
              color: Colors.white,
              size: 30,
            ),
          ],
        )
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
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Container(
          height: 380,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    bool success = false;
                    try {
                      success =
                          await RingtoneSet.setRingtoneFromNetwork(widget.file);
                    } on PlatformException {
                      success = false;
                    }
                    var snackBar;
                    if (success) {
                      snackBar = const SnackBar(
                        content: Text("Ringtone set successfully!"),
                      );
                    } else {
                      snackBar = const SnackBar(content: Text("Error"));
                    }
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.call_end_sharp,
                        color: Colors.black,
                        size: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "SET RINGTONE",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          decoration: TextDecoration.none,
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
                    try {
                      success = await RingtoneSet.setNotificationFromNetwork(
                          widget.file);
                    } on PlatformException {
                      success = false;
                    }
                    var snackBar;
                    if (success) {
                      snackBar = const SnackBar(
                        content: Text("Notifications sound  set successfully!"),
                      );
                    } else {
                      snackBar = const SnackBar(content: Text("Error"));
                    }
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.notifications,
                        color: Colors.black,
                        size: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "SET NOTIFICATION",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          decoration: TextDecoration.none,
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
                    } else {
                      snackBar = const SnackBar(content: Text("Error"));
                    }
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Row(
                    children: const [
                      Icon(
                        Icons.alarm,
                        color: Colors.black,
                        size: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "SET ALARM SOUND",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.person,
                      color: Colors.black,
                      size: 30,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "SET TO CONTACT",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                    height: 40,
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
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "SAVE TO MEDIA",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        decoration: TextDecoration.none,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
