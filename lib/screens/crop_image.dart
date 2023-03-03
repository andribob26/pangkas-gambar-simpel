import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pangkas_gambar/controllers/crop_image_controller.dart';
import 'package:pangkas_gambar/screens/home.dart';

class CropImage extends StatelessWidget {
  CropImage({super.key});
  final CropImageController _cropImageC = Get.find();
  final _cropC = CropController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.offAll(() => Home());
        _cropImageC.image.value = null;
        _cropImageC.croppedImage.value = null;
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          elevation: 2.0,
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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.offAll(() => Home());
              _cropImageC.image.value = null;
              _cropImageC.croppedImage.value = null;
            },
          ),
        ),
        body: Obx(
          () => AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _cropImageC.croppedImage.value == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: _cropImageC.image.value != null
                              ? Crop(
                                  progressIndicator:
                                      const CircularProgressIndicator(
                                    color: Colors.indigo,
                                  ),
                                  baseColor: Colors.white,
                                  onStatusChanged: (value) {
                                    if (value.name == "cropping") {
                                      _cropImageC.isCropping.value = true;
                                    } else {
                                      _cropImageC.isCropping.value = false;
                                    }
                                  },
                                  image: _cropImageC.image.value!,
                                  controller: _cropC,
                                  onCropped: (image) {
                                    // do something with image data
                                    _cropImageC.croppedImage.value = image;
                                    // _cropImageC.isVisible.value = false;
                                  },
                                )
                              : const SizedBox(),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                          bottom: 10.0,
                        ),
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkResponse(
                              onTap: () {
                                _cropC
                                  ..withCircleUi = false
                                  ..aspectRatio = 16 / 9;
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: const [
                                    Icon(Icons.crop_16_9),
                                    Text("16:9"),
                                  ],
                                ),
                              ),
                            ),
                            InkResponse(
                              onTap: () {
                                _cropC
                                  ..withCircleUi = false
                                  ..aspectRatio = 3 / 2;
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: const [
                                    Icon(Icons.crop_5_4),
                                    Text("5:4"),
                                  ],
                                ),
                              ),
                            ),
                            InkResponse(
                              onTap: () {
                                _cropC
                                  ..withCircleUi = false
                                  ..aspectRatio = 1;
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: const [
                                    Icon(Icons.crop_portrait),
                                    Text("1:1"),
                                  ],
                                ),
                              ),
                            ),
                            InkResponse(
                              onTap: () {
                                _cropC
                                  ..withCircleUi = false
                                  ..aspectRatio = 2 / 3;
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: const [
                                    RotatedBox(
                                        quarterTurns: 180,
                                        child: Icon(Icons.crop_5_4)),
                                    Text("4:5"),
                                  ],
                                ),
                              ),
                            ),
                            InkResponse(
                              onTap: () {
                                _cropC..withCircleUi = false;
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: const [
                                    Icon(Icons.crop_free),
                                    Text("Free"),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Material(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50.0)),
                          child: InkWell(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50.0)),
                            onTap: () {
                              if (_cropImageC.isCropping.value != true) {
                                _cropC.crop();
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(50.0),
                                ),
                                border: Border.all(
                                  width: 3.0,
                                  color: Colors.indigo,
                                  strokeAlign: StrokeAlign.outside,
                                ),
                              ),
                              height: 45.0,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: _cropImageC.isCropping.value != true
                                    ? const Text(
                                        "Pangkas",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      )
                                    : const SizedBox(
                                        height: 25.0,
                                        width: 25.0,
                                        child: CircularProgressIndicator(
                                          color: Colors.indigo,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                : Column(
                    key: UniqueKey(),
                    children: [
                      _cropImageC.croppedImage.value == null
                          ? const SizedBox.shrink()
                          : Expanded(
                              child: Image.memory(
                                  _cropImageC.croppedImage.value!)),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Material(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50.0)),
                                child: InkWell(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50.0)),
                                  onTap: () {
                                    _cropImageC.croppedImage.value = null;
                                  },
                                  child: Container(
                                    height: 45.0,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(50.0),
                                      ),
                                      border: Border.all(
                                        width: 3.0,
                                        color: Colors.indigo,
                                        strokeAlign: StrokeAlign.outside,
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Kembali",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Material(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50.0)),
                                child: InkWell(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(50.0)),
                                  onTap: () {
                                    _cropImageC.isLoading.value = true;
                                    if (_cropImageC.croppedImage.value !=
                                        null) {
                                      _cropImageC.saveImage(
                                          _cropImageC.croppedImage.value!);
                                    }
                                  },
                                  child: Container(
                                    height: 45.0,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(50.0),
                                      ),
                                      border: Border.all(
                                        width: 3.0,
                                        color: Colors.indigo,
                                        strokeAlign: StrokeAlign.outside,
                                      ),
                                    ),
                                    child: Center(
                                      child: !_cropImageC.isLoading.value
                                          ? const Text(
                                              "Simpan",
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          : const SizedBox(
                                              height: 25.0,
                                              width: 25.0,
                                              child: CircularProgressIndicator(
                                                color: Colors.indigo,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}


// Visibility(
//             visible: _cropImageC.croppedImage.value == null,
//             replacement: Column(
//               children: [
//                 _cropImageC.croppedImage.value == null
//                     ? const SizedBox.shrink()
//                     : Expanded(
//                         child: Image.memory(_cropImageC.croppedImage.value!)),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Material(
//                           borderRadius:
//                               const BorderRadius.all(Radius.circular(50.0)),
//                           child: InkWell(
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(50.0)),
//                             onTap: () {
//                               _cropImageC.croppedImage.value = null;
//                             },
//                             child: Container(
//                               height: 60.0,
//                               decoration: BoxDecoration(
//                                 borderRadius: const BorderRadius.all(
//                                   Radius.circular(50.0),
//                                 ),
//                                 border: Border.all(
//                                   width: 3.0,
//                                   color: Colors.indigo,
//                                   strokeAlign: StrokeAlign.outside,
//                                 ),
//                               ),
//                               child: const Center(
//                                 child: Text(
//                                   "Kembali",
//                                   style: TextStyle(
//                                     fontSize: 20.0,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: Material(
//                           borderRadius:
//                               const BorderRadius.all(Radius.circular(50.0)),
//                           child: InkWell(
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(50.0)),
//                             onTap: () {
//                               // _cropC.crop();
//                             },
//                             child: Container(
//                               height: 60.0,
//                               decoration: BoxDecoration(
//                                 borderRadius: const BorderRadius.all(
//                                   Radius.circular(50.0),
//                                 ),
//                                 border: Border.all(
//                                   width: 3.0,
//                                   color: Colors.indigo,
//                                   strokeAlign: StrokeAlign.outside,
//                                 ),
//                               ),
//                               child: const Center(
//                                 child: Text(
//                                   "Simpan",
//                                   style: TextStyle(
//                                     fontSize: 20.0,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 )
//               ],
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Expanded(
//                   child: Container(
//                     width: MediaQuery.of(context).size.width,
//                     child: _cropImageC.image.value != null
//                         ? Crop(
//                             progressIndicator: const CircularProgressIndicator(
//                               color: Colors.indigo,
//                             ),
//                             baseColor: Colors.white,
//                             onStatusChanged: (value) {
//                               if (value.name == "cropping") {
//                                 _cropImageC.isCropping.value = true;
//                               } else {
//                                 _cropImageC.isCropping.value = false;
//                               }
//                             },
//                             image: _cropImageC.image.value!,
//                             controller: _cropC,
//                             onCropped: (image) {
//                               // do something with image data
//                               _cropImageC.croppedImage.value = image;
//                               // _cropImageC.isVisible.value = false;
//                             },
//                           )
//                         : const SizedBox(),
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.only(
//                     top: 10.0,
//                     bottom: 10.0,
//                   ),
//                   color: Colors.transparent,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       InkResponse(
//                         onTap: () {
//                           _cropC
//                             ..withCircleUi = false
//                             ..aspectRatio = 16 / 9;
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: Column(
//                             children: const [
//                               Icon(Icons.crop_16_9),
//                               Text("16:9"),
//                             ],
//                           ),
//                         ),
//                       ),
//                       InkResponse(
//                         onTap: () {
//                           _cropC
//                             ..withCircleUi = false
//                             ..aspectRatio = 3 / 2;
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: Column(
//                             children: const [
//                               Icon(Icons.crop_5_4),
//                               Text("5:4"),
//                             ],
//                           ),
//                         ),
//                       ),
//                       InkResponse(
//                         onTap: () {
//                           _cropC
//                             ..withCircleUi = false
//                             ..aspectRatio = 1;
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: Column(
//                             children: const [
//                               Icon(Icons.crop_portrait),
//                               Text("1:1"),
//                             ],
//                           ),
//                         ),
//                       ),
//                       InkResponse(
//                         onTap: () {
//                           _cropC
//                             ..withCircleUi = false
//                             ..aspectRatio = 2 / 3;
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: Column(
//                             children: const [
//                               RotatedBox(
//                                   quarterTurns: 180,
//                                   child: Icon(Icons.crop_5_4)),
//                               Text("4:5"),
//                             ],
//                           ),
//                         ),
//                       ),
//                       InkResponse(
//                         onTap: () {
//                           _cropC..withCircleUi = false;
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(12.0),
//                           child: Column(
//                             children: const [
//                               Icon(Icons.crop_free),
//                               Text("Free"),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Material(
//                     borderRadius: const BorderRadius.all(Radius.circular(50.0)),
//                     child: InkWell(
//                       borderRadius:
//                           const BorderRadius.all(Radius.circular(50.0)),
//                       onTap: () {
//                         if (_cropImageC.isCropping.value != true) {
//                           _cropC.crop();
//                         }
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: const BorderRadius.all(
//                             Radius.circular(50.0),
//                           ),
//                           border: Border.all(
//                             width: 3.0,
//                             color: Colors.indigo,
//                             strokeAlign: StrokeAlign.outside,
//                           ),
//                         ),
//                         height: 60.0,
//                         width: MediaQuery.of(context).size.width,
//                         child: Center(
//                           child: _cropImageC.isCropping.value != true
//                               ? const Text(
//                                   "Pangkas",
//                                   style: TextStyle(
//                                     fontSize: 20.0,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 )
//                               : const SizedBox(
//                                   height: 25.0,
//                                   width: 25.0,
//                                   child: CircularProgressIndicator(
//                                     color: Colors.indigo,
//                                   ),
//                                 ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           )