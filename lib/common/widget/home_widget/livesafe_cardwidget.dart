import 'package:flutter/material.dart';

class LiveSafeCardWidget extends StatelessWidget {
  final String img;
  final String title;
  final VoidCallback onpressed;
  const LiveSafeCardWidget(
      {super.key,
        required this.img,
        required this.title,
        required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                height: 50,
                width: 50,
                child: Center(
                    child: Image.asset(
                      img,
                      height: 32,
                    )),
              ),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}
