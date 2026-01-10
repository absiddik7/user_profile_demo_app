import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:user_profile/core/constants/app_dimensions.dart';
import 'package:user_profile/core/utils/app_utils.dart';
import 'package:user_profile/ui/theme/app_colors.dart';

class UserAvatar extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final double size;
  final double borderRadius;
  final Color? borderColor;
  final double? borderWidth;

  const UserAvatar({
    super.key,
    this.imageUrl,
    required this.name,
    this.size = AppDimensions.avatarM,
    this.borderRadius = AppDimensions.radiusCircular,
    this.borderColor,
    this.borderWidth,
  });

  // Small avatar
  factory UserAvatar.small({String? imageUrl, required String name}) {
    return UserAvatar(
      imageUrl: imageUrl,
      name: name,
      size: AppDimensions.avatarS,
    );
  }

  // Medium avatar (default)
  factory UserAvatar.medium({String? imageUrl, required String name}) {
    return UserAvatar(
      imageUrl: imageUrl,
      name: name,
      size: AppDimensions.avatarM,
    );
  }

  // Large avatar
  factory UserAvatar.large({String? imageUrl, required String name}) {
    return UserAvatar(
      imageUrl: imageUrl,
      name: name,
      size: AppDimensions.avatarL,
    );
  }

  // Extra large avatar
  factory UserAvatar.extraLarge({String? imageUrl, required String name}) {
    return UserAvatar(
      imageUrl: imageUrl,
      name: name,
      size: AppDimensions.avatarXL,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: borderWidth != null
            ? Border.all(
                color: borderColor ?? AppColors.white,
                width: borderWidth!,
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: _buildImage(),
      ),
    );
  }

  // Build avatar image
  Widget _buildImage() {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return _buildPlaceholder();
    }

    return CachedNetworkImage(
      imageUrl: imageUrl!,
      fit: BoxFit.cover,
      placeholder: (context, url) => _buildLoadingPlaceholder(),
      errorWidget: (context, url, error) => _buildPlaceholder(),
    );
  }

  // Build loading placeholder
  Widget _buildLoadingPlaceholder() {
    return Container(
      color: AppColors.shimmerBase,
      child: Center(
        child: SizedBox(
          width: size * 0.4,
          height: size * 0.4,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.grey400,
          ),
        ),
      ),
    );
  }

  // Build initials placeholder
  Widget _buildPlaceholder() {
    final initials = AppUtils.getInitials(name);
    final fontSize = size * 0.35;

    return Container(
      color: AppColors.primary.withValues(alpha: 0.1),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
