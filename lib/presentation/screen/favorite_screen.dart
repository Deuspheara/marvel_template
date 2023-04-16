import 'package:flutter/material.dart';
import 'package:marvel_app/presentation/viewmodel/favorite_viewmodel.dart';
import 'package:provider/provider.dart';

import '../utils/image_loader.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return FavoriteViewModel.buildWithProvider(
        builder: (_, __) => const FavoriteContent());
  }
}

class FavoriteContent extends StatefulWidget {
  const FavoriteContent({Key? key}) : super(key: key);

  @override
  _FavoriteContentState createState() => _FavoriteContentState();
}

class _FavoriteContentState extends State<FavoriteContent> {
  @override
  Widget build(BuildContext context) {
    final FavoriteViewModel viewModel = Provider.of<FavoriteViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Center(
        child: Consumer<FavoriteViewModel>(
          builder: (_, FavoriteViewModel viewModel, __) {
            return ListView.builder(
              itemCount: viewModel.favorites.length,
              itemBuilder: (BuildContext context, int index) {
                final favorite = viewModel.favorites[index];
                return ListTile(
                  title: Text(favorite.character?.name ?? ""),
                  leading: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: ImageLoader(
                        height: 50,
                        width: 50,
                        imageUrl:
                            '${favorite.character?.thumbnail?.path ?? ""}.${favorite.character?.thumbnail?.extension ?? ".jpg"}',
                      )),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/character',
                      arguments: favorite.character,
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
