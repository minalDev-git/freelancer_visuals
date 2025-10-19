import 'package:flutter/material.dart';
import 'package:freelancer_visuals/core/theme/app_pallete.dart';

class StatusChip extends StatelessWidget {
  final Color color;
  final String status;
  const StatusChip({super.key, required this.color, required this.status});

  @override
  Widget build(BuildContext context) {
    return Chip(
      color: WidgetStatePropertyAll(color),
      label: Text(
        status,
        style: const TextStyle(fontSize: 15, color: AppPallete.blackColor),
      ),
    );
  }
}
