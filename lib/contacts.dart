import 'package:contacts/edit.dart';
import 'package:contacts/newcontact.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List<Contact> contacts = [];
  List _searchcontacts = [];
  //String? imagepath;
  //bool isLoading = false;
  bool issearch = false;
  @override
  void initState() {
    _searchcontacts = contacts;
    getphoneData();
    super.initState();
  }

  void _runfilter(String enterkey) {
    List results = [];
    if (enterkey.isEmpty) {
      results = contacts;
    } else {
      results = contacts
          .where((element) =>
              element.name.first
                  .toLowerCase()
                  .contains(enterkey.toLowerCase()) ||
              element.phones.any((element) => element.number
                  .toLowerCase()
                  .contains(enterkey.toLowerCase())))
          .toList();
    }
    setState(() {
      _searchcontacts = results;
    });
  }

  void getphoneData() async {
    var status = await Permission.contacts.request();

    if (status.isGranted) {
      //   setState(() {
      //  //   isLoading = true;
      //   });
      final phoneContacts = await FlutterContacts.getContacts(
          withAccounts: true, withProperties: true, withPhoto: true);

      setState(() {
        contacts = phoneContacts;
        _searchcontacts = contacts;
        //  isLoading = false;
      });
    }
  }

  void showAlertBox(Contact person) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          backgroundColor: Colors.white,
          title: const Text(
            "DO YOU WANT TO DELETE THIS CONTACT",
            style: TextStyle(fontSize: 16, color: Colors.black),
            overflow: TextOverflow.clip,
          ),
          actions: [
            TextButton(
                onPressed: () async {
                  await FlutterContacts.deleteContact(person);
                  Navigator.pop(context);
                  getphoneData();
                },
                child: const Text(
                  "YES",
                  style: TextStyle(color: Colors.black),
                )),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "NO",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(milliseconds: 10), () {
      getphoneData();
    });
  }

  void _makeCall(String number) async {
    //   // bool? callPlaced = await FlutterPhoneDirectCaller.callNumber(number);
    //   // if (callPlaced != null && callPlaced) {
    //   //   print('Call placed successfully');
    //   // } else {
    //   //   if (await canLaunchUrl(Uri.parse('tel:$number'))) {
    //   //     await launchUrl(Uri.parse('tel:$number'));
    //   //   } else {
    //   //     print('Could not launch dialer');
    //   //   }
    //   // }
    // await launchUrl(Uri.parse("tel:${number}"));
    FlutterPhoneDirectCaller.callNumber(contacts.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: false,
        title: Text(
          "My Contacts",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Newcontacts()));
              },
              icon: Icon(
                Icons.person_add_alt,
                color: Colors.white,
              ))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Container(
            padding: EdgeInsets.all(15),
            height: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            child:
                //isLoading
                (contacts.isEmpty)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(
                        children: [
                          TextField(
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                setState(() {
                                  issearch = true;
                                  _runfilter(value);
                                });
                              } else {
                                setState(() {
                                  issearch = false;
                                  _runfilter(value);
                                });
                              }
                            },
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                                suffixIcon: issearch
                                    ? Icon(Icons.search)
                                    : Icon(Icons.abc),
                                hintText: "Search"),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Scrollbar(
                              // ignore: deprecated_member_use
                              showTrackOnHover: true,
                              interactive: true,
                              thickness: 5,
                              thumbVisibility: true,

                              child: ListView.builder(
                                itemCount: _searchcontacts.length,
                                // shrinkWrap: true,
                                // physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  String number =
                                      _searchcontacts[index].phones.isNotEmpty
                                          ? _searchcontacts[index]
                                              .phones
                                              .first
                                              .number
                                          : "---";
                                  //  Uint8List? image = contacts[index].photo;
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Editcontacts(
                                                      contactDetail:
                                                          _searchcontacts[
                                                              index])));

                                      //  getphoneData();

                                      //  print(contacts[index].displayName.split(' '));
                                    },
                                    onLongPress: () {
                                      setState(() {
                                        showAlertBox(_searchcontacts[index]);
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.only(bottom: 10),
                                      height: 110,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey, width: 2),
                                              left: BorderSide(
                                                  color: Colors.grey,
                                                  width: 0.2),
                                              right: BorderSide(
                                                  color: Colors.grey,
                                                  width: 0.2),
                                              top: BorderSide(
                                                  color: Colors.grey,
                                                  width: 0.1)),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              (_searchcontacts[index].photo !=
                                                      null)
                                                  ? CircleAvatar(
                                                      foregroundImage:
                                                          MemoryImage(
                                                              _searchcontacts[
                                                                      index]
                                                                  .photo!),
                                                    )
                                                  : CircleAvatar(
                                                      child:
                                                          Icon(Icons.person)),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    _searchcontacts[index]
                                                        .name
                                                        .first,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    number,
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                // launchUrlString('tel:${number}');
                                                // FlutterPhoneDirectCaller.callNumber(
                                                //     contacts[index].phones.toString());
                                                // launchUrl(
                                                //     Uri.parse('tel:${number}'));
                                                FlutterPhoneDirectCaller
                                                    .callNumber(
                                                        _searchcontacts[index]
                                                            .phones
                                                            .first
                                                            .number);

                                                // _makeCall(number);
                                              },
                                              icon: const Icon(Icons.call)),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      )),
      ),
    );
  }
}
