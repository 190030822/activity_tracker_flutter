import 'package:activity_tracker/core/constants/colors.dart';
import 'package:activity_tracker/data/models/activity_model.dart';
import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {

  final Activity activity;
  const ActivityCard({super.key, required this.activity});

@override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text("Day :   ", style: TextStyle(color: figmaBlue, fontSize: 18),),
                Text("${activity.wakeUpTime.day}/${activity.wakeUpTime.month}", style: const TextStyle(color: figmaOrange, fontWeight: FontWeight.bold, fontSize: 20),)
              ],
            ),
            const Divider(height: 20, thickness: 2, color: figmaBorderColor,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Wake Up Time :',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${activity.wakeUpTime.hour}: ${activity.wakeUpTime.minute} ${activity.wakeUpTime.hour > 12 ? "PM" : "AM"}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: figmaGreen,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Gym :',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  activity.gym ? 'YES' : 'NO',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: figmaGreen,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Meditation :',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${activity.meditationTime} MIN",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: figmaGreen,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Reading :',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${activity.readingCount} PAGES",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: figmaGreen,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
