import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/deeze_bloc/Category_bloc/category_bloc.dart';
import '../../bloc/deeze_bloc/ringtone_bloc.dart';
import '../../bloc/deeze_bloc/ringtone_state.dart';
import '../../widgets/ringtone_category_card.dart';
import '../../widgets/wallpaper_category_card.dart';
import '../../widgets/widgets.dart';
import '../dashboard/dashboard.dart';
import '../wallpapers/wallpapers.dart';

class Categories extends StatefulWidget {
  final bool isRingtone;
  const Categories({Key? key, required this.isRingtone}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<CategoryBloc>().add(LoadCategory());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                            size: 25,
                          ),
                          const SizedBox(
                            width: 26,
                          ),
                          Text(
                            "Ringtones",
                            style: GoogleFonts.archivo(
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              wordSpacing: -0.09,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
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
                            size: 25,
                          ),
                          const SizedBox(
                            width: 26,
                          ),
                          Text(
                            "Wallpapers",
                            style: GoogleFonts.archivo(
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              wordSpacing: -0.09,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.notifications,
                          color: Colors.amber,
                          size: 25,
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
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              wordSpacing: -0.09,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 25,
                        ),
                        const SizedBox(
                          width: 26,
                        ),
                        Text(
                          "Saved",
                          style: GoogleFonts.archivo(
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            wordSpacing: -0.09,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 45),
                    child: Row(
                      children: [
                        const SizedBox(
                          height: 14,
                          width: 14,
                          child: Icon(
                            Icons.info,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 35,
                        ),
                        Text(
                          "Help",
                          style: GoogleFonts.archivo(
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 45),
                    child: Row(
                      children: [
                        const SizedBox(
                          height: 14,
                          width: 14,
                          child: Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 35,
                        ),
                        Text(
                          "Settings",
                          style: GoogleFonts.archivo(
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 45),
                    child: Row(
                      children: [
                        const SizedBox(
                          height: 14,
                          width: 14,
                          child: Icon(
                            Icons.privacy_tip,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Privacy Policy",
                            style: GoogleFonts.archivo(
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Row(
                      children: [
                        Container(
                          height: 18,
                          width: 18,
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
                          width: 30,
                        ),
                        Text(
                          "Join us on Facebook",
                          style: GoogleFonts.archivo(
                            fontStyle: FontStyle.normal,
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
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
        appBar: AppBar(
          backgroundColor: const Color(0xFF4d047d),
          elevation: 0,
          centerTitle: true,
          leading: Builder(
            builder: (ctx) {
              return GestureDetector(
                  onTap: (() {
                    Scaffold.of(ctx).openDrawer();
                  }),
                  child: Image.asset("assets/menu.png"));
            },
          ),
          title: Text("Categories"),

          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(Icons.search),
            )
          ],
          // title: SizedBox(
          //   height: 35,
          //   child: TextFormField(
          //     style: const TextStyle(color: Colors.white),
          //     decoration: const InputDecoration(
          //       hintText: "Search",
          //       hintStyle: TextStyle(
          //         color: Colors.white,
          //         fontSize: 12,
          //       ),
          //       fillColor: Color(0xFF5d318c),
          //       filled: true,
          //       contentPadding: EdgeInsets.symmetric(
          //         vertical: 5,
          //         horizontal: 20,
          //       ),
          //       focusedBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.all(Radius.circular(7)),
          //         borderSide: BorderSide(color: Color(0xFF5d318c), width: 0),
          //       ),
          //       enabledBorder: OutlineInputBorder(
          //         borderRadius: BorderRadius.all(Radius.circular(7)),
          //         borderSide: BorderSide(color: Color(0xFF5d318c), width: 0.0),
          //       ),
          //       suffixIcon: Icon(
          //         Icons.search,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // ),
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
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
            child: BlocConsumer<CategoryBloc, CategoryState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is CategoryInitial) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is LoadedCategory) {
                  return GridView.builder(
                      itemCount: state.categories?.hydraMember?.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 3 / 1.2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20),
                      itemBuilder: (context, index) {
                        return widget.isRingtone
                            ? RingtoneCategoryCard(
                                id: state.categories!.hydraMember![index].id!,
                                image:
                                    state.categories?.hydraMember?[index].image,
                                name:
                                    state.categories?.hydraMember?[index].name,
                              )
                            : WallpaperCategoryCard(
                                id: state.categories!.hydraMember![index].id!,
                                image:
                                    state.categories?.hydraMember?[index].image,
                                name:
                                    state.categories?.hydraMember?[index].name,
                              );
                      });
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }
}
