// class NotificationModel {
//   final String id;
//   final String title;
//   final String body;
//   final String createdAt;

//   NotificationModel({
//     required this.id,
//     required this.title,
//     required this.body,
//     required this.createdAt,
//   });

//   // دالة لتحويل البيانات إلى كائن NotificationModel
//   factory NotificationModel.fromJson(Map<String, dynamic> json) {
//     return NotificationModel(
//       id: json['id'].toString(),
//       title: json['data']['title_ar'] ??
//           json['data']['title_en'] ??
//           'إشعار جديد', // التحقق من العنوان باللغة العربية أو الإنجليزية
//       body: json['data']['message_ar'] ??
//           json['data']['message_en'] ??
//           '', // نفس الشيء للجسم
//       createdAt: json['created_at'],
//     );
//   }
// }
class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    // تحقق من وجود الحقل `message` واستخراج قيمته إذا كان موجودًا
    String title =
        json['data']['title_ar'] ?? json['data']['title_en'] ?? 'إشعار جديد';
    String body = json['data']['message_ar'] ??
        json['data']['message_en'] ??
        json['data']['message'] ??
        '';

    return NotificationModel(
      id: json['id'].toString(),
      title: title,
      body: body,
      createdAt: json['created_at'],
    );
  }
}
