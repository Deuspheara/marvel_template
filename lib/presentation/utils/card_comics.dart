import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/model/comics.dart';
import 'image_loader.dart';

class CardComics extends StatelessWidget {
  const CardComics({
    Key? key,
    required this.comics,
  }) : super(key: key);

  final Comics comics;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            //rounded corners
            ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: ImageLoader(
                  imageUrl:
                      '${comics.thumbnail?.path ?? ""}.${comics.thumbnail?.extension ?? ".jpg"}',
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                )),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(comics.title ?? '',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 20)),
            )
          ],
        ),
      ),
    );
  }
}
