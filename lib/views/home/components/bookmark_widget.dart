import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../../../controllers/home_controller.dart';

class BookmarkWidget extends StatefulWidget {
  String? postId;
  BookmarkWidget({super.key,required this.postId});

  @override
  State<BookmarkWidget> createState() => _BookmarkWidgetState();
}

class _BookmarkWidgetState extends State<BookmarkWidget> {
  HomeController controller = Get.put(HomeController());
  bool bookMarked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(controller.favList.contains(widget.postId)){
      bookMarked=true;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () async {
        if(controller.favList.contains(widget.postId)){
          await controller.removeFavourite(widget.postId);
        }else{
          await controller.addFavourite(widget.postId);
        }
        setState(() {
          bookMarked = !bookMarked;
        });
      },
      child: Container(
        height: height(context) * 0.042,
        width: height(context) * 0.042,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.blackColor.withOpacity(0.6),
        ),
        child: Center(
          child: SvgPicture.asset(
            bookMarked ? AppIcons.bookmarkFill : AppIcons.bookmark,
            color: AppColors.whiteColor,
            height: 20,
          ),
        ),
      ),
    );
  }
}
