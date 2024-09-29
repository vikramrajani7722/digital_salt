import 'package:flutter/cupertino.dart';

import '../../consts/imports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RxString fullName = "".obs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
  }

  Future<void> getDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fullName.value = prefs.getString(XSpKey.keyFullName) ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                      Image.asset(XImages.user_image, height: 37, width: 37)
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
