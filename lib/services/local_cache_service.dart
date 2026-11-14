// lib/services/local_cache_service.dart
import 'dart:convert';

class LocalCacheService {
  static final Map<String, String> _diskStorage = {};
  static final Map<String, DateTime> _timestampRegistry = {};

  void saveToDeviceDisk(String storageKey, List<Map<String, dynamic>> rawDataList) {
    _diskStorage[storageKey] = jsonEncode(rawDataList);
    _timestampRegistry[storageKey] = DateTime.now();
  }

  String getRawDataString(String storageKey) { return _diskStorage[storageKey] ?? "[]"; }

  void runAutomatedStorageWipeCleanup() {
    DateTime now = DateTime.now(); List<String> staleKeys = [];
    _timestampRegistry.forEach((k, t) { if (now.difference(t).inDays >= 3) staleKeys.add(k); });
    for (String k in staleKeys) { _diskStorage.remove(k); _timestampRegistry.remove(k); }
  }
}
