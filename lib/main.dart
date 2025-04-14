import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_10/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_10/Settings.dart';
import 'package:flutter_application_10/action/AddVehicle.dart';
import 'package:flutter_application_10/action/UpdateVehicle.dart';
import 'package:flutter_application_10/auth/login.dart';
import 'package:flutter_application_10/auth/signup.dart';
import 'package:flutter_application_10/firebase_obd_services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCe6FOXAiEirg4HYOHJdhN_V_e-xtcOHZA", 
      appId: "1:643393523819:android:a3857c74dc1cb1ae58e12e", 
      messagingSenderId: "643393523819", 
      projectId: "vtms-e3714"
    )
  );
  
  runApp(
    MultiProvider(  // <-- استبدل ChangeNotifierProvider بـ MultiProvider
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        Provider(create: (_) => FirestoreOBDService()),
      ],
      child: const MyApp(),
    ),
  );
}

class ThemeNotifier with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyApp extends StatefulWidget {  // <-- تغيير myapp إلى MyApp (PascalCase)
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeNotifier.themeMode,
          home: (FirebaseAuth.instance.currentUser != null && 
                FirebaseAuth.instance.currentUser!.emailVerified) 
              ? Homepage()  // <-- صححت هذا السطر (كان Login())
              : Login(),
          routes: {
            "signup": (context) => Signup(),
            "login": (context) => Login(),
            "homepage": (context) => Homepage(),
            "addVehicle": (context) => AddVehicle(),
            "settings": (context) => Settings(),
          },
        );
      },
    );
  }
}