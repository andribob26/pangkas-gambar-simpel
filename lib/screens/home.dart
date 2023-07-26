import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../controllers/crop_image_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CropImageController _cropImageC = Get.put(CropImageController());

  @override
  void initState() {
    if (_cropImageC.bannerAd != null) {
      _cropImageC.isAdsBannerLoad = false;
      _cropImageC.bannerAd!.dispose();
    }
    _cropImageC.initBannerAds();
    super.initState();
  }

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
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
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
              onTap: () async {
                _cropImageC.showInterstisialAds(_cropImageC.uploadImage);
              },
              child: const SizedBox(
                height: 100.0,
                width: 100.0,
                child: Icon(
                  Icons.image,
                  size: 60.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(() => _cropImageC.isAdsBannerLoad
          ? SizedBox(
              height: _cropImageC.bannerAd!.size.height.toDouble(),
              width: _cropImageC.bannerAd!.size.width.toDouble(),
              child: AdWidget(ad: _cropImageC.bannerAd!),
            )
          : const SizedBox()),
    );
  }
}
