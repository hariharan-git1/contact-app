import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class Editcontacts extends StatefulWidget {
  const Editcontacts({super.key, required this.contactDetail});
  final Contact contactDetail;

  @override
  State<Editcontacts> createState() => _EditcontactsState();
}

class _EditcontactsState extends State<Editcontacts> {
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.contactDetail.displayName;
    _numberController.text = widget.contactDetail.phones.isEmpty
        ? ''
        : widget.contactDetail.phones.first.number.toString();
  }

  Future _updateContact() async {
    widget.contactDetail.name.first = _nameController.text;

    widget.contactDetail.phones.first.number = _numberController.text;

    await widget.contactDetail.update();

    Navigator.pop(context, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height / 6,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(90),
                            bottomRight: Radius.circular(90)))),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 8),
                    child: (widget.contactDetail.photo != null)
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage:
                                MemoryImage(widget.contactDetail.photo!))
                        : CircleAvatar(
                            radius: 60,
                            child: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                          ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35, left: 20),
                  child: Text(
                    "EDIT CONTACT",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "NAME",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder()),
                controller: _nameController,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "PHONE NUMBER",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      backgroundColor: Colors.grey),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder()),
                controller: _numberController,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    //  onPressed: _updateContact,
                    onPressed: () {
                      _updateContact();
                    },
                    child: Text(
                      "SAVE",
                      style: TextStyle(color: Colors.white),
                    )))
          ],
        ),
      ),
    );
  }
}
