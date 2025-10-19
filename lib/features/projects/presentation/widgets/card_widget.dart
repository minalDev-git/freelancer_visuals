import 'package:flutter/material.dart';
import 'package:freelancer_visuals/core/common/widgets/status_chip.dart';
import 'package:freelancer_visuals/core/theme/app_pallete.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String desc;
  final String status;
  final Color color;
  final Widget smallCard;
  final bool showChip;
  final VoidCallback? onPressed;
  const CardWidget({
    super.key,
    required this.title,
    required this.desc,
    required this.status,
    required this.color,
    required this.smallCard,
    required this.showChip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/user.png',
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            desc,
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: AppPallete.greyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              showChip
                  ? StatusChip(color: color, status: status)
                  : IconButton(
                      onPressed: onPressed,
                      icon: Icon(Icons.arrow_forward_ios, size: 20),
                    ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: smallCard,
          ),
        ],
      ),
    );
  }
}
