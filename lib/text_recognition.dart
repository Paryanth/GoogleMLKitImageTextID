
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';


class TextRecognition extends StatefulWidget {
  @override
  _TextRecognitionState createState() => _TextRecognitionState();
}

class _TextRecognitionState extends State<TextRecognition> {
  File? _image;
  String _recognizedText = '';
  bool _loading = false;

  final ImagePicker _picker = ImagePicker();
  final TextRecognizer _textRecognizer = GoogleMlKit.vision.textRecognizer();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _loading = true;
      });

      _recognizeText(File(pickedFile.path));
    }
  }

  Future<void> _recognizeText(File image) async {
    final inputImage = InputImage.fromFile(image);
    final recognizedText = await _textRecognizer.processImage(inputImage);

    setState(() {
      _recognizedText = recognizedText.text;
      _loading = false;
    });
  }

  @override
  void dispose() {
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Recognition with ML Kit'),
      ),
      body: Column(
        children: [
          _image == null
              ? Center(child: Text('No image selected.'))
              : Image.file(_image!),
          SizedBox(height: 16.0),
          _loading
              ? CircularProgressIndicator()
              : Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(_recognizedText),
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: _pickImage,
            tooltip: 'Pick Image',
            child: Icon(Icons.image),
          ),
        ],
      ),
    );
  }
}
