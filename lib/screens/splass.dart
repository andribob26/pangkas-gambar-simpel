import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pangkas_gambar/controllers/splass_controller.dart';

class Splass extends StatelessWidget {
  Splass({super.key});

  SplassController _splassC = Get.put(SplassController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
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
              Container(
                height: 320,
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Image(
                      height: 150.0,
                      image: const AssetImage("images/logo.png"),
                    ),
                    Obx(
                      () => AnimatedPositioned(
                        duration: Duration(milliseconds: 400),
                        bottom: !_splassC.isAnim.value ? 0.0 : 50.0,
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 200),
                          opacity: !_splassC.isAnim.value ? 0.0 : 1.0,
                          child: Text(
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
