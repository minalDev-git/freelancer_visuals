import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:freelancer_visuals/main.dart';

Future<void> scheduleProjectDeadlineNotification({
  required String projectName,
  required DateTime startDate,
  required DateTime deadline,
  required dynamic tz,
}) async {
  final totalDuration = deadline.difference(startDate).inDays;
  final elapsedDuration = DateTime.now().difference(startDate).inDays;
  final progress = (elapsedDuration / totalDuration).clamp(0.0, 1.0);

  // Schedule deadline notification
  await flutterLocalNotificationsPlugin.zonedSchedule(
    projectName.hashCode, // unique ID
    'Project Deadline Reached',
    'The project "$projectName" has met its deadline.',
    tz.TZDateTime.from(deadline, tz.local),
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'project_channel',
        'Project Notifications',
        importance: Importance.high,
        priority: Priority.high,
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );

  print('Project notification scheduled for $deadline');
  print('Current project progress: ${(progress * 100).toStringAsFixed(2)}%');
}
