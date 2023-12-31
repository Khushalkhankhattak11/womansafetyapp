import 'package:flutter/material.dart';

Color primaryColor = Color(0xfffc3b77);
dialogueBox(BuildContext context, String text) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(text),
          ));
}

 Widget ProgressDialogs(BuildContext context) {
 return Center(
    child: CircularProgressIndicator(
      strokeWidth: 7,
      backgroundColor: primaryColor,
      color: Colors.red,
    ),
  );
}

AlertsDialog(BuildContext context, String title) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(title),
          ));
}
