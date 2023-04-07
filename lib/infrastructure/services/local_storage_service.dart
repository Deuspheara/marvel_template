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

  /// Open a box with [boxName].
  /// If the box is already open, it will be closed and reopened.
  ///
  /// return [Future<void>]
  void switchBox<T>(String boxName) async {
    await _hive.openBox<T>(boxName);
    box = _hive.box<T>(boxName);
  }

  /// Get all the values in the box.
  ///
  /// return [Future<List<T>>]
  Future<void> save<T>(String key, T value) async {
    await box.put(key, value);
  }

  /// Get a value with [key] from the box.
  /// If the value is not in the box, return null.
  ///
  /// return [Future<T?>]
  Future<T?> get<T>(String key) async {
    return box.get(key);
  }

  /// Put a value with [key] in the box.
  /// If the value is already in the box, it will be overwritten.
  ///
  /// return [Future<void>]
  Future<void> put<T>(String key, T value) async {
    await box.put(key, value);
  }

  /// Delete a value with [key] from the box.
  ///
  /// return [Future<void>]
  Future<void> delete<T>(String key) async {
    await box.delete(key);
  }

  /// Get all the values in the box.
  ///
  /// return [Future<List<T>>]
  Future<List<T>> getFavorites<T>() async {
    return box.values.toList() as List<T>;
  }

  /// Check if the value with [key] is in the box.
  ///
  /// return [Future<bool>]
  Future<bool> isFavorite<T>(String key) async {
    return box.containsKey(key);
  }

  /// Toggle the favorite status of a value with [key] and [value].
  /// If the value is already in the box, it will be deleted.
  ///
  /// return [Future<void>]
  Future<void> toggleFavorite<T>(String key, T value) async {
    if (box.containsKey(key)) {
      await box.delete(key);
    } else {
      await box.put(key, value);
    }
  }

  /// Get the box at [id], if it doesn't exist
  /// Throw a [HiveError] with the [HiveErrorType.boxNotFound] type.
  ///
  /// return [Box<T>]
  Future<Box<T>> getBox<T>(String id) async {
    return box as Box<T>;
  }

  /// Get the box at [id], if it doesn't exist
  ///  Throw a [HiveError] with the [HiveErrorType.boxNotFound] type.
  ///
  /// return [T]
  Future<T> getBoxId<T>(String id) async {
    return box.get(id) as T;
  }

  /// Update a field in the box with [key] and [field] with [value], if it doesn't exist
  /// Throw a [HiveError] with the [HiveErrorType.boxNotFound] type.
  ///
  /// return [Future<void>]
  Future<void> updateField<T>(String key, String field, dynamic value) async {
    final Box<T> boxValue = await getBox<T>(key);
    await boxValue.put(field, value);
  }
}
