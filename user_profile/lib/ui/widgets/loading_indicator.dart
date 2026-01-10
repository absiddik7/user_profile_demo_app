import 'package:flutter/material.dart';
import 'package:user_profile/core/constants/app_dimensions.dart';
import 'package:user_profile/ui/theme/app_colors.dart';


class LoadingIndicator extends StatelessWidget {
  final String? message;
  final Color? color;
  final double? size;

  const LoadingIndicator({super.key, this.message, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size ?? AppDimensions.iconXL,
            height: size ?? AppDimensions.iconXL,
            child: CircularProgressIndicator(
              color: color ?? AppColors.primary,
              strokeWidth: 3,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: AppDimensions.spaceL),
            Text(
              message!,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
