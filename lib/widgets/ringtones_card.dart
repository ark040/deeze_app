import 'package:flutter/material.dart';

class RingtonesCard extends StatelessWidget {
  const RingtonesCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
          height: 65,
          width: screenWidth,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [
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
                    Container(
                      height: 35,
                      width: 35,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFF798975)),
                      child: Icon(
                        Icons.play_arrow_sharp,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Iphone ringtones",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      "assets/heart.png",
                      height: 30,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_downward,
                          color: Colors.white,
                          size: 15,
                        ),
                        Text(
                          "23k",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
