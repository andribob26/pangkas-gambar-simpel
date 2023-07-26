import 'package:get/get.dart';
import 'package:pangkas_gambar/screens/home.dart';

class SplassController extends GetxController {
  final isAnim = Rx<bool>(false);
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 1), () {
      isAnim.value = true;
    });
    Future.delayed(const Duration(seconds: 4), () {
      Get.offAll(const Home(),
          duration: const Duration(milliseconds: 500),
          transition: Transition.fade);
    });
    super.onInit();
  }
}
