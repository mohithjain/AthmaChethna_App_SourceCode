import 'package:flutter/material.dart';
import 'dart:async';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final StreamController<List<NotificationItem>> _notificationStreamController =
      StreamController<List<NotificationItem>>.broadcast();

  @override
  void initState() {
    super.initState();
    // Simulate real-time data updates
    _startNotificationStream();
  }

  @override
  void dispose() {
    _notificationStreamController.close();
    super.dispose();
  }

  void _startNotificationStream() {
    // Initial notifications for To-Do List Reminders, Counselor Appointments, and Motivational Quotes
    List<NotificationItem> initialNotifications = [
      NotificationItem(
        type: NotificationType.todo,
        title: 'To-Do List Reminder',
        timeAgo: '2h ago',
        message:
            'Don’t forget to complete your task: Prepare presentation for the meeting today at 3 PM.',
      ),
      NotificationItem(
        type: NotificationType.appointment,
        title: 'Counselor Scheduled Appointment',
        timeAgo: '4h ago',
        message:
            'Your appointment with Ms.Sneha H is scheduled for April 5, 2025, at 2 PM. Please confirm.',
      ),
      NotificationItem(
        type: NotificationType.motivational,
        title: 'Morning Motivational Quote',
        timeAgo: '8h ago',
        message:
            '“The only way to do great work is to love what you do.” – Steve Jobs. Start your day with positivity!',
      ),
    ];

    _notificationStreamController.add(initialNotifications);

    // Simulate real-time updates every 30 seconds
    Timer.periodic(Duration(seconds: 3), (timer) {
      // Here you could add logic to fetch or simulate new notifications
      _notificationStreamController.add([
        ...initialNotifications,
      ]); // Refresh with same data for demo
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2EDE5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.brown,
        title: Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // Back arrow color changed to white
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Mark all as read functionality
              // This is a placeholder; implement actual logic as needed
            },
            child: Text(
              'Mark all as read',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<List<NotificationItem>>(
        stream: _notificationStreamController.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final notifications = snapshot.data!;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Today',
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return _buildNotificationTile(notification);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextButton(
                  onPressed: () {
                    // View all notifications functionality
                    // This is a placeholder; implement actual logic as needed
                  },
                  child: Text(
                    'View all notifications',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildNotificationTile(NotificationItem notification) {
    Color textColor = Colors.brown;

    if (notification.type == NotificationType.appointment) {
      textColor = Colors.blue; // Highlight appointments in red for urgency
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.brown, width: 1.0),
      ),
      margin: EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 8.0,
      ), // Optional: adds spacing between tiles
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
            ),
            child: Icon(
              _getIconForType(notification.type),
              size: 16,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      notification.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    Text(
                      notification.timeAgo,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  notification.message,
                  style: TextStyle(color: textColor, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForType(NotificationType type) {
    switch (type) {
      case NotificationType.todo:
        return Icons.checklist_outlined; // Icon for To-Do List Reminders
      case NotificationType.appointment:
        return Icons.calendar_today_outlined; // Icon for Counselor Appointments
      case NotificationType.motivational:
        return Icons.favorite_border_outlined; // Icon for Motivational Quotes
    }
  }
}

enum NotificationType { todo, appointment, motivational }

class NotificationItem {
  final NotificationType type;
  final String title;
  final String timeAgo;
  final String message;

  NotificationItem({
    required this.type,
    required this.title,
    required this.timeAgo,
    required this.message,
  });
}
