import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pangkas_gambar/screens/crop_image.dart';

class CropImageController extends GetxController {
  final String _adUnitIdBanner = "";
  final String _adUnitIdInterstisial = "";
  int _numInterstitialLoadAttempts = 0;
  final int _maxFailedLoadAttempts = 3;
  final _bannerAd = Rx<BannerAd?>(null);
  final _interstisialAd = Rx<InterstitialAd?>(null);
  final _isAdsBannerLoad = Rx<bool>(false);
  final _isAdsInterstisialLoad = Rx<bool>(false);
  final image = Rx<Uint8List?>(null);
  final croppedImage = Rx<Uint8List?>(null);
  final isCropping = Rx<bool>(false);
  final isLoading = Rx<bool>(false);

  bool get isAdsBannerLoad {
    return _isAdsBannerLoad.value;
  }

  set isAdsBannerLoad(val) {
    _isAdsBannerLoad.value = val;
  }

  bool get isAdsInterstisialLoad {
    return _isAdsInterstisialLoad.value;
  }

  BannerAd? get bannerAd {
    return _bannerAd.value;
  }

  InterstitialAd? get interstisialAd {
    return _interstisialAd.value;
  }

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
      Get.snackbar(
        "Error",
        "${result["errorMessage"]}",
        colorText: Colors.white,
        backgroundColor: Colors.black.withOpacity(0.8),
      );
      isLoading.value = false;
    }
  }

  void initInterstisialAds() {
    InterstitialAd.load(
      adUnitId: _adUnitIdInterstisial,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstisialAd.value = ad;
          _numInterstitialLoadAttempts = 0;
          _interstisialAd.value!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (error) {
          _numInterstitialLoadAttempts += 1;
          _interstisialAd.value = null;
          if (_numInterstitialLoadAttempts < _maxFailedLoadAttempts) {
            initInterstisialAds();
          }
        },
      ),
    );
  }

  void showInterstisialAds(Function fn) {
    if (_interstisialAd.value == null) {
      // ignore: avoid_print
      print('Warning: mencoba menampilkan iklan sebelum dimuat.');
      return;
    }

    _interstisialAd.value!.fullScreenContentCallback =
        FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {},
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        initInterstisialAds();
        fn();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        initInterstisialAds();
      },
    );

    _interstisialAd.value!.show();
    _interstisialAd.value = null;
  }

  void initBannerAds() {
    _bannerAd.value = BannerAd(
      size: AdSize.banner,
      adUnitId: _adUnitIdBanner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _isAdsBannerLoad.value = true;
        },
        onAdFailedToLoad: (ad, error) {
          _isAdsBannerLoad.value = false;
          ad.dispose();
          // ignore: avoid_print
          print("$error errorrrrr");
        },
      ),
      request: const AdRequest(),
    );

    _bannerAd.value!.load();
  }

  String _timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  @override
  void onInit() {
    initInterstisialAds();
    super.onInit();
  }
}
