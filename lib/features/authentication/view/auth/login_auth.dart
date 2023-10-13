import 'package:flutter/material.dart';
import 'package:safetyapp/common/widget/components/custom_field_components.dart';
import 'package:safetyapp/common/widget/spacing_style.dart';

class LoginAuth extends StatelessWidget {
  const LoginAuth({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: TSpacingStyle.paddingwithAppbarHeight,
        child: Column(
          children: [
            //// logo, text, image
            Column(
              children: [
                
              ],
            ), 
            
            Form(child: Column(children: [
             CustomTextField(
               perfix: Icon(Icons.person),
               hinttext: "Enter your Name",
             ),
              CustomTextField(
                perfix: Icon(Icons.lock_outline_rounded),
                supfix: Icon(Icons.visibility),
                hinttext: "Enter your password",
              ),
            ],))
          ],
        ),
      ),
    ));
  }
}
