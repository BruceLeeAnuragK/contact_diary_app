import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Modal/contact_modal.dart';
import '../global.dart';

class Detailed_page extends StatefulWidget {
  @override
  State<Detailed_page> createState() => _Detailed_pageState();
}

class _Detailed_pageState extends State<Detailed_page> {
  final GlobalKey<FormState> AddcontactFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> DetailpsgecFormKey = GlobalKey<FormState>();
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
    Contact data = ModalRoute.of(context)!.settings.arguments as Contact;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Details",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (DetailpsgecFormKey.currentState!.validate()) {
              DetailpsgecFormKey.currentState!.save();
            }
            setState(() {
              Navigator.of(context)
                  .popAndPushNamed("/", arguments: data)
                  .then((value) => setState(() {}));
            });
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  CircleAvatar(
                    radius: 80,
                    foregroundImage:
                        data.img != null ? FileImage(data.img!) : null,
                    child: Text(
                      data.firstName![0].toUpperCase(),
                      style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        firstnameController.clear();
                        lastnameController.clear();
                        PhoneController.clear();
                        EmailController.clear();

                        Global.firstName = null;
                        Global.lastName = null;
                        Global.Phone = null;
                        Global.Email = null;
                        Global.img = null;
                        Navigator.of(context)
                            .pushNamed("edit_page",
                                arguments: Global.allContacts.indexOf(data))
                            .then(
                              (value) => setState(() {}),
                            );
                      });
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed('/',
                              arguments: Global.allContacts.remove(data))
                          .then((value) => setState(() {}));
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SelectableText("+91 ${data.Phone} ",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ), contextMenuBuilder: (context, editableTextState) {
                return Text(
                  "+91  ${data.Phone}",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                );
              }),
              SelectableText("${data.firstName} ${data.lastName} ",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ), contextMenuBuilder: (context, editableTextState) {
                return Text(
                  "${data.firstName}  ${data.lastName}",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                );
              }),
              const Divider(
                thickness: 3,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    onPressed: () async {
                      Uri phone = Uri(
                        scheme: 'tel',
                        path: data.Phone,
                      );
                      await launchUrl(phone);
                    },
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.phone),
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      Uri email = Uri(
                          scheme: 'mailto', path: data.Email, query: "Hello️");
                      await launchUrl(email);
                    },
                    backgroundColor: Colors.red,
                    child: const Icon(Icons.email),
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      Uri sms = Uri(
                          scheme: 'sms',
                          path: data.Phone,
                          query: "body = Say Hi ❤️");
                      await launchUrl(sms);
                    },
                    backgroundColor: Colors.blue,
                    child: const Icon(Icons.sms),
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      await Share.share(
                          " Name : ${data.firstName} ${data.lastName}\nContact : ${data.Phone}");
                    },
                    backgroundColor: Colors.orangeAccent,
                    child: const Icon(Icons.share),
                  ),
                  const Divider(
                    thickness: 3,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
