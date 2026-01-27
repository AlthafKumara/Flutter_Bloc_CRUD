import 'package:hive/hive.dart';

import 'local_storage.dart';

class HiveLocalStorage implements LocalStorage {
  @override
  Future<void> clear({String? boxName}) async {
    await Hive.box(boxName!).clear();
  }

  @override
  Future<List<dynamic>> loadAll({String? boxName}) async {
    await Hive.openBox(boxName!);
    final box = Hive.box(boxName);

    try {
      return box.values.toList();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<dynamic> load({required String key, String? boxName}) async {
    await Hive.openBox(boxName!);
    final box = Hive.box(boxName);
    try {
      return box.get(key);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> save({
    required String key,
    required value,
    String? boxName,
  }) async {
    await Hive.openBox(boxName!);
    final box = Hive.box(boxName);
    try {
      await box.put(key, value);
      return;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> delete({required String key, String? boxName}) async {
    await Hive.openBox(boxName!);
    final box = Hive.box(boxName);
    try {
      await box.delete(key);
      return;
    } catch (_) {
      rethrow;
    }
  }
}
