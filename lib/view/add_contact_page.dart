import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Modal/contact_modal.dart';
import '../Provider/contact_diaryProvider.dart';
import '../global.dart';

class add_contact_page extends StatelessWidget {
  add_contact_page({Key? key}) : super(key: key);

  @override
  void initState() {
    // TODO: implement initState

    firstnameController.text =
        (Global.firstName != null) ? Global.firstName as String : "";
    lastnameController.text =
        (Global.lastName != null) ? Global.lastName as String : "";
    EmailController.text = (Global.Email != null) ? Global.Email as String : "";
    PhoneController.text = (Global.Phone != null) ? Global.Phone as String : "";
  }

  final GlobalKey<FormState> AddcontactFormKey = GlobalKey<FormState>();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController PhoneController = TextEditingController();
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();
  final TextEditingController address3Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ImagePicker picker = ImagePicker();
    return Consumer<ContactProvider>(
      builder: (context, provider, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            "Add",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
          leading: Consumer(
            builder: (context, provider, child) => IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                if (AddcontactFormKey.currentState!.validate()) {
                  AddcontactFormKey.currentState!.save();

                  Contact c1 = Contact(
                      firstName: Global.firstName,
                      lastName: Global.lastName,
                      Phone: Global.Phone,
                      Email: Global.Email,
                      img: Global.img);

                  Global.allContacts.add(c1);
                  firstnameController.clear();
                  lastnameController.clear();
                  PhoneController.clear();
                  EmailController.clear();

                  Global.firstName = null;
                  Global.lastName = null;
                  Global.Phone = null;
                  Global.Email = null;
                  Global.img = null;

                  Navigator.of(context).pop();
                }
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundColor: Colors.grey,
                    foregroundImage: (Global.img != null)
                        ? FileImage(Global.img as File)
                        : null,
                    child: const Text(
                      "Add",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Consumer(
                    builder: (context, value, child) => FloatingActionButton(
                      onPressed: () async {
                        XFile? xFile =
                            await picker.pickImage(source: ImageSource.camera);

                        String imgPath = xFile!.path;

                        Global.img = File(imgPath);
                      },
                      mini: true,
                      child: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Form(
                  key: AddcontactFormKey,
                  child: SingleChildScrollView(
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
                          controller: firstnameController,
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
                          controller: lastnameController,
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
                              )),
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
                          controller: PhoneController,
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
                              )),
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
                          controller: EmailController,
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
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget nextButton(ContactProvider provider) {
  return ElevatedButton(
    onPressed: () => provider.updateNextButton(),
    child: const Text(
      "Next",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget previousButton(ContactProvider provider) {
  return ElevatedButton(
    onPressed: () => provider.updatePreviousButton(),
    child: const Text(
      "Previous",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget header(ContactProvider provider) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.amber,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "${provider.header()}",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
      ],
    ),
  );
}
