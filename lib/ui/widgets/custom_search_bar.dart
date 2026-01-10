import 'package:flutter/material.dart';
import 'package:user_profile/core/constants/app_dimensions.dart';
import 'package:user_profile/core/constants/app_strings.dart';
import 'package:user_profile/ui/theme/app_colors.dart';
import 'package:user_profile/ui/theme/app_text_styles.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final String? hintText;
  final bool autofocus;

  const CustomSearchBar({
    super.key,
    required this.controller,
    this.onChanged,
    this.onClear,
    this.hintText,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.searchBarHeight,
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.marginL,
        vertical: AppDimensions.marginS,
      ),
      decoration: BoxDecoration(
        color: AppColors.searchBackground,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
      child: Row(
        children: [
          _buildSearchIcon(),
          Expanded(child: _buildTextField()),
          _buildClearButton(),
        ],
      ),
    );
  }

  // Build search icon
  Widget _buildSearchIcon() {
    return Padding(
      padding: const EdgeInsets.only(left: AppDimensions.paddingM),
      child: Icon(
        Icons.search_rounded,
        color: AppColors.searchIcon,
        size: AppDimensions.iconM,
      ),
    );
  }

  // Build text field
  Widget _buildTextField() {
    return TextField(
      controller: controller,
      autofocus: autofocus,
      onChanged: onChanged,
      style: AppTextStyles.bodyM.copyWith(color: AppColors.searchText),
      decoration: InputDecoration(
        hintText: hintText ?? AppStrings.searchHint,
        hintStyle: AppTextStyles.searchHint,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingS,
          vertical: AppDimensions.paddingM,
        ),
        filled: false,
      ),
    );
  }

  // Build clear button
  Widget _buildClearButton() {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        if (value.text.isEmpty) {
          return const SizedBox(width: AppDimensions.paddingM);
        }

        return IconButton(
          icon: Icon(
            Icons.close_rounded,
            color: AppColors.searchIcon,
            size: AppDimensions.iconS,
          ),
          onPressed: () {
            controller.clear();
            onClear?.call();
          },
          tooltip: AppStrings.clearSearch,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(
            minWidth: AppDimensions.iconL,
            minHeight: AppDimensions.iconL,
          ),
        );
      },
    );
  }
}
