import 'package:cached_network_image/cached_network_image.dart';
import 'package:deeze_app/bloc/deeze_bloc/wallpaper_bloc/wallpaper_bloc.dart';
import 'package:deeze_app/screens/tags/tags.dart';
import 'package:deeze_app/screens/wallpapers/wallpapers.dart';
import 'package:deeze_app/widgets/single_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../bloc/deeze_bloc/Category_bloc/category_bloc.dart';
import '../../models/deeze_model.dart';
import '../../services/search_services.dart';
import '../../uitilities/end_points.dart';
import '../../widgets/widgets.dart';
import '../categories/categories.dart';
import '../dashboard/dashboard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../search/search_screen.dart';

class WallpaperByCategory extends StatefulWidget {
  final String type;
  final int id;
  const WallpaperByCategory({Key? key, required this.type, required this.id})
      : super(key: key);

  @override
  State<WallpaperByCategory> createState() => _WallpaperByCategoryState();
}

class _WallpaperByCategoryState extends State<WallpaperByCategory> {
  void initState() {
    // TODO: implement initState
    super.initState();
    // context.read<WallpaperBloc>().add(LoadWallpaperByCategory());
    context.read<CategoryBloc>().add(LoadCategory());
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) => loadData());
  }

  // Future loadData() async {}

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // context.read<DeezeBloc>().close();
  }

  int page = 1;
  late int totalPage;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);

  List<HydraMember> hydraMember = [];
  Future<bool> fetchWallpaperByCategory({bool isRefresh = false}) async {
    if (isRefresh) {
      page = 1;
    } else {
      if (page >= totalPage) {
        _refreshController.loadNoData();
        return false;
      }
    }

    var url = getDeezeAppUrlContent;

    Uri uri = Uri.parse(url).replace(queryParameters: {
      "page": "$page",
      "itemsPerPage": "10",
      "enabled": "true",
      "categories.id": "${widget.id}",
      "type": "WALLPAPER"
    });
    try {
      http.Response response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        print(response.body);
        var rawResponse = deezeFromJson(response.body);
        if (isRefresh) {
          hydraMember = rawResponse.hydraMember!;
        } else {
          hydraMember.addAll(rawResponse.hydraMember!);
        }

        page++;
        totalPage = rawResponse.hydraTotalItems!;
        setState(() {});
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  final SearchServices _searchServices = SearchServices();
  final TextEditingController _typeAheadController = TextEditingController();
  bool ishow = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: ishow
          ? Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: const Color(0xFF4d047d),
                elevation: 0,
                centerTitle: true,
                title: ishow
                    ? SizedBox(
                        height: 35,
                        width: MediaQuery.of(context).size.width,
                        child: TypeAheadFormField<HydraMember?>(
                            suggestionsBoxDecoration:
                                const SuggestionsBoxDecoration(
                                    color: Colors.white),
                            suggestionsCallback: _searchServices.search,
                            debounceDuration: const Duration(milliseconds: 500),
                            // hideSuggestionsOnKeyboardHide: false,
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: _typeAheadController,
                              decoration: InputDecoration(
                                hintText: "Search",
                                hintStyle: const TextStyle(
                                  color: Color(0xFF5d318c),
                                  fontSize: 12,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 20,
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)),
                                  borderSide: BorderSide(
                                      color: Color(0xFF5d318c), width: 0),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)),
                                  borderSide: BorderSide(
                                      color: Color(0xFF5d318c), width: 0.0),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: (() {
                                    setState(() {
                                      ishow = false;
                                    });
                                  }),
                                  child: const Icon(
                                    Icons.clear,
                                    color: Color(0xFF5d318c),
                                  ),
                                ),
                                prefixIcon: const Icon(Icons.search,
                                    color: Color(0xFF5d318c)),
                              ),
                            ),
                            itemBuilder: (context, HydraMember? suggestion) {
                              final ringtone = suggestion!;
                              return GestureDetector(
                                onTap: (() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SearchScreen(
                                              searchText:
                                                  _typeAheadController.text,
                                            )),
                                  );
                                }),
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 30, top: 10),
                                    child: Text(
                                      "${ringtone.name}",
                                      style: GoogleFonts.archivo(
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xFF5d318c),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )),
                              );
                            },
                            onSuggestionSelected: (HydraMember? suggestion) {},
                            noItemsFoundBuilder: (context) => Center(
                                  child: Text(
                                    "No Found",
                                    style: GoogleFonts.archivo(
                                      fontStyle: FontStyle.normal,
                                      color: Color(0xFF5d318c),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                            errorBuilder: (BuildContext context, error) {
                              return Center(
                                child: Text(
                                  "Please enter ",
                                  style: GoogleFonts.archivo(
                                    fontStyle: FontStyle.normal,
                                    color: Color(0xFF5d318c),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }),
                      )
                    : Text(
                        widget.type,
                        style: GoogleFonts.archivo(
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                actions: [
                  ishow
                      ? const SizedBox.shrink()
                      : GestureDetector(
                          onTap: (() {
                            setState(() {
                              ishow = true;
                            });
                          }),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Icon(Icons.search),
                          ),
                        )
                ],
              ),
              backgroundColor: const Color(0xFF4d047d),
              body: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Color(0xFF4d047d),
                          Color(0xFF17131F),
                          Color(0xFF17131F),
                          Color(0xFF17131F),
                          Color(0xFF17131F),
                          Color(0xFF17131F),
                          Color(0xFF17131F),
                        ]),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: SmartRefresher(
                              enablePullUp: true,
                              controller: _refreshController,
                              onRefresh: () async {
                                final result = await fetchWallpaperByCategory(
                                    isRefresh: true);
                                if (result) {
                                  _refreshController.refreshCompleted();
                                } else {
                                  _refreshController.refreshFailed();
                                }
                              },
                              onLoading: () async {
                                final result = await fetchWallpaperByCategory();
                                if (result) {
                                  _refreshController.loadComplete();
                                } else {
                                  _refreshController.loadFailed();
                                }
                              },
                              child: GridView.builder(
                                  itemCount: hydraMember.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 160,
                                          childAspectRatio: 3 / 6,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10),
                                  itemBuilder: (context, index) {
                                    return CategoryCard(
                                      index: index,
                                      listHydra: hydraMember,
                                      image: hydraMember[index].file!,
                                      name: hydraMember[index].name!,
                                    );
                                  }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            )
          : Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xFF4d047d),
                elevation: 0,
                centerTitle: true,
                title: ishow
                    ? SizedBox(
                        height: 30,
                        width: MediaQuery.of(context).size.width,
                        child: TypeAheadField<HydraMember?>(
                            suggestionsBoxDecoration:
                                const SuggestionsBoxDecoration(
                                    color: Color(0xFF4d047d)),
                            suggestionsCallback: _searchServices.searchWallpers,
                            debounceDuration: const Duration(milliseconds: 500),
                            // hideSuggestionsOnKeyboardHide: false,
                            textFieldConfiguration: TextFieldConfiguration(
                              decoration: InputDecoration(
                                hintText: "Search",
                                hintStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                fillColor: Color(0xFF5d318c),
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 20,
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)),
                                  borderSide: BorderSide(
                                      color: Color(0xFF5d318c), width: 0),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)),
                                  borderSide: BorderSide(
                                      color: Color(0xFF5d318c), width: 0.0),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: (() {
                                    setState(() {
                                      ishow = false;
                                    });
                                  }),
                                  child: const Icon(
                                    Icons.clear,
                                    color: Colors.white,
                                  ),
                                ),
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            itemBuilder: (context, HydraMember? suggestion) {
                              final WallpaperByCategory = suggestion!;
                              return GestureDetector(
                                  onTap: (() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SingleWallpaper(
                                          index: 0,
                                          urlImage: WallpaperByCategory.file!,
                                          userName: WallpaperByCategory
                                              .user!.firstName!,
                                          userProfileUrl:
                                              WallpaperByCategory.user!.image,
                                        ),
                                      ),
                                    );
                                  }),
                                  child: WallpaperByCategory.file == null
                                      ? Container(
                                          width: screenWidth * 0.4,
                                          decoration: BoxDecoration(
                                            image: const DecorationImage(
                                                image: AssetImage(
                                                  "assets/no_image.jpg",
                                                ),
                                                fit: BoxFit.fill),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 10),
                                              child: Text(
                                                WallpaperByCategory.name!,
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : SizedBox(
                                          width: screenWidth * 0.4,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              imageUrl:
                                                  WallpaperByCategory.file!,
                                              placeholder: (context, url) =>
                                                  const Center(
                                                      child:
                                                          CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                        ));
                            },
                            onSuggestionSelected: (HydraMember? suggestion) {},
                            noItemsFoundBuilder: (context) => const Center(
                                  child: Text(
                                    "No Found",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Poppins-Regular',
                                    ),
                                  ),
                                ),
                            errorBuilder: (BuildContext context, error) {
                              return const Center(
                                child: Text(
                                  "Please enter ",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Poppins-Regular',
                                  ),
                                ),
                              );
                            }),
                      )
                    : Text(
                        widget.type,
                        style: GoogleFonts.archivo(
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                actions: [
                  ishow
                      ? const SizedBox.shrink()
                      : GestureDetector(
                          onTap: (() {
                            setState(() {
                              ishow = true;
                            });
                          }),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Icon(Icons.search),
                          ),
                        )
                ],
              ),
              backgroundColor: const Color(0xFF4d047d),
              body: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Color(0xFF4d047d),
                          Color(0xFF17131F),
                          Color(0xFF17131F),
                          Color(0xFF17131F),
                          Color(0xFF17131F),
                          Color(0xFF17131F),
                          Color(0xFF17131F),
                        ]),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: SmartRefresher(
                              enablePullUp: true,
                              controller: _refreshController,
                              onRefresh: () async {
                                final result = await fetchWallpaperByCategory(
                                    isRefresh: true);
                                if (result) {
                                  _refreshController.refreshCompleted();
                                } else {
                                  _refreshController.refreshFailed();
                                }
                              },
                              onLoading: () async {
                                final result = await fetchWallpaperByCategory();
                                if (result) {
                                  _refreshController.loadComplete();
                                } else {
                                  _refreshController.loadFailed();
                                }
                              },
                              child: GridView.builder(
                                  itemCount: hydraMember.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 160,
                                          childAspectRatio: 3 / 6,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10),
                                  itemBuilder: (context, index) {
                                    return CategoryCard(
                                      index: index,
                                      listHydra: hydraMember,
                                      image: hydraMember[index].file!,
                                      name: hydraMember[index].name!,
                                    );
                                  }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              drawer: Drawer(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF252030),
                    // gradient: const LinearGradient(colors: [
                    //   Color(0xFF252030),
                    // ]),
                    // borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        MyDrawerHeader(),
                        const SizedBox(
                          height: 40,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Dashbaord(
                                  type: "RINGTONE",
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.volume_up,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: 26,
                                ),
                                Text(
                                  "Ringtones",
                                  style: GoogleFonts.archivo(
                                    fontStyle: FontStyle.normal,
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const WallPapers(
                                  type: "WALLPAPER",
                                ),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.wallpaper,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: 26,
                                ),
                                Text(
                                  "WallpaperByCategory",
                                  style: GoogleFonts.archivo(
                                    fontStyle: FontStyle.normal,
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.notifications,
                                color: Colors.amber,
                                size: 30,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Notifications",
                                  style: GoogleFonts.archivo(
                                    fontStyle: FontStyle.normal,
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.heart_broken,
                                color: Colors.white,
                                size: 30,
                              ),
                              const SizedBox(
                                width: 26,
                              ),
                              Text(
                                "Saved",
                                style: GoogleFonts.archivo(
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Divider(
                          height: 1,
                          thickness: 0.9,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Row(
                            children: [
                              const SizedBox(
                                height: 25,
                                width: 30,
                                child: Icon(
                                  Icons.info,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 26,
                              ),
                              Text(
                                "Help",
                                style: GoogleFonts.archivo(
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Row(
                            children: [
                              const SizedBox(
                                height: 25,
                                width: 30,
                                child: Icon(
                                  Icons.settings,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 26,
                              ),
                              Text(
                                "Settings",
                                style: GoogleFonts.archivo(
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Row(
                            children: [
                              const SizedBox(
                                height: 25,
                                width: 30,
                                child: Icon(
                                  Icons.privacy_tip,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Privacy Policy",
                                  style: GoogleFonts.archivo(
                                    fontStyle: FontStyle.normal,
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Divider(
                          height: 1,
                          thickness: 0.9,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 45),
                          child: Row(
                            children: [
                              Container(
                                height: 25,
                                width: 25,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Image.asset(
                                  "assets/fblogo.png",
                                  color: Colors.black,
                                ),
                              ),
                              // SizedBox(
                              //   height: 25,
                              //   width: 30,
                              //   child: Image.asset(
                              //     "assets/ringtone.png",
                              //     color: Colors.white,
                              //     fit: BoxFit.cover,
                              //   ),
                              // ),
                              const SizedBox(
                                width: 26,
                              ),
                              Text(
                                "Join us on Facebook",
                                style: GoogleFonts.archivo(
                                  fontStyle: FontStyle.normal,
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
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
