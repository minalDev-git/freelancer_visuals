import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:freelancer_visuals/core/theme/app_pallete.dart';

class PolicyDialog extends StatelessWidget {
  PolicyDialog({super.key, this.radius = 8, required this.mdFileName}) {
    // Runtime check (works in debug + release)
    if (!mdFileName.endsWith('.md')) {
      throw ArgumentError(
        'Invalid file: $mdFileName. The file must end with .md',
      );
    }
  }

  final double radius;
  final String mdFileName;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: Future.delayed(const Duration(milliseconds: 150)).then((
                value,
              ) {
                return rootBundle.loadString('assets/app_policy/$mdFileName');
              }),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Markdown(data: snapshot.requireData);
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ButtonStyle(
              padding: const WidgetStatePropertyAll(
                EdgeInsetsGeometry.all(8.0),
              ),
              backgroundColor: WidgetStatePropertyAll(
                Theme.of(context).colorScheme.primary,
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(radius),
                    bottomRight: Radius.circular(radius),
                  ),
                ),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(radius),
                  bottomRight: Radius.circular(radius),
                ),
              ),
              alignment: Alignment.center,
              height: 50,
              width: double.infinity,
              child: const Text(
                'OK',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppPallete.blackColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
