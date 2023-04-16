import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:marvel_app/data/dto/character_position.dart';
import 'package:marvel_app/data/model/character.dart';
import 'package:marvel_app/data/model/comics.dart';
import 'package:marvel_app/data/model/thumbnail.dart';
import 'package:marvel_app/presentation/screen/character_detail_screen.dart';
import 'package:marvel_app/presentation/screen/home_screen.dart';
import 'package:marvel_app/presentation/utils/DarkThemeProvider.dart';
import 'package:marvel_app/presentation/utils/DarkThemeStyles.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';

import 'data/dto/country_code.dart';
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
  Hive.registerAdapter<CharacterPosition>(CharacterPositionAdapter());
  Hive.registerAdapter<CountryCode>(CountryCodeAdapter());
  //GetIt Initialization
  final GetIt getIt = initializeInjections();
  await getIt.allReady();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<DarkThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
              title: 'Marvel app',
              theme: Styles.themeData(themeChangeProvider.darkTheme, context),
              home: const HomeScreen(),
              routes: <String, WidgetBuilder>{
                '/home': (BuildContext context) => const HomeScreen(),
                '/character': (BuildContext context) =>
                    const CharacterDetailScreen(),
              });
        },
      ),
    );
  }
}
