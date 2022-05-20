import 'dart:convert';

NotificationData notificationFromJson(String str) => NotificationData.fromJson(json.decode(str));

String notificationToJson(NotificationData data) => json.encode(data.toJson());

class NotificationData {
  NotificationData({
    this.date,
    this.route,
    this.notificationId,
    this.title,
    this.body,
    this.chatId,
  });

  String? date;
  String? route;
  String? notificationId;
  String? title;
  String? body;
  String? chatId;

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
    date: json["date"],
    route: json["route"],
    notificationId: json["notification_id"],
    title: json["title"],
    body: json["body"],
    chatId: json["chat_id"],
  );

  Map<String, dynamic> toJson() => {
    "date": date ,
    "route": route,
    "notification_id": notificationId,
    "title": title,
    "body": body,
    "chat_id": chatId,
  };
}
