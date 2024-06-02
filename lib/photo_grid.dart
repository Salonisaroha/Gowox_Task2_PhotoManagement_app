import 'package:flutter/material.dart';
import 'dart:io';

class PhotoGrid extends StatelessWidget {
  final List<String> photos;

  PhotoGrid({required this.photos});

  @override
  Widget build(BuildContext context) {
    return photos.isEmpty
        ? Center(child: Text('No photos yet.'))
        : GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: photos.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.file(File(photos[index]), fit: BoxFit.cover),
              );
            },
          );
  }
}
