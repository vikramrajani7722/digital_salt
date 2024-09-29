import 'package:flutter/foundation.dart';

import '../../consts/imports.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  SimpleFontelicoProgressDialog? _dialog;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool isShowPass = true.obs;
  RxBool isChecked = false.obs;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final auth = AuthService();
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _dialog ??= SimpleFontelicoProgressDialog(context: context);
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          110.heightBox,
          const Padding(
            padding: EdgeInsets.only(left: 18.0),
            child: Text("Log In",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontFamily: XFonts.poppinsBold)),
          ),
          10.heightBox,
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12))),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 15),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        15.heightBox,
                        TextFormFieldsWidgets.emailTextField(
                            hintText: "Email",
                            errorText: "Email is required",
                            text: "Your Email",
                            controller: emailController),
                        25.heightBox,
                        TextFormFieldsWidgets.passwordTextField(
                            isShowPass: isShowPass,
                            suffixOnTap: () {
                              if (isShowPass.value) {
                                isShowPass.value = false;
                              } else {
                                isShowPass.value = true;
                              }
                            },
                            hintText: "Password",
                            errorText: "Password is required",
                            text: "Password",
                            controller: passwordController),
                        8.heightBox,
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text("Forgot Password?",
                              style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                  fontFamily: XFonts.poppinsMedium)),
                        ),
                        20.heightBox,
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.85,
                            child:
                                ElevatedButtonWidgets.onBoardingElevatedButton(
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        logInUser();
                                      }
                                    },
                                    buttonColor: XColors.themeColor,
                                    text: "Log In"),
                          ),
                        ),
                        15.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?  ",
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                    fontFamily: XFonts.poppinsMedium)),
                            InkWell(
                              onTap: () {
                                Get.offAll(() => const SignUpPage());
                              },
                              child: const Text("Sign up",
                                  style: TextStyle(
                                      color: XColors.themeColor,
                                      fontSize: 12,
                                      fontFamily: XFonts.poppinsSemiBold)),
                            ),
                          ],
                        ),
                        15.heightBox,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> logInUser() async {
    showLoader(_dialog);
    final user = await auth.loginUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    if (user != null) {
      toast(msg: 'You have logged in successfully');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(XSpKey.keyLogin, "1");
      await getFullNameFromDatabase();
      _dialog?.hide();
      Get.offAll(() => const BottomNavPage());
    } else {
      toast(msg: 'Something went wrong!');
      _dialog?.hide();
    }
  }

  Future<void> getFullNameFromDatabase() async {
    try {
      QuerySnapshot snapshot = await fireStore
          .collection('users')
          .where('email', isEqualTo: emailController.text)
          .get();

      // Check if any documents were returned
      if (snapshot.docs.isNotEmpty) {
        var userData = snapshot.docs.first.data() as Map<String, dynamic>?;
        String fullName = userData?['name'];
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(XSpKey.keyFullName, fullName);
      } else {}
    } catch (e) {
      if (kDebugMode) {
        print("Error : $e");
      }
    }
  }
}
