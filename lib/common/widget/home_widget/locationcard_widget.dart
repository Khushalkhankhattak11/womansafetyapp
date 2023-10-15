import 'package:background_sms/background_sms.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safetyapp/common/widget/components/custom_button_components.dart';
import 'package:safetyapp/features/child/models/contacts_model.dart';
import 'package:safetyapp/features/db/db_servce.dart';

class LocationCardWidget extends StatefulWidget {
  @override
  State<LocationCardWidget> createState() => _LocationCardWidgetState();
}

class _LocationCardWidgetState extends State<LocationCardWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getPermission();
    getCurrentLocation();
  }

  Position? _currentPosition;
  String? _currentAddress;
  LocationPermission? permission;

  getCurrentLocation() async {
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      Fluttertoast.showToast(msg: "Location permission permanent deined");
      if (permission == LocationPermission.deniedForever) {
        Fluttertoast.showToast(
            msg: "Location permission are  permanent deined");
      }
    }

    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLon();
      });
    }).catchError((e) {
      Fluttertoast.showToast(msg: e.toString());
    });
  }

  _getAddressFromLatLon() async {
    try {
      List<Placemark> placemark = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemark[0];
      setState(() {
        _currentAddress =
            "${place.locality} ${place.postalCode}${place.street}";
      });
    } catch (e) {
      print(e);
    }
  }

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
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "SEND YOUR  CURRENT LOCATION IMMEDIATELY TO Your CONTACT",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                if (_currentPosition != null) Text(_currentAddress!),
                CustomButton(
                    title: "Send Location",
                    onpressed: () {
                      getCurrentLocation();
                    }),
                SizedBox(height: 10),
                CustomButton(
                    title: "Send Alert",
                    onpressed: () async {
                      List<ContactModels> contactlist =
                          await DatabaseHelper().getContactList();
                      String reciepents = "";

                      //// send mesage 1,2,3
                      int i = 1;
                      for (ContactModels contact in contactlist) {
                        reciepents += contact.number;
                        if (i != contactlist.length) {
                          reciepents += ";";
                          i++;
                        }
                      }
                      String messageBody = "https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude}%2C${_currentPosition!.longitude}. $_currentAddress";
                      if (await _isPermissionGranted()) {
                        contactlist.forEach((element) {
                          _sms("${element.number}", "I am in trouble please reach at $messageBody",simSlot: 1);
                        });
                      }else{
                        Fluttertoast.showToast(msg: "Msg failed");
                      }
                    }),
              ],
            ),
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

  _getPermission() async => await [Permission.sms].request();

  _isPermissionGranted() async => await Permission.sms.status.isGranted;

  _sms(String phonenumber, String sms, {int? simSlot}) async {
    await BackgroundSms.sendMessage(
            phoneNumber: phonenumber, message: sms, simSlot: simSlot)
        .then((SmsStatus status) {
      if (status == "sent") {
        Fluttertoast.showToast(msg: "sent");
      } else {
        Fluttertoast.showToast(msg: "Failed");
      }
    });
  }
}
