import 'package:flutter/material.dart';

import '../../../../common/widget/components/custom_button_components.dart';
import '../../../../common/widget/components/custom_field_components.dart';
import '../../../../common/widget/spacing_style.dart';

class ParentsRegistionAuth extends StatefulWidget {
  const ParentsRegistionAuth({super.key});

  @override
  State<ParentsRegistionAuth> createState() => _ParentsRegistionAuthState();
}

class _ParentsRegistionAuthState extends State<ParentsRegistionAuth> {
  bool isshowpass = true;
  final _formkey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  _onsubmit(){
    _formkey.currentState!.save();
    print(_formData['name']);
    print(_formData['email']);
    print(_formData['cemail']);
    print(_formData['phone']);
    print(_formData['password']);
    print(_formData['confrimpassword']);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: SingleChildScrollView(
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
                      " Register As Parents",
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
                            if (name!.isEmpty ) {
                              return "Please enter a valid name ";
                            }
                            return null;
                          },
                          onSaved: (name) {
                            _formData['name'] = name ?? "";
                          },
                        ),
                        CustomTextField(
                          perfix: const Icon(Icons.email),
                          hinttext: "Enter your child Email",
                          inputType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validtor: (cemail) {
                            if (cemail!.isEmpty || !cemail.contains('@')) {
                              return "Please enter a valid email address";
                            }
                            return null;
                          },
                          onSaved: (cemail) {
                            _formData['cemail'] = cemail ?? "";
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
                            if (phone!.isEmpty || phone.length<11) {
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
                            if (confrimpassword!.isEmpty || confrimpassword.length < 7) {
                              return "please enter your password";
                            }
                            return null;
                          },
                          onSaved: (confrimpassword) {
                            _formData['confrimpassword'] = confrimpassword ?? "";
                          },
                          hinttext: "Enter your confirm-password",
                        ),
                        const SizedBox(height: 10),

                        CustomButton(
                          title: "Register ",
                          onpressed: () {
                            if(_formkey.currentState!.validate()){
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
        ));
  }
}
