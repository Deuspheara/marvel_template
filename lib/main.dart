import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:marvel_app/data/model/character.dart';
import 'package:marvel_app/data/model/comics.dart';
import 'package:marvel_app/data/model/thumbnail.dart';
import 'package:marvel_app/presentation/screen/character_detail_screen.dart';
import 'package:marvel_app/presentation/screen/home_screen.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'data/dto/favorite.dart';
import 'infrastructure/injections/injector.dart';

void main() async {
  //Hive Initialization
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  Hive.registerAdapter<Comics>(ComicsAdapter());
  Hive.registerAdapter<Thumbnail>(ThumbnailAdapter());
  Hive.registerAdapter<Character>(CharacterAdapter());
  Hive.registerAdapter<Favorite>(FavoriteAdapter());

  //GetIt Initialization
  final GetIt getIt = initializeInjections();
  await getIt.allReady();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Marvel app',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: const HomeScreen(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => const HomeScreen(),
          '/character': (BuildContext context) => const CharacterDetailScreen(),
        });
  }
}
