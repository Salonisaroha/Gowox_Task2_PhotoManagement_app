import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';

class AddPhotoScreen extends StatefulWidget {
  @override
  _AddPhotoScreenState createState() => _AddPhotoScreenState();
}

class _AddPhotoScreenState extends State<AddPhotoScreen> {
  final ImagePicker _picker = ImagePicker();
  late BuildContext _scaffoldContext;
  String _selectedCategory = 'Posters'; // Default category
  List<String> _categories = ['Posters', 'Family', 'Flowers', 'Animals'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 15, 145, 221),
        centerTitle: true,
        title: const Text('Add New Photo', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color.fromARGB(255, 224, 229, 232), const Color.fromARGB(255, 186, 223, 240)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Builder(
          builder: (BuildContext context) {
            _scaffoldContext = context;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                const  Text(
                    'Add New Photo',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                    items: _categories.map((category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    decoration:const InputDecoration(
                      labelText: 'Select Category',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      child: Text(
                        'Pick Image',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 5, 
                      backgroundColor: const Color.fromARGB(255, 156, 201, 238),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final directory = await getApplicationDocumentsDirectory();
      final String path = join(directory.path, basename(image.path));
      final File newImage = await File(image.path).copy(path);
      Navigator.pop(_scaffoldContext, {'path': newImage.path, 'category': _selectedCategory});
    }
  }
}
