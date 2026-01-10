import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_profile/core/constants/app_dimensions.dart';
import 'package:user_profile/core/constants/app_strings.dart';
import 'package:user_profile/core/models/user_model.dart';
import 'package:user_profile/core/providers/user_provider.dart';
import 'package:user_profile/ui/screens/user_detail_screen.dart';
import 'package:user_profile/ui/theme/app_colors.dart';
import 'package:user_profile/ui/theme/app_text_styles.dart';
import 'package:user_profile/ui/widgets/cached_data_banner.dart';
import 'package:user_profile/ui/widgets/custom_search_bar.dart';
import 'package:user_profile/ui/widgets/error_view.dart';
import 'package:user_profile/ui/widgets/loading_indicator.dart';
import 'package:user_profile/ui/widgets/loading_more_indicator.dart';
import 'package:user_profile/ui/widgets/user_card.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initializeData();
    _setupScrollController();
  }

  // Initialize data on first load
  void _initializeData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().initialize();
    });
  }

  // Setup scroll controller for pagination
  void _setupScrollController() {
    _scrollController.addListener(_onScroll);
  }

  // Handle scroll for infinite loading
  void _onScroll() {
    if (_isNearBottom()) {
      _loadMoreUsers();
    }
  }

  // Check if scrolled near bottom
  bool _isNearBottom() {
    if (!_scrollController.hasClients) return false;

    final threshold = _scrollController.position.maxScrollExtent * 0.8;
    return _scrollController.position.pixels >= threshold;
  }

  // Load more users
  void _loadMoreUsers() {
    final provider = context.read<UserProvider>();
    if (!provider.isLoadingMore && provider.hasMorePages) {
      provider.loadMore();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  // Build app bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(AppStrings.userListTitle, style: AppTextStyles.appBarTitle),
      backgroundColor: AppColors.primary,
      elevation: 0,
    );
  }

  // Build main body
  Widget _buildBody() {
    return Column(
      children: [
        _buildSearchSection(),
        _buildCacheBanner(),
        Expanded(child: _buildContent()),
      ],
    );
  }

  // Build search section
  Widget _buildSearchSection() {
    return CustomSearchBar(
      controller: _searchController,
      onChanged: (query) {
        context.read<UserProvider>().searchUsers(query);
      },
      onClear: () {
        context.read<UserProvider>().clearSearch();
      },
    );
  }

  // Build cache banner
  Widget _buildCacheBanner() {
    return Consumer<UserProvider>(
      builder: (context, provider, _) {
        if (!provider.isUsingCachedData) {
          return const SizedBox.shrink();
        }

        return CachedDataBanner(onRefresh: () => provider.refresh());
      },
    );
  }

  // Build main content based on state
  Widget _buildContent() {
    return Consumer<UserProvider>(
      builder: (context, provider, _) {
        // Handle different states
        if (provider.isLoading) {
          return const LoadingIndicator(message: AppStrings.loading);
        }

        if (provider.hasNoConnection && provider.users.isEmpty) {
          return ErrorView.network(onRetry: () => provider.refresh());
        }

        if (provider.hasError && provider.users.isEmpty) {
          return ErrorView(
            message: provider.errorMessage,
            onRetry: () => provider.refresh(),
          );
        }

        if (provider.isEmpty) {
          return ErrorView.empty(onRetry: () => provider.refresh());
        }

        if (provider.searchHasNoResults) {
          return ErrorView.noSearchResults();
        }

        return _buildUserList(provider);
      },
    );
  }

  // Build user list with pull-to-refresh
  Widget _buildUserList(UserProvider provider) {
    return RefreshIndicator(
      onRefresh: () => provider.refresh(),
      color: AppColors.primary,
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(
          top: AppDimensions.paddingS,
          bottom: AppDimensions.paddingXXL,
        ),
        itemCount: provider.users.length + (provider.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          // Show loading indicator at the bottom
          if (index == provider.users.length) {
            return const LoadingMoreIndicator();
          }

          return _buildUserItem(
            provider.users[index],
            index == provider.users.length - 1,
          );
        },
      ),
    );
  }

  // Build individual user item
  Widget _buildUserItem(UserModel user, bool isLast) {
    return UserCard(
      user: user,
      showDivider: !isLast,
      onTap: () => _navigateToDetail(user),
    );
  }

  // Navigate to user detail screen
  void _navigateToDetail(UserModel user) {
    context.read<UserProvider>().selectUser(user);

    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const UserDetailScreen()));
  }
}
