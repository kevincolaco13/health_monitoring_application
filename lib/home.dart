import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'medical_report.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? imageFile;
  Future<Uint8List>? image;

  Future pickImage(ImageSource source) async {
    try {
      final imageFile = await ImagePicker().pickImage(source: source);
      if (imageFile == null) return;
      final imageTemp = File(imageFile.path);
      image = imageFile.readAsBytes();
      setState(() => this.imageFile = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick imageFile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              (imageFile?.path != null)
                  ? Image.file(
                      imageFile!,
                      width: 400,
                      height: 300,
                    )
                  : const Center(
                      child: Text(
                      'Choose a medical report ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                  color: const Color.fromARGB(255, 143, 123, 107),
                  child: const Text("Pick Image from Gallery",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    pickImage(ImageSource.gallery);
                    print(imageFile);
                  }),
              MaterialButton(
                  color: const Color.fromARGB(255, 143, 123, 107),
                  child: const Text("Pick Image from Camera",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    pickImage(ImageSource.camera);
                  }),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                  color: const Color.fromARGB(255, 67, 86, 102),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Dialog(
                          child: SizedBox(
                            height: 100.0,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  CircularProgressIndicator(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Loading Data...')
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );

                    // Delay navigation by 4 seconds
                    Future.delayed(const Duration(seconds: 4), () {
                      Navigator.pop(context);
                      // Navigate to new page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MedicalReport(
                                  title: 'Medical Report',
                                )),
                      );
                    });
                  },
                  child: const Text("Analyze",
                      style: TextStyle(
                          color: Colors.white70, fontWeight: FontWeight.bold))),
            ],
          ),
        ));
  }
}
