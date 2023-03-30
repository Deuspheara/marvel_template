import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:flutter/material.dart';

import 'package:marvel_app/data/model/character.dart';
import 'package:marvel_app/data/model/characters_response.dart';
import 'package:provider/provider.dart';

import '../../data/endpoint/characters_endpoint.dart';
import '../../infrastructure/services/connectivity_service.dart';
import '../viewmodel/home_viewmodel.dart';

class PagedCharactersListView extends StatefulWidget {
  const PagedCharactersListView({
    Key? key,
  }) : super(key: key);

  @override
  _PagedCharactersListViewState createState() =>
      _PagedCharactersListViewState();
}

class _PagedCharactersListViewState extends State<PagedCharactersListView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (_, viewModel, __) => RefreshIndicator(
        onRefresh: () =>
            Future.sync(() => viewModel.pagingController.refresh()),
        child: PagedListView.separated(
          pagingController: viewModel.pagingController,
          builderDelegate: PagedChildBuilderDelegate<Character>(
            itemBuilder: (context, item, index) {
              final isFavorite = ValueNotifier<bool>(false);
              viewModel.isFavorite(item).then((value) {
                isFavorite.value = value;
              });

              return ListTile(
                onTap: () => Navigator.pushNamed(context, '/character',
                    arguments: item.id),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    '${item.thumbnail?.path ?? ""}.${item.thumbnail?.extension ?? ".jpg"}',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(item.name ?? ''),
                trailing: ValueListenableBuilder<bool>(
                  valueListenable: isFavorite,
                  builder: (context, value, child) {
                    return IconButton(
                      icon: Icon(
                        isFavorite.value
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: () async {
                        viewModel.toggleFavorite(item);
                        isFavorite.value = !value;
                      },
                    );
                  },
                ),
              );
            },
          ),
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
    );
  }
}
