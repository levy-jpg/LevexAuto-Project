import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class SideMenuBtn extends StatelessWidget {
  final VoidCallback onTap;
  final String iconUrl;
  final String text;

  const SideMenuBtn({
    super.key,
    required this.onTap,
    required this.iconUrl,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        kPadding16,
        kPadding16,
        kPadding16,
        0,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.only(bottom: kPadding16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.whiteColor.withOpacity(0.1),
                  width: 1.0,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: height(context) * 0.045,
                  width: height(context) * 0.045,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.whiteColor.withOpacity(0.05),
                  ),
                  child: Center(
                    child: SvgPicture.asset(iconUrl),
                  ),
                ),
                SizedBox(width: height(context) * 0.015),
                Expanded(
                  child: Text(
                    text,
                    style: poppinsMedium.copyWith(
                      color: AppColors.whiteOneColor,
                      fontSize: kFont14,
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_right,
                  color: AppColors.whiteOneColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
