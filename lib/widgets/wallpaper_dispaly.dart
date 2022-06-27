import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ndialog/ndialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ringtone_set/ringtone_set.dart';

import '../models/deeze_model.dart';

class WallPaperSlider extends StatefulWidget {
  final List<HydraMember>? listHydra;
  final int? index;
  const WallPaperSlider({Key? key, this.listHydra, this.index})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WallPaperSliderState createState() => _WallPaperSliderState();
}

class _WallPaperSliderState extends State<WallPaperSlider> {
  final CarouselController _controller = CarouselController();
  String file = "";
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
        .addPostFrameCallback((timeStamp) => animateToSilde(widget.index!));
  }

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider.builder(
              carouselController: _controller,
              itemCount: widget.listHydra?.length,
              itemBuilder: (context, index, realIndex) {
                final urlImage = widget.listHydra![index].file!;
                file = index == 0
                    ? widget.listHydra![0].file!
                    : widget.listHydra![index - 1].file!;
                return buildImage(
                    urlImage: urlImage,
                    index: index,
                    userName: widget.listHydra![index].user!.firstName!,
                    userProfileUrl: widget.listHydra![index].user!.image);
              },
              options: CarouselOptions(
                height: 600,
                enableInfiniteScroll: false,
                pageSnapping: true,
                enlargeCenterPage: true,
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
                          return WallpaperSelectDialog(file: file);
                        });
                  },
                  child: const Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 70,
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
                  width: 70,
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

  Widget buildImage({
    required String urlImage,
    required int index,
    required String userName,
    String? userProfileUrl,
  }) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          width: double.infinity,
          height: 450,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: urlImage,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  userProfileUrl != null
                      ? CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage(userProfileUrl),
                        )
                      : const CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 15,
                        ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    userName,
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

class WallpaperSelectDialog extends StatefulWidget {
  final String file;
  const WallpaperSelectDialog({Key? key, required this.file}) : super(key: key);

  @override
  State<WallpaperSelectDialog> createState() => _WallpaperSelectDialogState();
}

class _WallpaperSelectDialogState extends State<WallpaperSelectDialog> {
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  bool isloading = false;
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {}
  Future<bool> setWallpaper() async {
    try {
      String url = widget.file;
      int location = WallpaperManager
          .HOME_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(url);
      final bool result =
          await WallpaperManager.setWallpaperFromFile(file.path, location);
      return result;
    } on PlatformException {
      return false;
    }
  }

  Future<bool> downloadFile(String url) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File("${appStorage.path}/wallpaper.png");
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

  Future<bool> setLockWallpaper() async {
    try {
      String url = widget.file;
      int location = WallpaperManager
          .LOCK_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(url);
      final bool result =
          await WallpaperManager.setWallpaperFromFile(file.path, location);
      return result;
    } on PlatformException {
      return false;
    }
  }

  Future<bool> setBothScreenWallpaper() async {
    try {
      String url = widget.file;
      int location = WallpaperManager
          .BOTH_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(url);
      final bool result =
          await WallpaperManager.setWallpaperFromFile(file.path, location);
      return result;
    } on PlatformException {
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
                      final isSucces = await setWallpaper();
                      if (isSucces) {
                        Fluttertoast.showToast(
                          msg: "Wallpaper succesfully Updated!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: const Color(0xFF7209b7),
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.wallpaper,
                          color: Colors.black,
                          size: 25,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "SET WALLPAPER",
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
                      final isSucces = await setLockWallpaper();
                      if (isSucces) {
                        Fluttertoast.showToast(
                          msg: "Wallpaper succesfully Updated!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: const Color(0xFF7209b7),
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.lock,
                          color: Colors.black,
                          size: 25,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "SET LOCK SCREEN",
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
                      final isSucces = await setBothScreenWallpaper();
                      if (isSucces) {
                        Fluttertoast.showToast(
                          msg: "Wallpaper succesfully Updated!",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: const Color(0xFF7209b7),
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.phonelink_lock_rounded,
                          color: Colors.black,
                          size: 25,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          "SET BOTH",
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
                        Fluttertoast.showToast(
                          msg: "Wallpaper succesfully Downloaded",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: const Color(0xFF7209b7),
                          textColor: Colors.white,
                          fontSize: 16.0,
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
