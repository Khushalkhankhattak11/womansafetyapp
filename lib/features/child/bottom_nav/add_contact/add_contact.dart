import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safetyapp/common/widget/components/custom_button_components.dart';
import 'package:safetyapp/features/child/bottom_nav/pages/childcontact.dart';
import 'package:safetyapp/features/child/models/contacts_model.dart';
import 'package:sqflite/sqflite.dart';

import '../../../db/db_servce.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<ContactModels> contactsmodelList = [];
  int count = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showList();
    });
  }

  void showList() {
    Future<Database> db = databaseHelper.initializeDatabase();
    db.then((database) {
      Future<List<ContactModels>> futureContactList =
          databaseHelper.getContactList();
      futureContactList.then((value) {
        setState(() {
          this.contactsmodelList = value;
          this.count = value.length;
        });
      });
    });
  }

  void delteContact(ContactModels contactModels) async {
    int result = await databaseHelper.deleteContact(contactModels.id);
    if (result != 0) {
      Fluttertoast.showToast(msg: "Contact Delete Successfully");
      showList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
floatingActionButton: FloatingActionButton(onPressed: ()async{
  bool result = await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => const ChildContact(),
    ),
  );
  if (result == true) {
    showList();
  }
},child: Icon(Icons.add),),
        body: Container(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [

                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: count,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(contactsmodelList[index].name),
                          trailing: Container(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: ()async => await FlutterPhoneDirectCaller.callNumber(contactsmodelList[index].number),
                                    icon: const Icon(
                                      Icons.call,
                                      color: Colors.green,
                                    )),
                                IconButton(
                                    onPressed: () => delteContact(contactsmodelList![index]),
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
