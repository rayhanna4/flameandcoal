import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flameandcoal/Constant%20Folder/Constant%20File.dart';
import 'package:flameandcoal/Splash%20Screen/Main%20Splash%20Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseDatabase database;
  database = FirebaseDatabase.instance;
  database.setPersistenceEnabled(true);
  database.setPersistenceCacheSizeBytes(10000000);
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flame&Coal',
      theme: ThemeData(
        primarySwatch: primary_col,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: slashPageMain(),
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFFFFBD2F),
      statusBarIconBrightness: Brightness.light));
}
