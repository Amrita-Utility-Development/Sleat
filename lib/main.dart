import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Camera App',
      debugShowCheckedModeBanner: false,
      home: CameraScreen(),
    );
  }
}

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File? _imageFile;
  String _imageSize = '';

  Future<void> _captureImage() async {
    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      _imageFile = File(imageFile!.path);
      _imageSize = 'Image size: ${_imageFile?.lengthSync()} bytes';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_imageFile != null) ...[
              Image.file(_imageFile!),
              const SizedBox(height: 16),
              Text(
                _imageSize,
                style: const TextStyle(fontSize: 16),
              ),
            ] else const Text('No image selected'),
            const SizedBox(height: 16),
            FloatingActionButton(
              onPressed: _captureImage,
              child: const Icon(Icons.camera),
            ),
          ],
        ),
      ),
    );
  }
}