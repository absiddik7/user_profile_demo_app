import 'package:flutter/material.dart';
import 'package:user_profile/core/constants/app_dimensions.dart';
import 'package:user_profile/core/constants/app_strings.dart';
import 'package:user_profile/ui/theme/app_colors.dart';
import 'package:user_profile/ui/theme/app_text_styles.dart';

class CachedDataBanner extends StatelessWidget {
  final VoidCallback? onRefresh;

  const CachedDataBanner({super.key, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingL,
        vertical: AppDimensions.paddingS,
      ),
      color: AppColors.warningLight,
      child: Row(
        children: [
          _buildIcon(),
          const SizedBox(width: AppDimensions.spaceS),
          Expanded(child: _buildText()),
          if (onRefresh != null) _buildRefreshButton(),
        ],
      ),
    );
  }

  // Build warning icon
  Widget _buildIcon() {
    return Icon(
      Icons.wifi_off_rounded,
      size: AppDimensions.iconS,
      color: AppColors.warning,
    );
  }

  // Build banner text
  Widget _buildText() {
    return Text(
      AppStrings.showingCachedData,
      style: AppTextStyles.caption.copyWith(color: AppColors.grey700),
    );
  }

  // Build refresh button
  Widget _buildRefreshButton() {
    return TextButton.icon(
      onPressed: onRefresh,
      icon: Icon(
        Icons.refresh_rounded,
        size: AppDimensions.iconS,
        color: AppColors.warning,
      ),
      label: Text(
        AppStrings.refresh,
        style: AppTextStyles.buttonS.copyWith(color: AppColors.warning),
      ),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingS),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
