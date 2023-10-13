import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safetyapp/common/widget/home_widget/livesafe_cardwidget.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveSafe extends StatelessWidget {
  const LiveSafe({super.key});

  static Future<void> openMap(String location) async {
    String googleMapUrl = "https://www.google.com/maps/search/$location";
    final Uri _url = Uri.parse(googleMapUrl);
    try {
      await launchUrl(_url);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          LiveSafeCardWidget(
            img: "assets/police-badge.png",
            title: "police Stations",
            onpressed: () {
              openMap("police Stations");
            },
          ),
          LiveSafeCardWidget(
            img: "assets/pharmacy.png",
            title: "Pharmacy",
            onpressed: () {
              openMap("Pharmacy");
            },
          ),
          LiveSafeCardWidget(
            img: "assets/hospital.png",
            title: "Hospital",
            onpressed: () {
              openMap("Hospital");
            },
          ),
          LiveSafeCardWidget(
            img: "assets/bus-stop.png",
            title: "Bus Stations",
            onpressed: () {
              openMap("Bus Stations");
            },
          ),
        ],
      ),
    );
  }
}
