import 'dart:io';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/crop_image_controller.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final CropImageController _cropImageC = Get.put(CropImageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Colors.blue,
                Colors.indigo,
              ])),
        ),
        title: const Text("Pangkas Gambar Simpel"),
        elevation: 2.0,
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Colors.blue,
                Colors.indigo,
              ])),
          child: Material(
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            elevation: 2.0,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              onTap: () {
                _cropImageC.uploadImage();
              },
              child: Container(
                height: 100.0,
                width: 100.0,
                child: const Icon(
                  Icons.image,
                  size: 60.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
