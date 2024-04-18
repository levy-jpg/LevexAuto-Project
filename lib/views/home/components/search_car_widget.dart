import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class SearchCarWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onFilterTap;
  final void Function(String)? onChanged;

  const SearchCarWidget({
    super.key,
    required this.controller,
    this.onFilterTap,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kPadding16),
      child: TextFormField(
        controller: controller,
        style: poppinsRegular.copyWith(
          color: AppColors.whiteColor,
          fontSize: kFont14,
        ),
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.whiteColor.withOpacity(0.1),
          contentPadding: EdgeInsets.symmetric(
            horizontal: kPadding16,
            vertical: kPadding12,
          ),
          prefixIcon: SvgPicture.asset(
            AppIcons.search,
            fit: BoxFit.scaleDown,
          ),
          suffixIcon: IconButton(
            onPressed: onFilterTap,
            icon: SvgPicture.asset(
              AppIcons.filter,
              fit: BoxFit.scaleDown,
            ),
          ),
          hintText: AppStrings.findYourNextCar,
          hintStyle: poppinsRegular.copyWith(
            color: AppColors.whiteColor.withOpacity(0.4),
            fontSize: kFont14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kRadius100),
            borderSide: BorderSide(
              color: AppColors.whiteColor.withOpacity(0.1),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kRadius100),
            borderSide: BorderSide(
              color: AppColors.whiteColor.withOpacity(0.1),
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kRadius100),
            borderSide: BorderSide(
              color: AppColors.whiteColor.withOpacity(0.1),
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
