import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_10/ProfilePage.dart';
import 'package:flutter_application_10/Report.dart';
import 'package:flutter_application_10/Settings.dart';
import 'package:flutter_application_10/vehicleCard.dart';
import 'package:flutter_application_10/AboutUs.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int selectedIndex = 0;

  List<Widget> pagelist = [
    const Text("welcome to home page"),
    const Text("welcome to tracking page"),
    const Text("welcome to maintain page"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedFontSize: 15,
        selectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedFontSize: 15,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on_sharp), label: "Track"),
          BottomNavigationBarItem(
              icon: Icon(Icons.airport_shuttle_outlined), label: "maintain"),
        ],
      ),
      appBar: AppBar(
        title: const Text(("home page"),
            style: TextStyle(
              fontSize: 30,
            )),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: ListView(
        children: const [
          Vehiclecard(name: "camry", typeVehicle: "car", year: "2002"),
          Vehiclecard(name: "comaro", typeVehicle: "car", year: "2021"),
          Vehiclecard(name: "land crusior", typeVehicle: "car", year: "2016"),
          Vehiclecard(name: "accent", typeVehicle: "car", year: "2025"),
          Vehiclecard(name: "k8", typeVehicle: "car", year: "2024"),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.only(top: 80),
          children: [
            ListTile(
              leading: const Icon(
                Icons.person,
                size: 30,
              ),
              title: const Text(
                "profile",
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.folder_copy_rounded,
                size: 30,
              ),
              title: const Text(
                "report",
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ReportPage()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.settings,
                size: 30,
              ),
              title: const Text(
                "settings",
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Settings()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.info_outline_rounded,
                size: 30,
              ),
              title: const Text(
                "about us",
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AboutUs()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout_sharp,
                size: 30,
              ),
              title: const Text(
                "log out",
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Warning"),
                      content: const Text("are you sure to log out?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("cancel")),
                        TextButton(
                            onPressed: () async {
                              GoogleSignIn googleSignIn = GoogleSignIn();
                              googleSignIn.disconnect();
                              await FirebaseAuth.instance.signOut();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  "login", (route) => false);
                            },
                            child: const Text("yes")),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
