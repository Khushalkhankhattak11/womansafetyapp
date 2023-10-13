import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hinttext;
  final TextEditingController? controller;
  final String? Function(String?)? validtor;
  final String Function(String?)? onSaved;
  final bool? enable;
  final bool? ischeck;
  final FocusNode? focusNode;
  final bool isPassword;
  final int? maxLine;
  final TextInputType? inputType;
  final TextInputAction? textInputAction;

  final Widget? perfix;
  final Widget? supfix;
  const CustomTextField(
      {super.key,
      this.hinttext,
      this.focusNode,
      this.ischeck = true,
      this.controller,
      this.validtor,
      this.onSaved,
      this.enable = true,
      this.isPassword = false,
      this.maxLine,
      this.inputType,
       this.textInputAction,
      this.perfix,
      this.supfix});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        enabled: enable == true ? true : enable,
        maxLines: maxLine == null ? 1 : maxLine,
        onSaved: onSaved,
        focusNode: focusNode,
        textInputAction: textInputAction,
        keyboardType: inputType == null ? TextInputType.name : inputType,
        controller: controller,
        validator: validtor,
        obscureText: isPassword == false ? false : isPassword,
        decoration: InputDecoration(
          prefixIcon: perfix,
          suffixIcon: supfix,
          hintText: hinttext,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                style: BorderStyle.solid,
                color: Colors.green,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                style: BorderStyle.solid,
                color: Colors.black,
              )),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                style: BorderStyle.solid,
                color: Colors.red,
              )),
        ),
      ),
    );
  }
}
