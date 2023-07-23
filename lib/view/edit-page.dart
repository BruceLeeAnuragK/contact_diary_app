import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../global.dart';

class Edit_page extends StatefulWidget {
  @override
  State<Edit_page> createState() => _Edit_pageState();
}

class _Edit_pageState extends State<Edit_page> {
  final GlobalKey<FormState> AddcontactFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> EditFormKey = GlobalKey<FormState>();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController PhoneController = TextEditingController();
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();
  final TextEditingController address3Controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstnameController.text =
        (Global.firstName != null) ? Global.firstName as String : "";
    lastnameController.text =
        (Global.lastName != null) ? Global.lastName as String : "";
    EmailController.text = (Global.Email != null) ? Global.Email as String : "";
    PhoneController.text = (Global.Phone != null) ? Global.Phone as String : "";
  }

  ImagePicker picker = ImagePicker();
  int initialIndex = 0;

  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "Edit Page",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.check),
          onPressed: () {
            if (EditFormKey.currentState!.validate()) {
              setState(() {
                EditFormKey.currentState!.save();
                firstnameController.clear();
                lastnameController.clear();
                PhoneController.clear();
                EmailController.clear();
                Global.allContacts[index].firstName;
                Global.allContacts[index].lastName;
                Global.allContacts[index].Phone;
                Global.allContacts[index].Email;
                Global.allContacts[index].img;
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pushNamed("detailed_page",
                        arguments: Global.allContacts[index])
                    .then(
                      (value) => setState(() {}),
                    );
              });
            }
          },
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey,
                  foregroundImage: (Global.allContacts[index].img != null)
                      ? FileImage(Global.allContacts[index].img as File)
                      : null,
                  child: Text(
                    "${Global.allContacts[index].firstName}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () async {
                    XFile? xFile =
                        await picker.pickImage(source: ImageSource.camera);

                    String imgPath = xFile!.path;

                    setState(() {
                      Global.allContacts[index].img = File(imgPath);
                    });
                  },
                  mini: true,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Form(
                key: EditFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "First Name",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    TextFormField(
                      initialValue: Global.allContacts[index].firstName,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter First Name ";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        Global.firstName = val;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter your First Name...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Last Name",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    TextFormField(
                      initialValue: Global.allContacts[index].lastName,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Last Name ";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        Global.lastName = val;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter your Last Name...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Phone Number",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    TextFormField(
                      initialValue: Global.allContacts[index].Phone,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Phone Number ";
                        } else if (val.length != 10) {
                          return "Enter 10 digit Number";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        Global.Phone = val;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter your phone number...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Email Address",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    TextFormField(
                      initialValue: Global.allContacts[index].Email,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Your email Address...";
                        }
                        return null;
                      },
                      onSaved: (val) {
                        Global.Email = val;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter your Email here...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
