import 'package:flutter/material.dart';
import 'photo_grid.dart';

class CategoryScreen extends StatelessWidget {
  final String category;
  final List<String> photos;

  CategoryScreen({required this.category, required this.photos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: PhotoGrid(photos: photos),
    );
  }
}
