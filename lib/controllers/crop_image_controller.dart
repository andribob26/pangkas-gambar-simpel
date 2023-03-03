import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';

import '../screens/crop_image.dart';

class CropImageController extends GetxController {
  final image = Rx<Uint8List?>(null);
  final croppedImage = Rx<Uint8List?>(null);
  final isCropping = Rx<bool>(false);
  final isLoading = Rx<bool>(false);

  Future<void> uploadImage() async {
    final XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image.value = await pickedFile.readAsBytes();
      Get.to(() => CropImage(), transition: Transition.downToUp);
    } else {
      log("kosong");
    }
  }

  Future<void> saveImage(Uint8List bytes) async {
    var result = await ImageGallerySaver.saveImage(bytes,
        quality: 60, name: "pangkas_gambar_simple_${_timestamp()}.jpg");
    print(result);
    if (result["isSuccess"] == true) {
      image.value = bytes;
      croppedImage.value = null;
      Get.snackbar(
        "Success",
        "Berhasil menyimpan gambar",
        colorText: Colors.white,
        backgroundColor: Colors.black.withOpacity(0.8),
      );
      isLoading.value = false;
    } else {
      print(result["errorMessage"]);
      Get.snackbar(
        "Error",
        "${result["errorMessage"]}",
        colorText: Colors.white,
        backgroundColor: Colors.black.withOpacity(0.8),
      );
      isLoading.value = false;
    }
  }

  String _timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
}
