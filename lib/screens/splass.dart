import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pangkas_gambar/controllers/splass_controller.dart';

class Splass extends StatelessWidget {
  Splass({super.key});

  final SplassController _splassC = Get.put(SplassController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Colors.blue,
              Colors.indigo,
            ])),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 320,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    const Image(
                      height: 150.0,
                      image: AssetImage("images/logo.png"),
                    ),
                    Obx(
                      () => AnimatedPositioned(
                        duration: const Duration(milliseconds: 400),
                        bottom: !_splassC.isAnim.value ? 0.0 : 50.0,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: !_splassC.isAnim.value ? 0.0 : 1.0,
                          child: const Text(
                            "Pangkas Gambar Simpel",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30.0,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
