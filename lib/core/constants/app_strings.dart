class AppStrings {
  AppStrings._();

  // App Name
  static const String appName = 'User Profile';

  // Screen Titles
  static const String userListTitle = 'Users';
  static const String userDetailTitle = 'User Details';

  // Search
  static const String searchHint = 'Search users by name...';
  static const String searchNoResults = 'No users found matching your search';

  // Loading States
  static const String loading = 'Loading...';
  static const String loadingMore = 'Loading more users...';

  // Error Messages
  static const String errorGeneric = 'Something went wrong. Please try again.';
  static const String errorNetwork =
      'No internet connection. Please check your network settings.';
  static const String errorTimeout = 'Request timed out. Please try again.';
  static const String errorServer = 'Server error. Please try again later.';
  static const String errorEmpty = 'No users available at the moment.';
  static const String errorLoadingMore = 'Failed to load more users.';

  // Buttons
  static const String retry = 'Retry';
  static const String refresh = 'Refresh';

  // User Details Labels
  static const String email = 'Email';
  static const String phone = 'Phone';
  static const String name = 'Name';
  static const String firstName = 'First Name';
  static const String lastName = 'Last Name';

  // Status Messages
  static const String noMoreUsers = 'No more users to load';
  static const String pullToRefresh = 'Pull to refresh';
  static const String releaseToRefresh = 'Release to refresh';
  static const String refreshing = 'Refreshing...';

  // Cache Messages
  static const String showingCachedData = 'Showing cached data';
  static const String dataUpdated = 'Data updated successfully';

  // Accessibility
  static const String userAvatar = 'User avatar';
  static const String backButton = 'Go back';
  static const String searchButton = 'Search users';
  static const String clearSearch = 'Clear search';
}
