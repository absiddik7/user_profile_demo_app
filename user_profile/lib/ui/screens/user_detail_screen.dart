import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_profile/core/constants/app_dimensions.dart';
import 'package:user_profile/core/constants/app_strings.dart';
import 'package:user_profile/core/models/user_model.dart';
import 'package:user_profile/core/providers/user_provider.dart';
import 'package:user_profile/ui/theme/app_colors.dart';
import 'package:user_profile/ui/theme/app_text_styles.dart';
import 'package:user_profile/ui/widgets/info_row.dart';
import 'package:user_profile/ui/widgets/loading_indicator.dart';
import 'package:user_profile/ui/widgets/user_avatar.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({super.key});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  void dispose() {
    // Clear selected user when navigating back
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<UserProvider>().clearSelectedUser();
      }
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Consumer<UserProvider>(
      builder: (context, provider, _) {
        final user = provider.selectedUser;

        if (user == null) {
          return const LoadingIndicator();
        }

        return CustomScrollView(
          slivers: [
            _buildSliverAppBar(user),
            SliverToBoxAdapter(child: _buildUserDetails(user)),
          ],
        );
      },
    );
  }

  // Sliver app bar with user avatar
  SliverAppBar _buildSliverAppBar(UserModel user) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: AppColors.primary,
      leading: _buildBackButton(),
      flexibleSpace: FlexibleSpaceBar(background: _buildHeaderBackground(user)),
    );
  }

  // Build back button
  Widget _buildBackButton() {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back_ios_rounded,
        color: AppColors.iconOnPrimary,
      ),
      onPressed: () => Navigator.of(context).pop(),
      tooltip: AppStrings.backButton,
    );
  }

  // Build header background with avatar
  Widget _buildHeaderBackground(UserModel user) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: AppDimensions.spaceXXL),
            _buildProfileAvatar(user),
            const SizedBox(height: AppDimensions.spaceL),
            _buildUserName(user),
          ],
        ),
      ),
    );
  }

  // Build profile avatar
  Widget _buildProfileAvatar(UserModel user) {
    return Hero(
      tag: 'avatar_${user.id}',
      child: UserAvatar.extraLarge(imageUrl: user.avatar, name: user.fullName),
    );
  }

  // Build user name
  Widget _buildUserName(UserModel user) {
    return Text(
      user.fullName,
      style: AppTextStyles.headingM.copyWith(color: AppColors.textOnPrimary),
      textAlign: TextAlign.center,
    );
  }

  // Build user details section
  Widget _buildUserDetails(UserModel user) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingXL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Contact Information'),
          const SizedBox(height: AppDimensions.spaceL),
          _buildContactInfo(user),
          const SizedBox(height: AppDimensions.spaceXXL),
          _buildSectionTitle('Personal Information'),
          const SizedBox(height: AppDimensions.spaceL),
          _buildPersonalInfo(user),
        ],
      ),
    );
  }

  // Build section title
  Widget _buildSectionTitle(String title) {
    return Text(title, style: AppTextStyles.titleL);
  }

  // Build contact information section
  Widget _buildContactInfo(UserModel user) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          InfoRow(
            icon: Icons.email_outlined,
            label: AppStrings.email,
            value: user.email,
            iconColor: AppColors.primary,
          ),
          Divider(color: AppColors.divider),
          InfoRow(
            icon: Icons.phone_outlined,
            label: AppStrings.phone,
            value: user.phone,
            iconColor: AppColors.secondary,
          ),
          if (user.cell.isNotEmpty) ...[
            Divider(color: AppColors.divider),
            InfoRow(
              icon: Icons.phone_android_outlined,
              label: 'Cell',
              value: user.cell,
              iconColor: AppColors.secondary,
            ),
          ],
        ],
      ),
    );
  }

  // Build personal information section
  Widget _buildPersonalInfo(UserModel user) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          if (user.gender.isNotEmpty)
            InfoRow(
              icon: Icons.person_outline,
              label: 'Gender',
              value: user.gender[0].toUpperCase() + user.gender.substring(1),
              iconColor: AppColors.accent,
            ),
          if (user.age != null) ...[
            Divider(color: AppColors.divider),
            InfoRow(
              icon: Icons.cake_outlined,
              label: 'Age',
              value: '${user.age} years',
              iconColor: AppColors.accent,
            ),
          ],
          if (user.city.isNotEmpty) ...[
            Divider(color: AppColors.divider),
            InfoRow(
              icon: Icons.location_city_outlined,
              label: 'City',
              value: user.city,
              iconColor: AppColors.accent,
            ),
          ],
          if (user.state.isNotEmpty) ...[
            Divider(color: AppColors.divider),
            InfoRow(
              icon: Icons.map_outlined,
              label: 'State',
              value: user.state,
              iconColor: AppColors.accent,
            ),
          ],
          if (user.country.isNotEmpty) ...[
            Divider(color: AppColors.divider),
            InfoRow(
              icon: Icons.flag_outlined,
              label: 'Country',
              value: user.country,
              iconColor: AppColors.accent,
            ),
          ],
        ],
      ),
    );
  }
}
