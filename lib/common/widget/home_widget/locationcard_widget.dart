import 'package:flutter/material.dart';

class LocationCardWidget extends StatelessWidget {
  showModelsheet(BuildContext context) {
    showBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height / 1.7,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40))),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModelsheet(context),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          height: 180,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            children: [
              const Expanded(
                  child: Column(
                children: [
                  ListTile(
                    title: Text(
                      "send Location",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                    ),
                    subtitle: Text("Share Location"),
                  )
                ],
              )),
              ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/route.jpg',
                    width: 180,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
