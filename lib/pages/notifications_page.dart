import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/locale_provider.dart';
import '../services/font_size_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../widgets/top_banner_widget.dart';
import '../l10n/app_localizations.dart';

final supabase = Supabase.instance.client;

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  List<Map<String, dynamic>> notifications = [];
  bool loading = true;
  String message = '';

  @override
  void initState() {
    super.initState();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      setState(() {
        loading = false;
        message = AppLocalizations.of(context)!.signInToViewNotifications;
      });
      return;
    }

    setState(() {
      loading = true;
      message = '';
    });

    try {
      final result = await supabase
          .from('notifications')
          .select()
          .eq('user_id', user.id)
          .order('created_at', ascending: false)
          .limit(50);

      setState(() {
        notifications = List<Map<String, dynamic>>.from(result);
        loading = false;
      });
    } catch (error) {
      setState(() {
        loading = false;
        message = AppLocalizations.of(context)!.couldNotLoadNotifications(error.toString());
      });
    }
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      await supabase
          .from('notifications')
          .update({'is_read': true})
          .eq('id', notificationId);

      await loadNotifications();
    } catch (error) {
      setState(() {
        message = AppLocalizations.of(context)!.couldNotMarkAsRead(error.toString());
      });
    }
  }

  Widget notificationTile(Map<String, dynamic> n) {
    final id = n['id'].toString();
    final title = n['title']?.toString() ?? AppLocalizations.of(context)!.notificationFallback;
    final body = n['body']?.toString() ?? '';
    final isRead = n['is_read'] == true;
    final type = n['type']?.toString() ?? 'info';

    IconData icon;
    Color color;

    switch (type) {
      case 'booking_assigned':
      case 'booking_accepted':
      case 'booking_started':
      case 'booking_completed':
        icon = Icons.check_circle_outline;
        color = Colors.green;
        break;
      case 'booking_declined':
      case 'booking_cancelled':
        icon = Icons.error_outline;
        color = Colors.orange;
        break;
      case 'warning':
        icon = Icons.warning_amber_outlined;
        color = Colors.orange;
        break;
      case 'error':
        icon = Icons.error_outline;
        color = Colors.red;
        break;
      default:
        icon = Icons.info_outline;
        color = Colors.blue;
    }

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
        ),
      ),
      subtitle: body.isNotEmpty ? Text(body) : null,
      trailing: isRead
          ? null
          : IconButton(
              icon: const Icon(Icons.done_all),
              tooltip: AppLocalizations.of(context)!.markAsReadTooltip,
              onPressed: () => markAsRead(id),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final fontSizeProvider = Provider.of<FontSizeProvider>(context);
    return Scaffold(
      appBar: TopBannerWidget(
        fontScale: fontSizeProvider.scaleFactor,
        onLanguageChanged: (locale) {
          localeProvider.setLocale(locale);
        },
        onFontScaleChanged: (scale) {
          fontSizeProvider.setScaleFactor(scale);
        },
        title: AppLocalizations.of(context)!.notificationsTitle,
        onRefresh: loadNotifications,
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                if (message.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(message),
                  ),
                if (notifications.isEmpty && !loading)
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(AppLocalizations.of(context)!.noNotifications),
                  ),
                ...notifications.map(notificationTile),
              ],
            ),
    );
  }
}