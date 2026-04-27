import 'package:flutter/material.dart';
import '../utils/colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample notifications
    final notifications = [
      {
        'title': 'Claim Submitted',
        'message': 'Your dental claim has been submitted successfully',
        'time': '2 hours ago',
        'type': 'success',
        'icon': Icons.check_circle,
        'read': false,
      },
      {
        'title': 'Claim Approved',
        'message': 'Your prescription claim of R185.50 has been approved',
        'time': '1 day ago',
        'type': 'success',
        'icon': Icons.approval,
        'read': false,
      },
      {
        'title': 'Document Required',
        'message': 'Please upload additional documents for your optical claim',
        'time': '2 days ago',
        'type': 'warning',
        'icon': Icons.warning_amber,
        'read': true,
      },
      {
        'title': 'Payment Processed',
        'message': 'Payment of R1,250.00 has been processed to your provider',
        'time': '3 days ago',
        'type': 'info',
        'icon': Icons.payment,
        'read': true,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: notifications.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_none,
              size: 80,
              color: AppColors.textLight,
            ),
            const SizedBox(height: 16),
            const Text(
              'No notifications',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      )
          : ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return _buildNotificationCard(
            title: notification['title'] as String,
            message: notification['message'] as String,
            time: notification['time'] as String,
            type: notification['type'] as String,
            icon: notification['icon'] as IconData,
            read: notification['read'] as bool,
          );
        },
      ),
    );
  }

  Widget _buildNotificationCard({
    required String title,
    required String message,
    required String time,
    required String type,
    required IconData icon,
    required bool read,
  }) {
    Color typeColor;
    switch (type) {
      case 'success':
        typeColor = AppColors.success;
        break;
      case 'warning':
        typeColor = AppColors.warning;
        break;
      case 'error':
        typeColor = AppColors.error;
        break;
      default:
        typeColor = AppColors.info;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: read ? Colors.transparent : typeColor.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: typeColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: typeColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: read ? FontWeight.normal : FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}