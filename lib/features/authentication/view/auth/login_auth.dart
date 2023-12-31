import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safetyapp/common/widget/components/custom_button_components.dart';
import 'package:safetyapp/common/widget/components/custom_field_components.dart';
import 'package:safetyapp/common/widget/spacing_style.dart';
import 'package:safetyapp/features/authentication/view/auth/child_registerauth.dart';
import 'package:safetyapp/features/authentication/view/auth/parents_registerauth.dart';
import 'package:safetyapp/features/child/bottom_nav/pages/childhome.dart';
import 'package:safetyapp/features/child/navbar.dart';
import 'package:safetyapp/utiles/constants/const.dart';

class LoginAuth extends StatefulWidget {
  LoginAuth({super.key});

  @override
  State<LoginAuth> createState() => _LoginAuthState();
}

class _LoginAuthState extends State<LoginAuth> {
  bool isshowpass = true;
  final _formkey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool isloading = false;
  _onsubmit() async {
    _formkey.currentState!.save();

    try {
      setState(() {
        isloading = true;
      });
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _formData['email'].toString(),
              password: _formData['password'].toString());
      if(userCredential.user !=null){

        setState(() {
          isloading =false;
        });
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>const HomeView()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isloading =false;
      });
      if (e.code == "user-not-found") {
        AlertsDialog(context, "no user found");
        print("no user found");
      } else if (e.code == "wrong-password") {
        AlertsDialog(context, "wrong password provided for user");
        print("wrong password provided for user");
      }
    }
    print(_formData['email']);
    print(_formData['password']);
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => NavBarBottom()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            isloading ? ProgressDialogs(context):
            SingleChildScrollView(
      child: Padding(
            padding: TSpacingStyle.paddingwithAppbarHeight,
            child: Column(
              children: [
                //// logo, text, image
                const Column(
                  children: [
                    Image(
                      image: AssetImage(
                        "assets/logo.png",
                      ),
                      height: 150,
                    ),
                    Text(
                      "User Login",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Color(0xfffc3b77)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        CustomTextField(
                          perfix: const Icon(Icons.email),
                          hinttext: "Enter your Email",
                          inputType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validtor: (email) {
                            if (email!.isEmpty || !email.contains('@')) {
                              return "Please enter a valid email address";
                            }
                            return null;
                          },
                          onSaved: (email) {
                            _formData['email'] = email ?? "";
                          },
                        ),
                        CustomTextField(
                          isPassword: isshowpass,
                          perfix: const Icon(Icons.lock_outline_rounded),
                          supfix: IconButton(
                            onPressed: () {
                              setState(() {
                                isshowpass = !isshowpass;
                              });
                            },
                            icon: isshowpass
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          ),
                          validtor: (password) {
                            if (password!.isEmpty || password.length < 7) {
                              return "please enter your password";
                            }
                            return null;
                          },
                          onSaved: (password) {
                            _formData['password'] = password ?? "";
                          },
                          hinttext: "Enter your password",
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 16),
                            ),
                          ),
                        ),
                        CustomButton(
                          title: "Login",
                          onpressed: () {
                            if (_formkey.currentState!.validate()) {
                              _onsubmit();
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const ChildRegistionAuth()));
                          },
                          child: const Text(
                            "Register as child",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const ParentsRegistionAuth()));
                          },
                          child: const Text(
                            "Register as parents",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
      ),
    ),
          ],
        ));
  }
}
