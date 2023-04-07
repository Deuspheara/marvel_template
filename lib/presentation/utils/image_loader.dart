import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageLoader extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;

  ImageLoader(
      {required this.imageUrl,
      this.width = 100,
      this.height = 100,
      this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    if (imageUrl.startsWith('http') || imageUrl.startsWith('https')) {
      return _buildNetworkImage(width, height, fit);
    } else if (imageUrl.startsWith('file://') || imageUrl.startsWith('/')) {
      print('Image URL: $imageUrl');
      return _buildLocalImage(width, height, fit);
    } else {
      return Container(
          child: Image.asset('assets/images/person-placeholder.png'));
    }
  }

  Widget _buildNetworkImage(double width, double height, BoxFit fit) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) =>
          Image.asset('assets/images/person-placeholder.png'),
      errorWidget: (context, url, error) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.error_outline),
            Text('Failed to load image'),
          ],
        ),
      ),
      fit: fit,
      width: width,
      height: height,
    );
  }

  Widget _buildLocalImage(double width, double height, BoxFit fit) {
    print("Image URL: $imageUrl");
    final file = File(imageUrl);
    if (file.existsSync()) {
      return FadeInImage(
        placeholder: Image.asset('assets/images/person-placeholder.png').image,
        image: FileImage(file),
        imageErrorBuilder: (context, error, stackTrace) {
          return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.error_outline),
                Text('Failed to load image'),
              ],
            ),
          );
        },
        fit: fit,
        width: width,
        height: height,
      );
    } else {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.error_outline),
            Text('Failed to load image'),
          ],
        ),
      );
    }
  }
}
