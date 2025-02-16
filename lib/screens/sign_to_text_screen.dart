import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SignToTextScreen extends StatefulWidget {
  const SignToTextScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignToTextScreenState createState() => _SignToTextScreenState();
}

class _SignToTextScreenState extends State<SignToTextScreen> {
  File? _selectedImage;
  String? _selectedGesture;
  final ImagePicker _picker = ImagePicker();

  // Gesture images (sample placeholders)
  final Map<String, String> gestureImages = {
    'Hello': 'assets/images/hello.jpg',
    'Thank You': 'assets/images/thankyou.jpg',
    'Sorry': 'assets/images/sorry.jpg',
    'Yes': 'assets/images/yes.jpg',
    'No': 'assets/images/no.jpg',
  };

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _uploadImage() {
    if (_selectedImage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image uploaded successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image first!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign to Text')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Image Selection Section
            Text(
              'Upload an image for sign recognition',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: const Icon(Icons.camera),
                  label: const Text('Camera'),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: const Icon(Icons.image),
                  label: const Text('Gallery'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            _selectedImage != null
                ? Image.file(_selectedImage!, height: 150, width: 150, fit: BoxFit.cover)
                : const Text('No image selected', style: TextStyle(color: Colors.grey)),

            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: _uploadImage,
              icon: const Icon(Icons.upload),
              label: const Text('Upload Image'),
            ),

            const SizedBox(height: 30),
            Divider(thickness: 1.5),
            const SizedBox(height: 10),

            // Gesture Selection Section
            Text(
              'Select a gesture to view its sign',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: _selectedGesture,
              hint: const Text('Choose a gesture'),
              isExpanded: true,
              items: gestureImages.keys.map((gesture) {
                return DropdownMenuItem(
                  value: gesture,
                  child: Text(gesture),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGesture = value;
                });
              },
            ),

            const SizedBox(height: 10),
            _selectedGesture != null
                ? Image.asset(gestureImages[_selectedGesture!]!, height: 150)
                : const Text('Select a gesture to see the image', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
