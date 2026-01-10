import 'package:flutter/material.dart';
import 'package:user_profile/core/constants/app_dimensions.dart';
import 'package:user_profile/ui/theme/app_colors.dart';
import 'package:user_profile/ui/theme/app_text_styles.dart';

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? iconColor;
  final bool isSelectable;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.iconColor,
    this.isSelectable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIcon(),
          const SizedBox(width: AppDimensions.spaceM),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  // Build icon container
  Widget _buildIcon() {
    return Container(
      width: AppDimensions.iconXL,
      height: AppDimensions.iconXL,
      decoration: BoxDecoration(
        color: (iconColor ?? AppColors.primary).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: Icon(
        icon,
        color: iconColor ?? AppColors.primary,
        size: AppDimensions.iconM,
      ),
    );
  }

  // Build label and value
  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.label),
        const SizedBox(height: AppDimensions.spaceXS),
        isSelectable
            ? SelectableText(value, style: AppTextStyles.bodyL)
            : Text(value, style: AppTextStyles.bodyL),
      ],
    );
  }
}
