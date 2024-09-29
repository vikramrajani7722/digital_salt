import 'package:flutter/foundation.dart';

import '../../consts/imports.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  SimpleFontelicoProgressDialog? _dialog;
  TextEditingController fullNameController = TextEditingController();
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
    fullNameController.dispose();
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
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Sign Up",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24, fontFamily: XFonts.poppinsBold)),
                Text("Enter your details below & get free sign up",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: XFonts.poppinsMedium,
                        color: Colors.grey.shade600)),
              ],
            ),
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
                            hintText: "Full Name",
                            errorText: "Full Name is required",
                            text: "Full Name",
                            controller: fullNameController),
                        20.heightBox,
                        TextFormFieldsWidgets.emailTextField(
                            hintText: "Email",
                            errorText: "Email is required",
                            text: "Your Email",
                            controller: emailController),
                        20.heightBox,
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
                        20.heightBox,
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.85,
                            child:
                                ElevatedButtonWidgets.onBoardingElevatedButton(
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        if (isChecked.value) {
                                          signInUser();
                                        } else {
                                          toast(
                                              msg:
                                                  'Please click on checkbox to accept our terms and conditions');
                                        }
                                      }
                                    },
                                    buttonColor: XColors.themeColor,
                                    text: "Create account"),
                          ),
                        ),
                        15.heightBox,
                        Row(
                          children: [
                            Obx(() => SizedBox(
                                  width: 35,
                                  child: Checkbox(
                                    fillColor:
                                        MaterialStateProperty.resolveWith<
                                            Color>((Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.selected)) {
                                        return XColors.themeColor;
                                      }
                                      return Colors.white;
                                    }),
                                    value: isChecked.value,
                                    onChanged: (bool? value) {
                                      isChecked.value = value ?? false;
                                    },
                                  ),
                                )),
                            Text(
                                "By creating an account you have to agree\nwith our terms and conditions",
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                    fontFamily: XFonts.poppinsMedium)),
                          ],
                        ),
                        15.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account?  ",
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12,
                                    fontFamily: XFonts.poppinsMedium)),
                            InkWell(
                              onTap: () {
                                Get.offAll(() => const LoginPage());
                              },
                              child: const Text("Log in",
                                  style: TextStyle(
                                      decorationColor: XColors.themeColor,
                                      decoration: TextDecoration.underline,
                                      color: XColors.themeColor,
                                      fontSize: 12,
                                      fontFamily: XFonts.poppinsSemiBold)),
                            ),
                          ],
                        ),
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

  Future<void> signInUser() async {
    showLoader(_dialog);
    final user = await auth.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    if (user != null) {
      toast(msg: 'You have completed your registration');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(XSpKey.keyLogin, "1");
      prefs.setString(XSpKey.keyFullName, fullNameController.text);
      await addUser();
      _dialog?.hide();
      Get.offAll(() => const BottomNavPage());
    } else {
      toast(msg: 'Something went wrong!');
      _dialog?.hide();
    }
  }

  Future<void> addUser() async {
    try {
      await fireStore.collection('users').add({
        'name': fullNameController.text,
        'email': emailController.text,
        'password': passwordController.text
      });
      if (kDebugMode) {
        print("User added successfully!");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error adding user: $e");
      }
    }
  }
}
