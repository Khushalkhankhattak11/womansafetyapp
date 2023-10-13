import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safetyapp/utiles/constants/const.dart';

class ChildContact extends StatefulWidget {
  const ChildContact({super.key});

  @override
  State<ChildContact> createState() => _ChildContactState();
}

class _ChildContactState extends State<ChildContact> {
  List<Contact> contacts = [];

  Future<void> askpermissionHandler() async {
    PermissionStatus permissionStatus = await getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      getAllContact();
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
    List<Contact> _contacts = await ContactsService.getContacts();
    setState(() {
      contacts = _contacts;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    askpermissionHandler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: contacts.length == 0
            ?const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  Contact contact = contacts[index];
                  String firstLetter = contact.displayName![0].toUpperCase();

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5,top: 10),
                    child: ListTile(
                      leading:
                      contact.avatar !=null && contact.avatar!.length >0?
                      CircleAvatar(
                        radius: 40,
                       backgroundImage: MemoryImage(contact.avatar!),
                      ):CircleAvatar(
                        radius: 40,
                        child: Text(contact.initials()),
                      ),
                      title: Text(contact.displayName!),

                    ),
                  );
                }));
  }
}
