import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDbb_WB1GWse7bPlfRo7qHIt-8QLjVPlKQ",
          authDomain: "atd-app-be1a0.firebaseapp.com",
          projectId: "atd-app-be1a0",
          storageBucket: "atd-app-be1a0.appspot.com",
          messagingSenderId: "143988568645",
          appId: "1:143988568645:web:001f2f2e80c05b1bb0a92c"));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Attendance App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
