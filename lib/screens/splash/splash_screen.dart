import '../../consts/imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateScreen();
  }

  _navigateScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String onBoardingStatus = prefs.getString(XSpKey.keyOnBoarding) ?? "";
    String loginStatus = prefs.getString(XSpKey.keyLogin) ?? "";

    Future.delayed(const Duration(milliseconds: 2000), () {
      if (onBoardingStatus == "1") {
        if (loginStatus == "1") {
          Get.offAll(() => const BottomNavPage());
        } else {
          Get.offAll(() => const SignUpPage());
        }
      } else {
        Get.offAll(() => const OnBoardingScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset(
          XImages.logo,
          width: Get.width * 0.8,
        ),
      ),
    );
  }
}
