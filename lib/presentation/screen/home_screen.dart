import 'package:flutter/material.dart';
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
      body: Center(
        //consumer
        child: Consumer<HomeViewModel>(
          builder: (_, HomeViewModel viewModel, __) {
            return ListView.builder(
              itemCount: viewModel.characters.length,
              itemBuilder: (BuildContext context, int index) {
                return Text(viewModel.characters[index].name ?? '');
              },
            );
          },
        ),
      ),
    );
  }
}
