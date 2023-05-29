import 'dart:convert';

class NotificationMessage {
  String? message;
  String? title;
  NotificationMessage({
    this.message,
    this.title,
  });

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'title': title,
    };
  }

  factory NotificationMessage.fromMap(Map<String, dynamic> map) {
    return NotificationMessage(
      message: map['message'],
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationMessage.fromJson(String source) =>
      NotificationMessage.fromMap(json.decode(source));

  @override
  String toString() => 'NotificationMessage(message: $message, title: $title)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationMessage &&
        other.message == message &&
        other.title == title;
  }

  @override
  int get hashCode => message.hashCode ^ title.hashCode;
}
