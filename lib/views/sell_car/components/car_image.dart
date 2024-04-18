import 'dart:io';

import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class CarImage extends StatelessWidget {
  final VoidCallback onDeleteTap;
  final String imagePath;

  const CarImage({super.key, required this.onDeleteTap,required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height(context) * 0.125,
          width: height(context) * 0.125,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kRadius10),
            image:  DecorationImage(
              image: FileImage(File(imagePath.toString())),
              fit: BoxFit.fill,
            ),
          ),
          margin: const EdgeInsets.only(left: 5),
        ),
        Positioned(
          right: 6,
          top: 6,
          child: Bounceable(
            onTap: onDeleteTap,
            child: SvgPicture.asset(AppIcons.close),
          ),
        ),
      ],
    );
  }
}
