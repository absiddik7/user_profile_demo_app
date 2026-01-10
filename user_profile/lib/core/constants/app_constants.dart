import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  AppConstants._();

  // API Configuration
  static const String baseUrl = 'https://reqres.in/api';
  static const String usersEndpoint = '/users';
  static String get apiKey => dotenv.env['API_KEY'] ?? '';
  
  // Pagination
  static const int itemsPerPage = 10;
  
  // Timeouts
  static const int connectionTimeout = 60;
  static const int receiveTimeout = 60;
  
  // Cache Configuration
  static const String usersCacheKey = 'cached_users';
  static const String cacheTimestampKey = 'cache_timestamp';
  static const int cacheDurationMinutes = 30;
}
