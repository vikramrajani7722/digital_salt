import 'package:flutter/cupertino.dart';

import '../../consts/imports.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  final BottomNavController controller = Get.put(BottomNavController());
  final pages = [
    const HomePage(),
    const CoursePage(),
    const WorkInProgressPage(),
    const WorkInProgressPage(),
  ];

  final List<IconData> iconList = [
    Icons.home_outlined,
    Icons.book_outlined,
    Icons.message_outlined,
    Icons.person_outline,
  ];

  final List<String> titleList = ["Home", "Course", "Message", "Account"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<BottomNavController>(
        builder: (val) {
          return pages[val.tappedIndex];
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const SearchPage());
        },
        backgroundColor: XColors.themeColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: const Icon(CupertinoIcons.search, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          return GetBuilder<BottomNavController>(builder: (val) {
            return Column(
              children: [
                8.heightBox,
                Icon(
                  iconList[index],
                  size: val.tappedIndex == index ? 24 : 22,
                  color: val.tappedIndex == index
                      ? XColors.themeColor
                      : Colors.black,
                ),
                Text(
                  titleList[index],
                  style: TextStyle(
                    color: val.tappedIndex == index
                        ? XColors.themeColor
                        : Colors.black,
                    fontFamily: val.tappedIndex == index
                        ? XFonts.poppinsSemiBold
                        : XFonts.poppinsRegular,
                    fontSize: val.tappedIndex == index ? 12 : 10,
                  ),
                )
              ],
            );
          });
        },
        activeIndex: controller.tappedIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.sharpEdge,
        elevation: 5,
        leftCornerRadius: 20,
        rightCornerRadius: 20,
        onTap: (index) => controller.tappedIndexFunc(index),
      ),
    );
  }
}
