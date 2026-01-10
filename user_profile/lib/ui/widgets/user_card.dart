import 'package:flutter/material.dart';
import 'package:user_profile/core/constants/app_dimensions.dart';
import 'package:user_profile/core/models/user_model.dart';
import 'package:user_profile/ui/theme/app_colors.dart';
import 'package:user_profile/ui/theme/app_text_styles.dart';
import 'user_avatar.dart';

class UserCard extends StatelessWidget {
  final UserModel user;
  final VoidCallback? onTap;
  final bool showDivider;

  const UserCard({
    super.key,
    required this.user,
    this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingL,
          vertical: AppDimensions.paddingM,
        ),
        child: Column(
          children: [_buildContent(), if (showDivider) _buildDivider()],
        ),
      ),
    );
  }

  // Build card content
  Widget _buildContent() {
    return Row(
      children: [
        _buildAvatar(),
        const SizedBox(width: AppDimensions.spaceM),
        Expanded(child: _buildUserInfo()),
        _buildArrowIcon(),
      ],
    );
  }

  // Build user avatar
  Widget _buildAvatar() {
    return UserAvatar.medium(imageUrl: user.avatar, name: user.fullName);
  }

  // Build user info (name and email)
  Widget _buildUserInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          user.fullName,
          style: AppTextStyles.userName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: AppDimensions.spaceXS),
        Text(
          user.email,
          style: AppTextStyles.userEmail,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  // Build arrow icon
  Widget _buildArrowIcon() {
    return Icon(
      Icons.arrow_forward_ios_rounded,
      size: AppDimensions.iconS,
      color: AppColors.iconSecondary,
    );
  }

  // Build divider
  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(top: AppDimensions.paddingM),
      child: Divider(color: AppColors.divider, height: 1),
    );
  }
}
