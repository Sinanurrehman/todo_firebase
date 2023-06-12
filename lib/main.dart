import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart ';
import 'package:todo_firebase/auth/authscreen.dart';
import 'package:todo_firebase/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        // ignore: non_constant_identifier_names
        builder: (context, userSnapshot) {
          if (userSnapshot.hasData) {
            return Home();
          } else {
            return AuthScreen();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //brightness: Brightness.dark,
        primaryColor: Color.fromARGB(255, 31, 161, 155),
      ),
    );
  }
}
