import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home/home_page.dart';

void main() {
  runApp(const MyApp());

  if (Platform.isAndroid) {
    const SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "MusicApi",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
