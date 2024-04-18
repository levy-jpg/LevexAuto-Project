import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/countdown_controller.dart';
import 'timer_card_widget.dart';

class CountdownWidget extends StatelessWidget {
  const CountdownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    CountdownController controller = Get.put(CountdownController());
    return Obx(
      () {
        final duration = controller.timeLeft.value;
        String twoDigits(int n) => n.toString().padLeft(2, '0');
        final days = twoDigits(duration.inDays);
        final hours = twoDigits(duration.inHours.remainder(24));
        final minutes = twoDigits(duration.inMinutes.remainder(60));
        final seconds = twoDigits(duration.inSeconds.remainder(60));
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TimerCardWidget(
              countdownText: days,
              indicatorText: 'Days',
            ),
            TimerCardWidget(
              countdownText: hours,
              indicatorText: 'Hours',
            ),
            TimerCardWidget(
              countdownText: minutes,
              indicatorText: 'Minutes',
            ),
            TimerCardWidget(
              countdownText: seconds,
              indicatorText: 'Seconds',
            ),
          ],
        );
      },
    );
  }
}
