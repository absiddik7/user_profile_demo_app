import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_profile/core/constants/app_constants.dart';
import 'package:user_profile/core/models/user_model.dart';

class CacheService {
  final SharedPreferences _prefs;

  CacheService({required SharedPreferences prefs}) : _prefs = prefs;

  // Cache users data
  Future<bool> cacheUsers(List<UserModel> users) async {
    try {
      final usersJson = users.map((u) => u.toJson()).toList();
      final jsonString = jsonEncode(usersJson);

      await _prefs.setString(AppConstants.usersCacheKey, jsonString);
      await _prefs.setInt(
        AppConstants.cacheTimestampKey,
        DateTime.now().millisecondsSinceEpoch,
      );

      return true;
    } catch (e) {
      print('Error caching users: $e');
      return false;
    }
  }

  // Get cached users
  List<UserModel>? getCachedUsers() {
    try {
      final jsonString = _prefs.getString(AppConstants.usersCacheKey);

      if (jsonString == null || jsonString.isEmpty) {
        return null;
      }

      final List<dynamic> usersJson = jsonDecode(jsonString);
      return usersJson
          .map((json) => UserModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error getting cached users: $e');
      return null;
    }
  }

  // Check if cache is valid (not expired)
  bool isCacheValid() {
    try {
      final timestamp = _prefs.getInt(AppConstants.cacheTimestampKey);

      if (timestamp == null) {
        return false;
      }

      final cacheTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final now = DateTime.now();
      final difference = now.difference(cacheTime);

      return difference.inMinutes < AppConstants.cacheDurationMinutes;
    } catch (e) {
      return false;
    }
  }

  Future<bool> clearCache() async {
    try {
      await _prefs.remove(AppConstants.usersCacheKey);
      await _prefs.remove(AppConstants.cacheTimestampKey);
      return true;
    } catch (e) {
      print('Error clearing cache: $e');
      return false;
    }
  }

  DateTime? getCacheTimestamp() {
    final timestamp = _prefs.getInt(AppConstants.cacheTimestampKey);
    if (timestamp != null) {
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    }
    return null;
  }
}
