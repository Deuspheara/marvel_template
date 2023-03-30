import 'package:injectable/injectable.dart';
import 'package:hive/hive.dart';

@singleton
class LocalStorageService {
  final HiveInterface _hive;

  String boxName;

  LocalStorageService._(this._hive, {required this.boxName});

  @factoryMethod
  static LocalStorageService inject() {
    return LocalStorageService._(Hive, boxName: 'marvel_app');
  }

  void switchBox(String boxName) {
    this.boxName = boxName;
  }

  Future<void> save(String key, dynamic value) async {
    final box = await _hive.openBox(boxName);
    await box.put(key, value);
  }

  Future<dynamic> get(String key) async {
    final box = await _hive.openBox(boxName);
    return box.get(key);
  }

  Future<void> put(String key, dynamic value) async {
    final box = await _hive.openBox(boxName);
    await box.put(key, value);
  }

  Future<void> delete(String key) async {
    final box = await _hive.openBox(boxName);
    await box.delete(key);
  }

  Future<bool> isFavorite(String key) async {
    final box = await _hive.openBox(boxName);
    return box.containsKey(key);
  }

  Future<void> toggleFavorite(String key, dynamic value) async {
    final box = await _hive.openBox(boxName);
    if (box.containsKey(key)) {
      await box.delete(key);
    } else {
      await box.put(key, value);
    }
  }
}
