// class Item {
//   final int? id;
//   final String name;
//   final String description;
//   final String images;
//   final String status;
//   final bool available;
//   final String location;
//   //final String gpsLocation;
//   final double priceAssurance;
//   final String deliveryMethod;
//   final double pricePerHour;
//   final double pricePerDay;
//   final int quantity;
//   final int minRentalDuration;
//   final int maxRentalDuration;
//   final int availabilityHours;
//   final int userId;
//   final int categoryId;

//   Item({
//     this.id,
//     required this.name,
//     required this.description,
//     required this.images,
//     required this.status,
//     required this.available,
//     required this.location,
//     //required this.gpsLocation,
//     required this.priceAssurance,
//     required this.deliveryMethod,
//     required this.pricePerHour,
//     required this.pricePerDay,
//     required this.quantity,
//     required this.minRentalDuration,
//     required this.maxRentalDuration,
//     required this.availabilityHours,
//     required this.userId,
//     required this.categoryId,
//   });

//   // تحويل JSON إلى كائن Item
//   // factory Item.fromJson(Map<String, dynamic> json) {
//   //   return Item(
//   //     id: json['id'],
//   //     name: json['name'],
//   //     description: json['description'],
//   //     images: json['images'],
//   //     status: json['status'],
//   //     available: json['available'] == 1,
//   //     location: json['location'],
//   //     gpsLocation: json['GPS_location'],
//   //     priceAssurance: double.parse(json['price_assurance'].toString()),
//   //     deliveryMethod: json['delivery_method'],
//   //     pricePerHour: double.parse(json['price_per_hour'].toString()),
//   //     pricePerDay: double.parse(json['price_per_day'].toString()),
//   //     quantity: json['quantity'],
//   //     minRentalDuration: json['min_rental_duration'],
//   //     maxRentalDuration: json['max_rental_duration'],
//   //     availabilityHours: json['availability_hours'],
//   //     userId: json['user_id'],
//   //     categoryId: json['category_id'],
//   //   );
//   // }
//   factory Item.fromJson(Map<String, dynamic> json) {
//     return Item(
//       id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
//       name: json['name'] ?? '', // افتراضي: نص فارغ
//       description: json['description'] ?? '', // افتراضي: نص فارغ
//       images: json['images'] ?? '', // افتراضي: نص فارغ
//       status: json['status'] ?? '', // افتراضي: نص فارغ
//       available:
//           json['available'] == 1 || json['available'] == true, // افتراضي: false
//       location: json['location'] ?? '', // افتراضي: نص فارغ
//       //location: json['GPS_location'] ?? '', // افتراضي: نص فارغ
//       priceAssurance:
//           double.tryParse(json['price_assurance']?.toString() ?? '0') ??
//               0.0, // افتراضي: 0.0
//       deliveryMethod: json['delivery_method'] ?? '', // افتراضي: نص فارغ
//       pricePerHour:
//           double.tryParse(json['price_per_hour']?.toString() ?? '0') ??
//               0.0, // افتراضي: 0.0
//       pricePerDay: double.tryParse(json['price_per_day']?.toString() ?? '0') ??
//           0.0, // افتراضي: 0.0
//       quantity: json['quantity'] != null
//           ? int.tryParse(json['quantity'].toString()) ?? 0
//           : 0, // افتراضي: 0
//       minRentalDuration: json['min_rental_duration'] != null
//           ? int.tryParse(json['min_rental_duration'].toString()) ?? 0
//           : 0, // افتراضي: 0
//       maxRentalDuration: json['max_rental_duration'] != null
//           ? int.tryParse(json['max_rental_duration'].toString()) ?? 0
//           : 0, // افتراضي: 0
//       availabilityHours: json['availability_hours'] ?? '', // افتراضي: نص فارغ
//       userId: json['user_id'] != null
//           ? int.tryParse(json['user_id'].toString()) ?? 0
//           : 0, // افتراضي: 0
//       categoryId: json['category_id'] != null
//           ? int.tryParse(json['category_id'].toString()) ?? 0
//           : 0, // افتراضي: 0
//     );
//   }

//   get imageUrl => null;

//   // تحويل كائن Item إلى JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'description': description,
//       'images': images,
//       'status': status,
//       'available': available ? 1 : 0,
//       'location': location,
//       //'GPS_location': gpsLocation,
//       'price_assurance': priceAssurance,
//       'delivery_method': deliveryMethod,
//       'price_per_hour': pricePerHour,
//       'price_per_day': pricePerDay,
//       'quantity': quantity,
//       'min_rental_duration': minRentalDuration,
//       'max_rental_duration': maxRentalDuration,
//       'availability_hours': availabilityHours,
//       'user_id': userId,
//       'category_id': categoryId,
//     };
//   }
// }
class Item {
  final int? id;
  final String name;
  final String description;
  final String images;
  final String status;
  final bool available;
  final String location;
  final double priceAssurance;
  final String deliveryMethod;
  final double pricePerHour;
  final double pricePerDay;
  final int quantity;
  final int minRentalDuration;
  final int maxRentalDuration;
  final int availabilityHours;
  final int userId;
  final int categoryId;
  final bool adminApproval;

