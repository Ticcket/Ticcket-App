import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.favorite_rounded,
    Icons.settings_rounded,
    Icons.person_rounded,
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.width * .155,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.15),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .024),
          itemCount: 4,
          itemBuilder: ((context, index) => InkWell(
              onTap: () {
                setState(
                  () {
                    currentIndex = index;
                  },
                );
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    margin: EdgeInsets.only(
                      bottom: index == currentIndex ? 0 : MediaQuery.of(context).size.width * .029,
                      right: MediaQuery.of(context).size.width * .0422,
                      left: MediaQuery.of(context).size.width * .0422,
                    ),
                    width: MediaQuery.of(context).size.width * .128,
                    height: index == currentIndex ? MediaQuery.of(context).size.width * .014 : 0,
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(10),
                      ),
                    ),
                  ),
                  Icon(
                    listOfIcons[index],
                    size: MediaQuery.of(context).size.width * .09,
                    color: currentIndex == index
                        ? Colors.blueAccent
                        : Colors.black38,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * .03),
                ],
              ),
            )
          ),
        ),
      );
  }
}