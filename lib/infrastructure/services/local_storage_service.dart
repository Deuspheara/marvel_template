import 'package:injectable/injectable.dart';
import 'package:hive/hive.dart';
import 'package:marvel_app/data/dto/favorite.dart';

@singleton
class LocalStorageService {
  final HiveInterface _hive;

  late Box box;

  LocalStorageService._(this._hive) {
    switchBox<Favorite>('favorite');
  }

  @factoryMethod
  static LocalStorageService inject() {
    return LocalStorageService._(Hive);
  }

  void switchBox<T>(String boxName) async {
    await _hive.openBox<T>(boxName);
    box = _hive.box<T>(boxName);
  }

  Future<void> save<T>(String key, T value) async {
    await box.put(key, value);
  }

  Future<T?> get<T>(String key) async {
    return box.get(key);
  }

  Future<void> put<T>(String key, T value) async {
    await box.put(key, value);
  }

  Future<void> delete<T>(String key) async {
    await box.delete(key);
  }

  Future<List<T>> getFavorites<T>() async {
    return box.values.toList() as List<T>;
  }

  Future<bool> isFavorite<T>(String key) async {
    return box.containsKey(key);
  }

  Future<void> toggleFavorite<T>(String key, T value) async {
    if (box.containsKey(key)) {
      await box.delete(key);
    } else {
      await box.put(key, value);
    }
  }

  Future<Box<T>> getBox<T>(String id) async {
    return box as Box<T>;
  }

  Future<T> getBoxId<T>(String id) async {
    return box.get(id) as T;
  }

  //update one field in a box
  Future<void> updateField<T>(String key, String field, dynamic value) async {
    final Box<T> boxValue = await getBox<T>(key);
    await boxValue.put(field, value);
  }
}
