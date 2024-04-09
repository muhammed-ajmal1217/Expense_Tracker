import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotificationController {
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
  }

  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
  }

  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
  }

  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    if (receivedAction.channelKey == 'basic_channel' &&
        receivedAction.buttonKeyPressed == 'default') {
      await openApp();
    }
  }

  static Future<void> openApp() async {
    try {
      const platform = MethodChannel('app.channel.shared.data');
      await platform.invokeMethod('openApp');
    } on PlatformException catch (e) {
      print('Error opening app: $e');
    }
  }
}
