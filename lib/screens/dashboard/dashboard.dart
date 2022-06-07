import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';
import '../../widgets/drawer_header.dart';

class Dashbaord extends StatefulWidget {
  const Dashbaord({Key? key}) : super(key: key);

  @override
  State<Dashbaord> createState() => _DashbaordState();
}

class _DashbaordState extends State<Dashbaord> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF4d047d),
          elevation: 0,
          centerTitle: true,
          title: SizedBox(
            height: 35,
            child: TextFormField(
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                fillColor: Color(0xFF5d318c),
                filled: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 20,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  borderSide: BorderSide(color: Color(0xFF5d318c), width: 0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  borderSide: BorderSide(color: Color(0xFF5d318c), width: 0.0),
                ),
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        backgroundColor: const Color(0xFF4d047d),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color(0xFF4d047d),
                  Color(0xFF050000),
                  Color(0xFF050000),
                  Color(0xFF050000),
                  Color(0xFF000000),
                  Color(0xFF000000),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Categories",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    Row(
                      children: const [
                        Text(
                          "View All",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.arrow_right,
                          color: Colors.white,
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 75,
                  width: screenWidth,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: CategoryCard(),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Popular",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 33,
                  width: screenWidth,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Container(
                          width: screenWidth * 0.3,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            "Love",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return RingtonesCard();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 25,
                          width: 30,
                          child: Image.asset(
                            "assets/ringtone.png",
                            color: Colors.white,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 26,
                        ),
                        const Text(
                          "Ringtones",
                          style: TextStyle(
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
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 25,
                          width: 30,
                          child: Image.asset(
                            "assets/wallpapers.png",
                            color: Colors.white,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 26,
                        ),
                        const Text(
                          "Wallpapers",
                          style: TextStyle(
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
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 25,
                          width: 30,
                          child: Image.asset(
                            "assets/notification.png",
                            fit: BoxFit.cover,

                            // color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Notifications",
                            style: TextStyle(
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
                        SizedBox(
                          height: 25,
                          width: 30,
                          child: Image.asset(
                            "assets/heart.png",
                            fit: BoxFit.cover,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 26,
                        ),
                        const Text(
                          "Saved",
                          style: TextStyle(
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
                      children: const [
                        SizedBox(
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
                          style: TextStyle(
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
                      children: const [
                        SizedBox(
                          height: 25,
                          width: 30,
                          child: Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 26,
                        ),
                        Text(
                          "Settings",
                          style: TextStyle(
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
                      children: const [
                        SizedBox(
                          height: 25,
                          width: 30,
                          child: Icon(
                            Icons.privacy_tip,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Privacy Policy",
                            style: TextStyle(
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
                        const Text(
                          "Join us on Facebook",
                          style: TextStyle(
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
