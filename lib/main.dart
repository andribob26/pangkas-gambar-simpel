import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pangkas_gambar/screens/splass.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Pangkas Gambar",
      theme: ThemeData(primaryColor: Colors.indigo),
      home: Splass(),
    );
  }
}
