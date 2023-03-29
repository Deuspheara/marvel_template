import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:marvel_app/presentation/utils/card_comics.dart';
import 'package:provider/provider.dart';

import '../../data/endpoint/characters_endpoint.dart';
import '../../data/model/character.dart';
import '../../data/model/stories.dart';
import '../../infrastructure/services/connectivity_service.dart';
import '../viewmodel/character_detail_viewmodel.dart';

class PagedStoriesListView extends StatelessWidget {
  const PagedStoriesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CharacterDetailViewModel>(
      builder: (context, viewModel, child) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          controller: viewModel.scrollController,
          itemCount: viewModel.comics.length,
          itemBuilder: (_, index) {
            final storie = viewModel.comics[index];
            if (storie.description?.isNotEmpty == true) {
              return SizedBox(
                  height: 200,
                  width: 200,
                  child: CardComics(
                    comics: viewModel.comics[index],
                  ));
            } else {
              return SizedBox(
                  height: 200,
                  width: 200,
                  child: CardComics(
                    comics: viewModel.comics[index],
                  ));
            }
          },
        );
      },
    );
  }
}
