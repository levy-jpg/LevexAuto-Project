import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/constants.dart';

class CustomTextField extends StatelessWidget {
  final String heading;
  final TextEditingController controller;
  final String hintText;
  final bool? isObscure;
  final String? obscureCharacter;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatter;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final int? minLines;
  final int? maxLines;

  const CustomTextField({
    super.key,
    required this.heading,
    required this.controller,
    required this.hintText,
    this.isObscure = false,
    this.obscureCharacter = '*',
    this.keyboardType,
    this.validator,
    this.inputFormatter,
    this.onChanged,
    this.suffixIcon,
    this.textInputAction = TextInputAction.next,
    this.minLines = 1,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        /// heading
        Text(
          heading,
          style: poppinsSemiBold.copyWith(
            color: AppColors.whiteColor,
            fontSize: kFont14,
          ),
        ),
        SizedBox(height: height(context) * 0.01),

        /// field
        TextFormField(
          controller: controller,
          obscureText: isObscure!,
          obscuringCharacter: obscureCharacter!,
          keyboardType: keyboardType,
          validator: validator,
          inputFormatters: inputFormatter,
          onChanged: onChanged,
          textInputAction: textInputAction,
          style: poppinsMedium.copyWith(
            fontSize: kFont14,
            color: AppColors.whiteColor,
          ),
          minLines: minLines,
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.boxColor,
            hintText: hintText,
            hintStyle: poppinsMedium.copyWith(
              fontSize: kFont14,
              color: AppColors.whiteColor.withOpacity(0.5),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: kPadding16,
              vertical: kPadding14,
            ),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kRadius10),
              borderSide: const BorderSide(
                color: AppColors.strokeColor,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kRadius10),
              borderSide: const BorderSide(
                color: AppColors.whiteColor,
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kRadius10),
              borderSide: const BorderSide(
                color: AppColors.strokeColor,
                width: 1.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
