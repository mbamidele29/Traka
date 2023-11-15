import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:traka/core/models/base_model.dart';

class LocalStorage {
  final FlutterSecureStorage flutterSecureStorage;

  LocalStorage({required this.flutterSecureStorage});

  Future<void> writeSecureString(
      {required String key, required String value}) async {
    try {
      await flutterSecureStorage.write(key: key, value: value);
    } catch (_) {}
  }

  Future<String?> readSecureString(String key) async {
    try {
      return await flutterSecureStorage.read(key: key);
    } catch (_) {
      return null;
    }
  }

  Future<void> deleteSecure(String key) async {
    try {
      await flutterSecureStorage.delete(key: key);
    } catch (_) {}
  }

  Future<void> writeSecureObject(
      {required String key, required BaseModel value}) async {
    try {
      await flutterSecureStorage.write(
          key: key, value: jsonEncode(value.toJson()));
    } catch (_) {}
  }
}
