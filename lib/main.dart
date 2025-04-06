import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_10/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_10/Settings.dart';
import 'package:flutter_application_10/action/AddVehicle.dart';
import 'package:flutter_application_10/action/UpdateVehicle.dart';
import 'package:flutter_application_10/auth/login.dart';
import 'package:flutter_application_10/auth/signup.dart';


void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
 // await Firebase.initializeApp();
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCe6FOXAiEirg4HYOHJdhN_V_e-xtcOHZA", 
      appId: "1:643393523819:android:a3857c74dc1cb1ae58e12e", 
      messagingSenderId: "643393523819", 
      projectId: "vtms-e3714"
      )
  );
  runApp(const myapp());
}

class myapp extends StatefulWidget {
  const myapp({super.key});

  @override
  State<myapp> createState() => _myappStates();
}

class _myappStates extends State<myapp> {

  @override
  void initState() {

  FirebaseAuth.instance
  .authStateChanges()
  .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
    
        super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:(FirebaseAuth.instance.currentUser != null && FirebaseAuth.instance.currentUser!.emailVerified) ? Login() : Homepage(),

      routes: {
        "signup":(context)=> Signup(),
        "login":(context)=> Login(),
        "homepage":(context)=> Homepage(),
        "addVehicle":(context)=> AddVehicle(),
        "settings":(context)=> Settings(),
      },
    );
  }
}
