import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../policeemergency_widget.dart';

class EmergencyWidget extends StatelessWidget {

  _callNumber(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 190,
      child: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children:   [
          InkWell(
            onTap: ()=>_callNumber('15'),
            child: PoliceEmergency(
              img: "assets/alert.png",
              title: "Active Emergency",
              subtitle: "Call 0-1-5 for Emergency",
              btntitle: "0-1-5",
            ),
          ),

          InkWell(
            onTap: ()=>_callNumber('1717'),
            child: const PoliceEmergency(
              img: "assets/army.png",
              title: "NACTA",
              subtitle: "National Counter Terrorism Authority",
              btntitle: "1-7-1-7",
            ),
          ),

          InkWell(
            onTap: ()=>_callNumber('1122'),
            child: const PoliceEmergency(
              img: "assets/ambulance.png",
              title: "Ambulance",
              subtitle: "In case of Medical Emergency",
              btntitle: "1-1-2-2",
            ),
          ),

          InkWell(
            onTap: ()=>_callNumber('16'),
            child: const PoliceEmergency(
              img: "assets/flame.png",
              title: "Fire Brigade",
              subtitle: "In case of Fire Emergency",
              btntitle: "1-6",
            ),
          ),
        ],
      ),
    );
  }
}
