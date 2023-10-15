import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safetyapp/features/child/models/contacts_model.dart';
import 'package:safetyapp/utiles/constants/const.dart';

import '../../../db/db_servce.dart';

class ChildContact extends StatefulWidget {
  const ChildContact({super.key});

  @override
  State<ChildContact> createState() => _ChildContactState();
}

class _ChildContactState extends State<ChildContact> {
  final TextEditingController searchController = TextEditingController();
  DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Contact> contacts = [];
  List<Contact> contactfilter = [];

  Future<void> askpermission() async {
    PermissionStatus permissionStatus = await getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      getAllContact();
      searchController.addListener(() {
        filterContacct();
      });
    } else {
      handInvaldPermission(permissionStatus);
    }
  }

  Future<PermissionStatus> getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.denied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  handInvaldPermission(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      dialogueBox(context, "Access to contact is denied");
    } else {
      if (permissionStatus == PermissionStatus.permanentlyDenied) {
        dialogueBox(context, "Maybe contact is not exist ");
      }
    }
  }

  getAllContact() async {
    List<Contact> _contacts = await ContactsService.getContacts(
      withThumbnails: false,
    );
    setState(() {
      contacts = _contacts;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    askpermission();
  }

  String flatteredPhoneNumber(String phonenumb) {
    return phonenumb.replaceAllMapped(RegExp(r'^(\+)|\D'), (Match m) {
      return m[0] == "+" ? "+" : "";
    });
  }

  //// filter contact
  filterContacct() {
    List<Contact> _contacts = [];
    _contacts.addAll(contacts);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((element) {
        String searchTerm = searchController.text.toLowerCase();
        String searchtermfiltered = flatteredPhoneNumber(searchTerm);
        String conatcName = element.displayName!.toLowerCase();
        bool matchName = conatcName.contains(searchTerm);
        if (matchName == true) {
          return true;
        }
        if (searchtermfiltered.isEmpty) {
          return false;
        }
        var phone = element.phones!.firstWhere((p) {
          String myphone = flatteredPhoneNumber(p.value!);
          return myphone.contains(searchtermfiltered);
        });
        return phone.value != null;
      });
    }
    setState(() {
      contactfilter = _contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isSearch = searchController.text.isNotEmpty;
    bool listItemexist = (contactfilter.length > 0 || contacts.length > 0);
    return Scaffold(
        body: contacts.length == 0
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          hintText: "Search Contact....",
                          prefixIcon: Icon(Icons.search),
                        ),
                        autofocus: true,
                      ),
                    ),
                    listItemexist == true
                        ? Expanded(
                            child: ListView.builder(
                                itemCount: isSearch == true
                                    ? contactfilter.length
                                    : contacts.length,
                                itemBuilder: (context, index) {
                                  Contact contact = isSearch == true
                                      ? contactfilter[index]
                                      : contacts[index];
                                  String firstLetter =
                                      contact.displayName![0].toUpperCase();

                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 5, top: 10),
                                    child: ListTile(
                                      leading: contact.avatar != null &&
                                              contact.avatar!.length > 0
                                          ? CircleAvatar(
                                              radius: 40,
                                              backgroundImage:
                                                  MemoryImage(contact.avatar!),
                                            )
                                          : CircleAvatar(
                                              radius: 40,
                                              child: Text(contact.initials()),
                                            ),
                                      title: Text(contact.displayName!),
                                      onTap: () {
                                        if (contact.phones!.length > 0) {
                                          final String phoneNum = contact
                                              .phones!
                                              .elementAt(0)
                                              .value!;
                                          final String name =
                                              contact.displayName!;
                                          addContact(
                                              ContactModels(name, phoneNum));
                                        } else {
                                          Fluttertoast.showToast(msg: "Oops! phone number of this Contact is not exists");
                                        }
                                      },
                                    ),
                                  );
                                }),
                          )
                        : Container(
                            child: const Text("Searching"),
                          ),
                  ],
                ),
              ));
  }

  addContact(ContactModels newcontect) async {
    int result = await _databaseHelper.insertContact(newcontect);
    if (result != 0) {
      Fluttertoast.showToast(msg: "Contact Add successfully");
    } else {
      Fluttertoast.showToast(msg: "Failed to add contact");
    }
    Navigator.of(context).pop(true);
  }
}
