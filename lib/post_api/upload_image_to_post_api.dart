import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? _image;
  final _picker = ImagePicker();
  pickImage() async {
    var pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Upload Image'),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  print('tapped 1 button');
                  await pickImage();
                },
                child: Container(
                  height: 50,
                  color: Colors.blue,
                  child: Center(
                    child: Text('Choose Image'),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  _image = null;
                  setState(() {});
                },
                child: Container(
                  height: 50,
                  color: Colors.blue,
                  child: Center(
                    child: Text('Remove Image'),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              _image == null
                  ? Text('No File Chosen')
                  : Image.file(_image!.absolute),
            ],
          ),
        ));
  }
}
