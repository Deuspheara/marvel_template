import 'package:flutter/material.dart';
import 'package:marvel_app/presentation/utils/paged_characters_list_view.dart';
import 'package:marvel_app/presentation/viewmodel/home_viewmodel.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HomeViewModel.buildWithProvider(
      builder: (_, __) => const HomeContent(),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final HomeViewModel viewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      body: SafeArea(
        child: PagedCharactersListView(
          characterEndpoint: viewModel.characterEndpoint,
          connectivityService: viewModel.connectivityService,
        ),
      ),
    );
  }
}
