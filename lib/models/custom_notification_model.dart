class CustomerNotification {
  String title;
  String message;
  String sound;

  CustomerNotification(
      {required this.title, required this.message, required this.sound});

  factory CustomerNotification.fromJson(Map<String, dynamic> json) {
    return CustomerNotification(
      title: json['notification']['title'],
      message: json['notification']['body'],
      sound: json['notification']['sound'],
    );
  }
}
