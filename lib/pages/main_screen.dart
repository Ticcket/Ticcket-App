import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ticcket/pages/main_screen/events.dart';
import 'package:ticcket/pages/main_screen/profile.dart';
import 'package:ticcket/pages/main_screen/home.dart';
import 'package:ticcket/pages/main_screen/organized_events.dart';
import 'package:ticcket/core/res/color.dart';
import 'package:ticcket/core/routes/routes.dart';
import 'package:ticcket/widgets/circle_gradient_icon.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final screens = [
    const HomeScreen(),
    const EventsScreen(),
    const OrganizedEventsScreen(),
    const ProfileScreen(),
  ];

  PageController pv = new PageController();

  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.menu_open,
    Icons.qr_code,
    Icons.person_rounded,
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DateFormat.MMMEd().format(DateTime.now()),
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CircleGradientIcon(
              onTap: () {
                Navigator.pushNamed(context, Routes.todaysTask);
              },
              icon: Icons.calendar_month,
              color: AppColors.primarySwatch,
              iconSize: 24,
              size: 40,
            ),
          )
        ],
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: InkWell(
              onTap: () {},
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(
                Icons.menu_rounded,
              ),
            ),
          ),
        ),
      ),
      extendBody: true,
      bottomNavigationBar: Container(
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
                pv.animateToPage(currentIndex, duration: Duration(milliseconds: 300), curve: Curves.easeIn);
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
                    size: MediaQuery.of(context).size.width * .076,
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
      ),
      body: PageView(
        controller: pv,
        children: screens,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}