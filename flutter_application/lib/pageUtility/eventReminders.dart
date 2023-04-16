import 'package:flutter_application_1/pageUtility/notifcationHelper.dart';
import '../model/Events.dart';

///sets notifications for a list of events 15 minutes before they start
void scheduleEventReminders(List<Event> events) {
  for (final event in events) {
    final notificationTime = event.startTime.subtract(Duration(minutes: 15));

    if (notificationTime.isAfter(DateTime.now())) {
      NotificationHelper.scheduleNotification(
        id: event.id,
        title: 'Event Reminder',
        body: 'The event "${event.title}" is starting in 15 minutes.',
        scheduledTime: notificationTime,
      );
    }
  }
}

/// Sets notifications for an event 15 minutes before it happens
void scheduleEventReminder(Event event) {
  final notificationTime = event.startTime.subtract(Duration(minutes: 15));

  if (notificationTime.isAfter(DateTime.now())) {
    NotificationHelper.scheduleNotification(
      id: event.id,
      title: 'Event Reminder',
      body: 'The event "${event.title}" is starting in 15 minutes.',
      scheduledTime: notificationTime,
    );
  }
}