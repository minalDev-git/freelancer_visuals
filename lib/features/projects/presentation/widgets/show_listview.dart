import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:freelancer_visuals/core/theme/app_pallete.dart';
import 'package:freelancer_visuals/features/projects/domain/entities/project.dart';

class ShowListview<T> extends StatelessWidget {
  // final data;
  final PStatus? status;
  final int itemcount;
  final List<T> items;
  final Widget Function(T item) itemBuilder;
  final void Function(BuildContext context, T item)? onEditPressed;
  final void Function(BuildContext context, T item)? onDeletePressed;
  const ShowListview({
    super.key,
    required this.status,
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.itemcount,
    required this.items,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: itemcount,
        itemBuilder: (context, index) {
          //get individual data from datalist
          final data = items[index];
          final itemWidget = itemBuilder(data);
          return Slidable(
            endActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                //edit option
                SlidableAction(
                  onPressed: (ctx) => onEditPressed!(ctx, data),
                  icon: Icons.edit,
                  backgroundColor: Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                  foregroundColor: AppPallete.whiteColor,
                ),
                //delete option
                SlidableAction(
                  onPressed: (ctx) => onDeletePressed!(ctx, data),
                  icon: Icons.delete,
                  backgroundColor: AppPallete.darkError,
                  borderRadius: BorderRadius.circular(10),
                  foregroundColor: AppPallete.whiteColor,
                ),
              ],
            ),
            child: itemWidget,
          );
        },
      ),
    );
  }
}
