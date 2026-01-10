import 'package:flutter/material.dart';
import 'package:user_profile/core/constants/app_dimensions.dart';
import 'package:user_profile/core/constants/app_strings.dart';
import 'package:user_profile/ui/theme/app_colors.dart';
import 'package:user_profile/ui/theme/app_text_styles.dart';

class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final IconData icon;
  final String? retryText;

  const ErrorView({
    super.key,
    required this.message,
    this.onRetry,
    this.icon = Icons.error_outline,
    this.retryText,
  });

  // Factory constructor for network error
  factory ErrorView.network({VoidCallback? onRetry}) {
    return ErrorView(
      message: AppStrings.errorNetwork,
      icon: Icons.wifi_off_rounded,
      onRetry: onRetry,
    );
  }

  // Factory constructor for empty state
  factory ErrorView.empty({String? message, VoidCallback? onRetry}) {
    return ErrorView(
      message: message ?? AppStrings.errorEmpty,
      icon: Icons.inbox_rounded,
      onRetry: onRetry,
      retryText: AppStrings.refresh,
    );
  }

  // Factory constructor for search no results
  factory ErrorView.noSearchResults() {
    return const ErrorView(
      message: AppStrings.searchNoResults,
      icon: Icons.search_off_rounded,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingXXL),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIcon(),
            const SizedBox(height: AppDimensions.spaceXL),
            _buildMessage(),
            if (onRetry != null) ...[
              const SizedBox(height: AppDimensions.spaceXL),
              _buildRetryButton(),
            ],
          ],
        ),
      ),
    );
  }

  // Build error icon
  Widget _buildIcon() {
    return Icon(
      icon,
      size: AppDimensions.iconXL * 1.5,
      color: AppColors.grey400,
    );
  }

  // Build error message
  Widget _buildMessage() {
    return Text(
      message,
      style: AppTextStyles.bodyL.copyWith(color: AppColors.textSecondary),
      textAlign: TextAlign.center,
    );
  }

  // Build retry button
  Widget _buildRetryButton() {
    return ElevatedButton.icon(
      onPressed: onRetry,
      icon: const Icon(Icons.refresh_rounded, color: AppColors.textOnPrimary),
      label: Text(
        retryText ?? AppStrings.retry,
        style: AppTextStyles.buttonM.copyWith(color: AppColors.textOnPrimary),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.textOnPrimary,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingXXL,
          vertical: AppDimensions.paddingM,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
      ),
    );
  }
}
