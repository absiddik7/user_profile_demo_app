import 'package:flutter/foundation.dart';
import 'package:user_profile/core/constants/app_strings.dart';
import 'package:user_profile/core/models/user_model.dart';
import 'package:user_profile/core/services/cache_service.dart';
import 'package:user_profile/core/services/connectivity_service.dart';
import 'package:user_profile/core/services/dio_client.dart';
import 'package:user_profile/core/services/user_service.dart';
import 'package:user_profile/core/utils/app_utils.dart';


// View State enum for handling different UI states
enum ViewState {
  initial,
  loading,
  loaded,
  loadingMore,
  error,
  empty,
  noConnection,
}


class UserProvider extends ChangeNotifier {
  final UserService _userService;
  final CacheService _cacheService;
  final ConnectivityService _connectivityService;

  UserProvider({
    required UserService userService,
    required CacheService cacheService,
    required ConnectivityService connectivityService,
  }) : _userService = userService,
       _cacheService = cacheService,
       _connectivityService = connectivityService;

  ViewState _state = ViewState.initial;
  ViewState get state => _state;

  List<UserModel> _users = [];
  List<UserModel> get users => _searchQuery.isEmpty ? _users : _filteredUsers;

  List<UserModel> _filteredUsers = [];

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  int _currentPage = 1;
  bool _hasMorePages = true;
  bool get hasMorePages => _hasMorePages;

  bool _isUsingCachedData = false;
  bool get isUsingCachedData => _isUsingCachedData;

  UserModel? _selectedUser;
  UserModel? get selectedUser => _selectedUser;

  // Initialize and fetch users
  Future<void> initialize() async {
    await fetchUsers(refresh: true);
  }

  // Fetch users from API or cache
  Future<void> fetchUsers({bool refresh = false}) async {
    // If refreshing, reset pagination
    if (refresh) {
      _currentPage = 1;
      _hasMorePages = true;
      _isUsingCachedData = false;
    }

    // Check if we have more pages to load
    if (!refresh && !_hasMorePages) {
      return;
    }

    // Set loading state
    if (refresh || _users.isEmpty) {
      _setState(ViewState.loading);
    } else {
      _setState(ViewState.loadingMore);
    }

    // Check connectivity
    final isConnected = await _connectivityService.isConnected();

    if (!isConnected) {
      await _handleNoConnection(refresh);
      return;
    }

    try {
      final response = await _userService.getUsers(page: _currentPage);

      if (refresh) {
        _users = response.users;
      } else {
        _users = [..._users, ...response.users];
      }

      _hasMorePages = response.users.isNotEmpty;
      _currentPage++;

      // Cache the users
      await _cacheService.cacheUsers(_users);

      // Apply search filter if active
      if (_searchQuery.isNotEmpty) {
        _filterUsers();
      }

      if (_users.isEmpty) {
        _setState(ViewState.empty);
      } else {
        _setState(ViewState.loaded);
      }
    } on NetworkException {
      await _handleNoConnection(refresh);
    } on TimeoutException {
      _setError(AppStrings.errorTimeout);
    } on ServerException catch (e) {
      _setError(e.message);
    } catch (e) {
      _setError(AppStrings.errorGeneric);
    }
  }

  Future<void> _handleNoConnection(bool refresh) async {
    if (refresh || _users.isEmpty) {
      final cachedUsers = _cacheService.getCachedUsers();

      if (cachedUsers != null && cachedUsers.isNotEmpty) {
        _users = cachedUsers;
        _isUsingCachedData = true;
        _hasMorePages = false;

        if (_searchQuery.isNotEmpty) {
          _filterUsers();
        }

        _setState(ViewState.loaded);
        return;
      }
    }

    _setError(AppStrings.errorNetwork);
    _setState(ViewState.noConnection);
  }

  // Load more users (for pagination)
  Future<void> loadMore() async {
    if (_state == ViewState.loadingMore || !_hasMorePages) {
      return;
    }

    await fetchUsers(refresh: false);
  }

  // Refresh users (pull to refresh)
  Future<void> refresh() async {
    await fetchUsers(refresh: true);
  }

  // Search users by name
  void searchUsers(String query) {
    _searchQuery = AppUtils.sanitizeSearchQuery(query);
    _filterUsers();
    notifyListeners();
  }

  // Clear search
  void clearSearch() {
    _searchQuery = '';
    _filteredUsers = [];
    notifyListeners();
  }

  // Filter users based on search query
  void _filterUsers() {
    if (_searchQuery.isEmpty) {
      _filteredUsers = [];
      return;
    }

    _filteredUsers = _users.where((user) {
      return AppUtils.matchesSearch(user.fullName, _searchQuery);
    }).toList();
  }

  // Select a user for detail view
  void selectUser(UserModel user) {
    _selectedUser = user;
    notifyListeners();
  }

  // Clear selected user
  void clearSelectedUser() {
    _selectedUser = null;
    notifyListeners();
  }

  // Set view state
  void _setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }

  // Set error message and state
  void _setError(String message) {
    _errorMessage = message;
    _setState(ViewState.error);
  }

  bool get isLoading => _state == ViewState.loading;
  bool get isLoadingMore => _state == ViewState.loadingMore;
  bool get hasError => _state == ViewState.error;
  bool get isEmpty => _state == ViewState.empty;
  bool get hasNoConnection => _state == ViewState.noConnection;
  bool get searchHasNoResults =>
      _searchQuery.isNotEmpty && _filteredUsers.isEmpty && _users.isNotEmpty;
}
