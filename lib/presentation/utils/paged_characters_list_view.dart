import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:flutter/material.dart';

import 'package:marvel_app/data/model/character.dart';
import 'package:marvel_app/data/model/characters_response.dart';

import '../../data/endpoint/characters_endpoint.dart';
import '../../infrastructure/services/connectivity_service.dart';

class PagedCharactersListView extends StatefulWidget {
  const PagedCharactersListView({
    Key? key,
    required this.characterEndpoint,
    required this.connectivityService,
  }) : super(key: key);

  final CharacterEndpoint characterEndpoint;
  final ConnectivityServive connectivityService;

  @override
  _PagedCharactersListViewState createState() =>
      _PagedCharactersListViewState();
}

class _PagedCharactersListViewState extends State<PagedCharactersListView> {
  final PagingController<int, Character> _pagingController =
      PagingController(firstPageKey: 1);

  List<Character> characters = [];

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    final bool isConnected = await widget.connectivityService.isConnected();
    print('isConnected: $isConnected');
    if (isConnected) {
      try {
        final newPage =
            await widget.characterEndpoint.getCharactersPaginated(20, pageKey);
        final previouslyFetchedItemsCount =
            // 2
            _pagingController.itemList?.length ?? 0;

        final isLastPage = newPage.data.total! <=
            previouslyFetchedItemsCount + newPage.data.results.length;
        final newItems = (newPage.data.results as List).map((e) {
          return Character.fromJson(e);
        }).toList();

        if (isLastPage) {
          // 3
          _pagingController.appendLastPage(newItems as List<Character>);
        } else {
          final nextPageKey = pageKey + 20;
          _pagingController.appendPage(newItems, nextPageKey);
        }
      } catch (error) {
        // 4
        _pagingController.error = error;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => Future.sync(
        () => _pagingController.refresh(),
      ),
      child: PagedListView.separated(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Character>(
          itemBuilder: (context, item, index) => ListTile(
            onTap: () =>
                Navigator.pushNamed(context, '/character', arguments: item.id),
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
          ),
        ),
        separatorBuilder: (context, index) => Divider(),
      ),
    );
  }
}
