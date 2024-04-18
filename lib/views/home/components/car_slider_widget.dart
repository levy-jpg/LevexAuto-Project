import 'package:flutter/material.dart';

import '../../../constants/constants.dart';
import 'bookmark_widget.dart';

class CarSliderWidget extends StatelessWidget {
  final List<dynamic> imagesData;
  String? postId;
   CarSliderWidget({super.key,required this.imagesData, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterCarousel(
          items: imagesData.map<Widget>((e) {
            return Container(
              height: height(context) * 0.35,
              width: width(context),
              decoration:  BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(e),
                  fit: BoxFit.fill,
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: height(context) * 0.35,
            viewportFraction: 1.0,
            initialPage: 0,
            enableInfiniteScroll: false,
            reverse: false,
            autoPlay: false,
            scrollDirection: Axis.horizontal,
            enlargeStrategy: CenterPageEnlargeStrategy.scale,
            disableCenter: false,
            showIndicator: true,
            slideIndicator: const CircularSlideIndicator(
              indicatorRadius: 5.0,
              itemSpacing: 16,
            ),
          ),
        ),
         Positioned(
          bottom: 16,
          right: 16,
          child: BookmarkWidget(postId: postId,),
        ),
      ],
    );
  }
}
