class AppConstants {
  AppConstants._();

  static const String baseUrl = 'https://randomuser.me/api';
  static const String usersEndpoint = '';
  static const String apiSeed = 'userprofileapp';
  static const int itemsPerPage = 10;
  static const int connectionTimeout = 30;
  static const int receiveTimeout = 30;
  static const String usersCacheKey = 'cached_users';
  static const String cacheTimestampKey = 'cache_timestamp';
  static const int cacheDurationMinutes = 30;
}
