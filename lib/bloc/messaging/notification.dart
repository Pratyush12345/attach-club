// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/material.dart';

// class Notify{
//   static Future<bool> instantNotify() async{

//    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
//   if (!isAllowed) {
//     // This is just a basic example. For real apps, you must show some
//     // friendly dialog box before call the request method.
//     // This is very important to not harm the user experience
//     AwesomeNotifications().requestPermissionToSendNotifications();
//   }
//   });
 
//    return AwesomeNotifications().createNotification(
//       content: NotificationContent(
//       id: 10,
//       channelKey: 'instant',
//       actionType: ActionType.Default,
//       title: 'Hello World!',
//       body: 'This is my first notification!',
      
//      )
//   );
//   }

   
   
//   static Future<bool> instantNotifyImage({@required String? bigpicture}) async{

//    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
//   if (!isAllowed) {
//     // This is just a basic example. For real apps, you must show some
//     // friendly dialog box before call the request method.
//     // This is very important to not harm the user experience
//     AwesomeNotifications().requestPermissionToSendNotifications();
//   }
//   });
 
//    return AwesomeNotifications().createNotification(
//       content: NotificationContent(
//       id: 10,
//       channelKey: 'instant',
//       actionType: ActionType.Default,
//       title: 'Image Downloaded',
//       body: 'Image downloaded in storage.',
//       // bigPicture: bigpicture,
//       // notificationLayout: NotificationLayout.BigPicture,
      
      
//      ),
//      actionButtons: [
//         NotificationActionButton(
//             key: 'SHOW_IMAGE',
//             label: 'Show image'
//         )
//       ]
//   );
//   }
// }





