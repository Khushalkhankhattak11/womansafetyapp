
import 'package:flutter/material.dart';

class PoliceEmergency extends StatelessWidget {
  const PoliceEmergency({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 10,bottom: 5),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        child: Container(
          height: 180,
          width: MediaQuery.of(context).size.width *0.7,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(colors: [
              Color(0xFFFD8080),
              Color(0xFFFB8080),
              Color(0xFFFBB080),
            ])
          ),
        ),
      ),
    );
  }
}
