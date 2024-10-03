import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../consts/imports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RxString fullName = "".obs;
  final CourseController controller = Get.put(CourseController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
  }

  Future<void> getDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fullName.value = prefs.getString(XSpKey.keyFullName) ?? "";
    await controller.getProductsData();
    await controller.getCategoryData();
    controller.getAllBrands();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.25,
                  color: XColors.themeColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        70.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(() => Text("Hi, ${fullName.value}",
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: XFonts.poppinsBold))),
                                  const Text("Let's start learning",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: XFonts.poppinsMedium)),
                                ],
                              ),
                            ),
                            Image.asset(XImages.user_image,
                                height: 37, width: 37)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 20,
                  right: 20,
                  child: Card(
                    color: Colors.white,
                    shadowColor: Colors.white,
                    elevation: 2,
                    surfaceTintColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Learned today",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12,
                                      fontFamily: XFonts.poppinsMedium)),
                              const Text("My Courses",
                                  style: TextStyle(
                                      color: XColors.themeColor,
                                      fontSize: 12,
                                      fontFamily: XFonts.poppinsMedium)),
                            ],
                          ),
                          5.heightBox,
                          Row(
                            children: [
                              const Text("46min",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: XFonts.poppinsBold)),
                              Text("/ 60min",
                                  style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 10,
                                      fontFamily: XFonts.poppinsMedium)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          20.heightBox,
          const Padding(
           padding:  EdgeInsets.symmetric(horizontal: 12.0),
           child:  Text("Your Courses",
               style: TextStyle(
                   color: Colors.black,
                   fontSize: 16,
                   fontFamily: XFonts.poppinsSemiBold)),
         ),
         GetBuilder<CourseController>(builder: (val) {
           return Expanded(
             child: ListView.builder(
                 padding: EdgeInsets.zero,
                 scrollDirection: Axis.vertical,
                 physics: const BouncingScrollPhysics(),
                 itemCount: 5,
                 itemBuilder: (context, index) {
                   final data = val.filteredList[index];
                   return courseWidget(data, context);
                 }),
           );
         })
        ],
      ),
    );
  }
}
