import 'dart:io';

import 'package:flutter/material.dart';
import 'package:practice_work/view/add_contact_page.dart';
import 'package:practice_work/view/detail_page.dart';
import 'package:practice_work/view/edit-page.dart';
import 'package:practice_work/view/splash_screen.dart';
import 'package:provider/provider.dart';

import 'Modal/contact_modal.dart';
import 'Provider/contact_diaryProvider.dart';
import 'global.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ContactProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactProvider>(
      builder: (context, themeNotifier, child) => MaterialApp(
        theme: Provider.of<ContactProvider>(context).isDark
            ? ThemeData(brightness: Brightness.dark)
            : ThemeData(
                brightness: Brightness.light,
                primaryColor: Colors.green,
                primarySwatch: Colors.green,
              ),
        darkTheme: ThemeData.dark(),
        themeMode: (Global.isDark == false) ? ThemeMode.light : ThemeMode.dark,
        initialRoute: "splash_screen",
        debugShowCheckedModeBanner: false,
        routes: {
          "edit_page": (context) => Edit_page(),
          "add_contact_page": (context) => add_contact_page(),
          "splash_screen": (context) => SplashScreen(),
          "detailed_page": (context) => Detailed_page(),
          "/": (context) => Scaffold(
                appBar: AppBar(
                  title:
                      Text(themeNotifier.isDark ? "Dark Mode" : "Light Mode"),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  actions: [
                    IconButton(
                      onPressed: () {
                        themeNotifier.isDark
                            ? themeNotifier.isDark = false
                            : themeNotifier.isDark = true;
                      },
                      icon: Icon(
                        themeNotifier.isDark
                            ? Icons.nightlight
                            : Icons.wb_sunny,
                      ),
                    ),
                    IconButton(
                      onPressed: () => themeNotifier.isGridView = false,
                      icon: Icon(Icons.more_vert),
                    ),
                  ],
                ),
                floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context).pushNamed('add_contact_page');
                  },
                ),
                body: Container(
                  alignment: Alignment.center,
                  child: (Global.allContacts.isEmpty)
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.account_box_rounded,
                              size: 150,
                            ),
                            Text(
                              "You have no  contacts yet",
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                            MaterialButton(
                                child: Text("Intro Screen"),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed("intro_screen");
                                }),
                            MaterialButton(
                                child: Text("Stepper"),
                                onPressed: () {
                                  Navigator.of(context).pushNamed("stepper");
                                }),
                          ],
                        )
                      : (themeNotifier.isGridView = false)
                          ? ListView.builder(
                              itemCount: Global.allContacts.length,
                              itemBuilder: (context, i) {
                                return Card(
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                        "detailed_page",
                                        arguments: Global.allContacts[i],
                                      );
                                    },
                                    leading: CircleAvatar(
                                      radius: 30,
                                      foregroundImage: (Global
                                                  .allContacts[i].img !=
                                              null)
                                          ? FileImage(
                                              Global.allContacts[i].img as File)
                                          : null,
                                    ),
                                    title: Text(
                                        "${Global.allContacts[i].firstName} ${Global.allContacts[i].lastName}"),
                                    subtitle: Text(
                                        "+91 ${Global.allContacts[i].Phone}"),
                                    trailing: Consumer(
                                      builder: (context, provider, child) =>
                                          IconButton(
                                        icon: Icon(
                                          Icons.phone,
                                          color: Colors.green,
                                        ),
                                        onPressed: () {
                                          Contact c1 = Contact(
                                              firstName: Global.firstName,
                                              lastName: Global.lastName,
                                              Phone: Global.Phone,
                                              Email: Global.Email,
                                              img: Global.img);

                                          Navigator.of(context).pushNamed(
                                            "detailed_page",
                                            arguments: c1,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 8,
                                crossAxisSpacing: 8,
                                crossAxisCount: 2,
                              ),
                              itemCount: Global.allContacts.length,
                              addRepaintBoundaries: true,
                              itemBuilder: (context, i) {
                                return Consumer(
                                  builder: (context, provider, child) => Card(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          "detailed_page",
                                          arguments: Global.allContacts[i],
                                        );
                                      },
                                      child: Container(
                                        height: 300,
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            Center(
                                              child: CircleAvatar(
                                                radius: 30,
                                                foregroundImage: (Global
                                                            .allContacts[i]
                                                            .img !=
                                                        null)
                                                    ? FileImage(Global
                                                        .allContacts[i]
                                                        .img as File)
                                                    : null,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "${Global.allContacts[i].firstName} ${Global.allContacts[i].lastName}",
                                              style: TextStyle(),
                                            ),
                                            Text(
                                              "+91 ${Global.allContacts[i].Phone} ",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                ),
              ),
        },
      ),
    );
  }
}
