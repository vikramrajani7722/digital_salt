
import '../../consts/imports.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          110.heightBox,
          Center(child: Image.asset(XImages.onboarding_gif)),
          const Text("Create your own\nstudy plan",
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 20, fontFamily: XFonts.poppinsSemiBold)),
          15.heightBox,
          Text("Study according to the\nstudy plan, make study\nmore motivated",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: XFonts.poppinsRegular,
                  color: Colors.grey.shade600)),
          130.heightBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Expanded(
                    child: ElevatedButtonWidgets.onBoardingElevatedButton(
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString(XSpKey.keyOnBoarding, "1");
                          Get.offAll(() => const SignUpPage());
                        },
                        buttonColor: XColors.themeColor,
                        text: "Sign up")),
                15.widthBox,
                Expanded(
                    child: ElevatedButtonWidgets.onBoardingElevatedButton(
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString(XSpKey.keyOnBoarding, "1");
                          Get.offAll(() => const LoginPage());
                        },
                        buttonColor: Colors.white,
                        textColor: XColors.themeColor,
                        text: "Log in")),
              ],
            ),
          )
        ],
      ),
    );
  }
}
