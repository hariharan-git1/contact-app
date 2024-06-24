import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class Newcontacts extends StatefulWidget {
  const Newcontacts({super.key});

  @override
  State<Newcontacts> createState() => _NewcontactsState();
}

class _NewcontactsState extends State<Newcontacts> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          "NEW CONTACTS",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.abc),
                    label: Text("FIRST NAME", style: TextStyle(fontSize: 12)),
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.abc),
                      label: Text(
                        "LAST NAME",
                        style: TextStyle(fontSize: 12),
                      ),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder())),
              const SizedBox(
                height: 30,
              ),
              TextField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.call),
                      label:
                          Text("PHONE NUMBER", style: TextStyle(fontSize: 12)),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder())),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () async {
                    var newContact = Contact(
                        name: Name(
                            first: _firstNameController.text,
                            last: _lastNameController.text),
                        phones: [Phone(_phoneNumberController.text)]);

                    await FlutterContacts.insertContact(newContact);
                    Navigator.pop(context);
                  },
                  child: Text(
                    "SAVE",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
