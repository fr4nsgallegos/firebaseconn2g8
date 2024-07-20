import 'package:firebase_core/firebase_core.dart';
import 'package:firebaseconn2g8/firebase_options.dart';
import 'package:firebaseconn2g8/pages/create_account_page.dart';
import 'package:firebaseconn2g8/pages/home_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      // home: HomePage(),
      home: CreateAccountPage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
