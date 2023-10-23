import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safetyapp/features/authentication/view/auth/login_auth.dart';
import 'package:safetyapp/utiles/constants/const.dart';

import '../../../../common/widget/components/custom_button_components.dart';
import '../../../../common/widget/components/custom_field_components.dart';
import '../../../../common/widget/spacing_style.dart';
import '../../../child/models/user_model.dart';

class ChildRegistionAuth extends StatefulWidget {
  const ChildRegistionAuth({super.key});

  @override
  State<ChildRegistionAuth> createState() => _ChildRegistionAuthState();
}

class _ChildRegistionAuthState extends State<ChildRegistionAuth> {
  bool isshowpass = true;
  final _formkey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  bool isloading = false;
  _onsubmit() async {
    _formkey.currentState!.save();

    if (_formData["password"] != _formData["rpassword"]) {
      AlertsDialog(
          context, "password and confirm password is not match please correct");
    } else {
      ProgressDialogs(context);
      try {
        setState(() {
          isloading =true;
        });
        UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _formData['email'].toString(),
          password: _formData["password"].toString(),
        );
        if (userCredential.user != null) {
          final value = userCredential.user!.uid;
          DocumentReference<Map<String, dynamic>> db = FirebaseFirestore
              .instance
              .collection('users')
              .doc(value);
          final userdata = UserModel(
              id: value,
              name: _formData['name'].toString(),
              phone: _formData['phone'].toString(),
              childEmail: _formData['cemail'].toString(),
              parentEmail: _formData['gemail'].toString());
          final jsonData = userdata.toJson();
          await db.set(jsonData).whenComplete(() {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => LoginAuth()));
            setState(() {
              isloading =false;
            });
          });
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          isloading =false;
        });
        if (e.code == 'weak password') {
          print("the password provide is too weak");
          AlertsDialog(context, e.toString());
        } else if (e.code == 'email is already provide') {
          print('the email is already provide');
          AlertsDialog(context, e.toString());
        }
      } catch (e) {
        print(e);
        setState(() {
          isloading =false;
        });
        AlertsDialog(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Stack(
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
                      " Register As Child",
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
                          perfix: const Icon(Icons.person),
                          hinttext: "Enter your Name",
                          inputType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          validtor: (name) {
                            if (name!.isEmpty) {
                              return "Please enter a valid name ";
                            }
                            return null;
                          },
                          onSaved: (name) {
                            _formData['cname'] = name ?? "";
                          },
                        ),
                        CustomTextField(
                          perfix: const Icon(Icons.email),
                          hinttext: "Enter your Guardin Email",
                          inputType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validtor: (gemail) {
                            if (gemail!.isEmpty || !gemail.contains('@')) {
                              return "Please enter a valid email address";
                            }
                            return null;
                          },
                          onSaved: (gemail) {
                            _formData['gemail'] = gemail ?? "";
                          },
                        ),
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
                          perfix: const Icon(Icons.phone),
                          hinttext: "Enter your Phone number",
                          inputType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          validtor: (phone) {
                            if (phone!.isEmpty || phone.length < 11) {
                              return "Please enter a phone number";
                            }
                            return null;
                          },
                          onSaved: (phone) {
                            _formData['phone'] = phone ?? "";
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
                          validtor: (confrimpassword) {
                            if (confrimpassword!.isEmpty ||
                                confrimpassword.length < 7) {
                              return "please enter your password";
                            }
                            return null;
                          },
                          onSaved: (confrimpassword) {
                            _formData['rpassword'] = confrimpassword ?? "";
                          },
                          hinttext: "Enter your confirm-password",
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          title: "Register Child",
                          onpressed: () {
                            if (_formkey.currentState!.validate()) {
                              _onsubmit();
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Login in",
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
