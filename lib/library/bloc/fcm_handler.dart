import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart' as fb;

class MyFirebaseHandler {
  // Initialize Firebase Messaging.
  Future<void> initialize() async {
    Firebase.initializeApp();

    // Request permission to send notifications.
    NotificationSettings settings = await fb.FirebaseMessaging.instance.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // Permission granted.
    } else {
      // Permission denied.
    }
  }

  // Subscribe to a topic.
  Future<void> subscribeToTopic(String topic) async {
    await FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  // Unsubscribe from a topic.
  Future<void> unsubscribeFromTopic(String topic) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }

  // Listen for messages.
  void onMessage(RemoteMessage message) {
    // Do something with the message.
    print(message.data);

    // If the message contains a notification, show it to the user.
    if (message.notification != null) {
      //showNotification(message);
    }

    // If the message contains data, handle it.
    if (message.data != null) {
      // Handle the data based on the data type.
      switch (message.data['type']) {
        case 'activity':
        // Handle the activity data.
          break;
        case 'geofence':
        // Handle the geofence data.
          break;
        case 'photo':
        // Handle the photo data.
          break;
        case 'audio':
        // Handle the audio data.
          break;
        case 'video':
        // Handle the video data.
          break;
        case 'settings':
        // Handle the settings data.
          break;
        default:
        // Do nothing.
          break;
      }
    }

    // If the app is in the background, handle the message accordingly.
    // if (!FirebaseMessaging.instance.getAPNSToken()) {
    //   // Do something with the message.
    //   print('App is in the background');
    // }

    // Handle errors from FCM itself.
    try {
      // Do something with the message.
    } catch (e) {
      // Handle the error.

    }
  }

  // Show the notification.
  void showNotification(RemoteNotification notification) {
    // Create a notification channel.
    // const String channelId = 'default';
    // const String channelName = 'My App Notifications';
    // const NotificationChannel channel = NotificationChannel(
    //   channelId,
    //   channelName,
    //   description: 'Channel description',
    //   importance: Importance.max,
    // );
    //
    // // Create a notification.
    // Notification notification = Notification(
    //   title: notification.title,
    //   body: notification.body,
    //   channel: channel,
    // );
    //
    // // Show the notification.
    // FirebaseMessaging.instance.show(notification);
  }
}
