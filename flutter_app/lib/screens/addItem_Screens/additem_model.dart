class Item {
  final int id;
  final String name;
  final String description;
  final List<String> images;
  final String status;
  final double priceAssurance;
  final double pricePerHour;
  final double pricePerDay;
  final int categoryId;
  final String deliveryMethod;
  final String location;
  final int minRentalDuration;
  final int maxRentalDuration;
  final int availabilityHours;
  final int quantity;
  final int userId;
  final bool available;

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
    required this.status,
    required this.priceAssurance,
    required this.pricePerHour,
    required this.pricePerDay,
    required this.categoryId,
    required this.deliveryMethod,
    required this.location,
    required this.minRentalDuration,
    required this.maxRentalDuration,
    required this.availabilityHours,
    required this.quantity,
    required this.userId,
    required this.available,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "images": images,
      "status": status,
      "priceAssurance": priceAssurance,
      "pricePerHour": pricePerHour,
      "pricePerDay": pricePerDay,
      "categoryId": categoryId,
      "deliveryMethod": deliveryMethod,
      "location": location,
      "minRentalDuration": minRentalDuration,
      "maxRentalDuration": maxRentalDuration,
      "availabilityHours": availabilityHours,
      "quantity": quantity,
      "userId": userId,
      "available": available,
    };
  }
}
