import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:marvel_app/presentation/utils/paged_characters_list_view.dart';
import 'package:marvel_app/presentation/viewmodel/home_viewmodel.dart';
import 'package:provider/provider.dart';

import '../utils/paged_stories_list_view.dart';
import '../viewmodel/character_detail_viewmodel.dart';

class CharacterDetailScreen extends StatefulWidget {
  CharacterDetailScreen({Key? key}) : super(key: key);

  @override
  _CharacterDetailScreenState createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final Object? data = ModalRoute.of(context)?.settings.arguments;
    final int? id = data as int?;

    return CharacterDetailViewModel.buildWithProvider(
      builder: (_, __) => const CharacterDetailContent(),
      id: id ?? 0,
    );
  }
}

class CharacterDetailContent extends StatefulWidget {
  const CharacterDetailContent({Key? key}) : super(key: key);

  @override
  _CharacterDetailContentState createState() => _CharacterDetailContentState();
}

class _CharacterDetailContentState extends State<CharacterDetailContent> {
  bool _showComics = false;

  @override
  Widget build(BuildContext context) {
    final CharacterDetailViewModel viewModel =
        Provider.of<CharacterDetailViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        //take the theme color
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                //viewModel.toggleFavorite();
              });
            },
            icon: viewModel.isFavorite
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border),
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
        title: Text("Marvel App"),
        flexibleSpace: PreferredSize(
          child: Container(
            child: ClipRRect(
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                    child: Container(
                      //   width: MediaQuery.of(context).size.width,
                      //  height: MediaQuery.of(context).padding.top,
                      color: Colors.transparent,
                    ))),
          ),
          preferredSize: Size(MediaQuery.of(context).size.width, 22),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                  "${viewModel.character.thumbnail?.path}.${viewModel.character.thumbnail?.extension}",
                  fit: BoxFit.cover, errorBuilder: (BuildContext context,
                      Object exception, StackTrace? stackTrace) {
                return const CircularProgressIndicator();
              }, loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(viewModel.character.name ?? "",
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    Text(viewModel.character.description ?? "",
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    InkWell(
                        onTap: () {
                          setState(() {
                            _showComics = !_showComics;
                            viewModel.loadComics();
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Row(
                            children: const [
                              Icon(Icons.book),
                              SizedBox(width: 8),
                              Text(
                                'Comics',
                                style: TextStyle(fontSize: 18),
                              ),
                              Spacer(),
                              Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 350,
                      child: Visibility(
                          visible: _showComics, child: PagedStoriesListView()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