  Item({
    this.id,
    required this.name,
    required this.description,
    required this.images,
    required this.status,
    required this.available,
    required this.location,
    required this.priceAssurance,
    required this.deliveryMethod,
    required this.pricePerHour,
    required this.pricePerDay,
    required this.quantity,
    required this.minRentalDuration,
    required this.maxRentalDuration,
    required this.availabilityHours,
    required this.userId,
    required this.categoryId,
    required this.adminApproval, // القيمة الافتراضية 0
  });

  // دالة copyWith لتحديث الخصائص الجزئية
  Item copyWith({
    int? id,
    String? name,
    String? description,
    String? images,
    String? status,
    bool? available,
    String? location,
    double? priceAssurance,
    String? deliveryMethod,
    double? pricePerHour,
    double? pricePerDay,
    int? quantity,
    int? minRentalDuration,
    int? maxRentalDuration,
    int? availabilityHours,
    int? userId,
    int? categoryId,
    bool? adminApproval,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      images: images ?? this.images,
      status: status ?? this.status,
      available: available ?? this.available,
      location: location ?? this.location,
      priceAssurance: priceAssurance ?? this.priceAssurance,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      pricePerHour: pricePerHour ?? this.pricePerHour,
      pricePerDay: pricePerDay ?? this.pricePerDay,
      quantity: quantity ?? this.quantity,
      minRentalDuration: minRentalDuration ?? this.minRentalDuration,
      maxRentalDuration: maxRentalDuration ?? this.maxRentalDuration,
      availabilityHours: availabilityHours ?? this.availabilityHours,
      userId: userId ?? this.userId,
      categoryId: categoryId ?? this.categoryId,
      adminApproval: adminApproval ?? this.adminApproval,
    );
  }

  // دالة fromJson لتحويل JSON إلى كائن Item
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      images: json['images'] ?? '',
      status: json['status'] ?? '',
      available: json['available'] == 1 || json['available'] == true,
      location: json['location'] ?? '',
      priceAssurance:
          double.tryParse(json['price_assurance']?.toString() ?? '0') ?? 0.0,
      deliveryMethod: json['delivery_method'] ?? '',
      pricePerHour:
          double.tryParse(json['price_per_hour']?.toString() ?? '0') ?? 0.0,
      pricePerDay:
          double.tryParse(json['price_per_day']?.toString() ?? '0') ?? 0.0,
      quantity: json['quantity'] != null
          ? int.tryParse(json['quantity'].toString()) ?? 0
          : 0,
      minRentalDuration: json['min_rental_duration'] != null
          ? int.tryParse(json['min_rental_duration'].toString()) ?? 0
          : 0,
      maxRentalDuration: json['max_rental_duration'] != null
          ? int.tryParse(json['max_rental_duration'].toString()) ?? 0
          : 0,
      availabilityHours: json['availability_hours'] != null
          ? int.tryParse(json['availability_hours'].toString()) ?? 0
          : 0,
      userId: json['user_id'] != null
          ? int.tryParse(json['user_id'].toString()) ?? 0
          : 0,
      categoryId: json['category_id'] != null
          ? int.tryParse(json['category_id'].toString()) ?? 0
          : 0,
      adminApproval: json['admin_approval'] == 1 ||
          json['admin_approval'] == true, // تحويل إلى bool
    );
  }

  // دالة toJson لتحويل الكائن إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'images': images,
      'status': status,
      'available': available ? 1 : 0,
      'location': location,
      'price_assurance': priceAssurance,
      'delivery_method': deliveryMethod,
      'price_per_hour': pricePerHour,
      'price_per_day': pricePerDay,
      'quantity': quantity,
      'min_rental_duration': minRentalDuration,
      'max_rental_duration': maxRentalDuration,
      'availability_hours': availabilityHours,
      'user_id': userId,
      'category_id': categoryId,
      'admin_approval': adminApproval ? 1 : 0, // تحويل إلى int عند الإرسال
    };
  }

  // دالة fromMap لتحويل البيانات القادمة من قاعدة البيانات إلى كائن Item
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      images: map['images'],
      status: map['status'],
      available: map['available'] == 1, // تحويل من `int` إلى `bool`
      location: map['location'],
      priceAssurance: (map['priceAssurance'] as num).toDouble(),
      deliveryMethod: map['deliveryMethod'],
      pricePerHour: (map['pricePerHour'] as num).toDouble(),
      pricePerDay: (map['pricePerDay'] as num).toDouble(),
      quantity: map['quantity'],
      minRentalDuration: map['minRentalDuration'],
      maxRentalDuration: map['maxRentalDuration'],
      availabilityHours: map['availabilityHours'],
      userId: map['userId'],
      categoryId: map['categoryId'],
      adminApproval: map['admin_approval'] == 1 ||
          map['admin_approval'] == true, // تحويل إلى bool
    );
  }

  // دالة toMap لتحويل الكائن إلى Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'images': images,
      'status': status,
      'available': available ? 1 : 0,
      'location': location,
      'priceAssurance': priceAssurance,
      'deliveryMethod': deliveryMethod,
      'pricePerHour': pricePerHour,
      'pricePerDay': pricePerDay,
      'quantity': quantity,
      'minRentalDuration': minRentalDuration,
      'maxRentalDuration': maxRentalDuration,
      'availabilityHours': availabilityHours,
      'userId': userId,
      'categoryId': categoryId,
      'admin_approval': adminApproval ? 1 : 0, // تحويل إلى int عند الحفظ
    };
  }
}
