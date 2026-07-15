// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_signin/componenets/defualt_button.dart';
import 'package:flutter_signin/constants.dart';

import '../../models/item_Model/item_model.dart';
import '../Rental_screens/rentalRequest_screen.dart';

class ItemDetailScreen extends StatefulWidget {
  static const routeNeme = "/item_details_screen";
  final Item item;

  const ItemDetailScreen({Key? key, required this.item}) : super(key: key);

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  bool isRented = false;
  String ownerName = "جاري التحميل...";
  String? ownerAvatar;

  @override
  void initState() {
    super.initState();
    fetchRentalRequests();
    fetchOwnerDetails();
  }

  /// ✅ جلب بيانات صاحب الغرض (الاسم وصورة البروفايل)
  Future<void> fetchOwnerDetails() async {
    final url =
        "$baseUrl/users/${widget.item.userId}"; // API جلب بيانات المستخدم
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        ownerName = data['name'];
        ownerAvatar = data['avatar']; // رابط صورة البروفايل
      });
    }
  }

  Future<void> fetchRentalRequests() async {
    final url = "$baseUrl/items/${widget.item.id}/rental_requests";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> rentalRequests = jsonDecode(response.body);
      final today = DateTime.now();

      bool rented = rentalRequests.any((request) {
        DateTime startDate = DateTime.parse(request['start_date']);
        DateTime endDate = DateTime.parse(request['end_date']);
        return today.isAfter(startDate) && today.isBefore(endDate);
      });

      setState(() {
        isRented = rented;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> images = _getImageSource(widget.item.images);
    print("صور الغرض: ${widget.item.images}");

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: kSecondaryColor),
          title:
              Text(widget.item.name, style: TextStyle(color: kSecondaryColor)),
          backgroundColor: kPrimaryColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ✅ عرض صور الغرض
                Container(
                  height: 250,
                  child: images.length == 1
                      ? _buildImageWidget(images.first)
                      : PageView.builder(
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: _buildImageWidget(images[index]),
                            );
                          },
                        ),
                ),
                SizedBox(height: 16),

                // ✅ عرض بيانات صاحب الغرض
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => PublicProfileScreen(),
                //       ),
                //     );
                //   },
                //   child: Row(
                //     children: [
                //       CircleAvatar(
                //         radius: 25,
                //         backgroundImage: ownerAvatar != null
                //             ? NetworkImage(ownerAvatar!)
                //             : AssetImage("assets/img/hints.png")
                //                 as ImageProvider,
                //       ),
                //       SizedBox(width: 10),
                //       Text(
                //         ownerName,
                //         style: TextStyle(
                //             fontSize: 18, fontWeight: FontWeight.bold),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: 10),

                // ✅ حالة التوفر
                _buildStatusContainer(
                    widget.item.adminApproval ? "متاح" : "غير متاح",
                    widget.item.adminApproval ? Colors.green : Colors.red),

                SizedBox(height: 8),

                // ✅ حالة الإيجار
                // _buildStatusContainer(isRented ? "مؤجر" : "غير مؤجر",
                //     isRented ? Colors.red : Colors.green),

                SizedBox(height: 8),

                // ✅ تفاصيل الغرض
                _buildItemDetails(),

                SizedBox(height: 16),

                // ✅ زر "طلب استئجار"
                Opacity(
                  opacity: widget.item.adminApproval ? 1.0 : 0.5,
                  child: DefualtBotton(
                    text: 'طلب استئجار',
                    press: widget.item.adminApproval
                        ? () {
                            Navigator.pushNamed(
                              context,
                              RentalRequestScreen.routeName,
                              arguments: widget.item,
                            );
                          }
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// ✅ عنصر واجهة لحالة التوفر أو الإيجار
  Widget _buildStatusContainer(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Text(text,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }

  /// ✅ تفاصيل الغرض
  Widget _buildItemDetails() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildInfoTile("الاسم", widget.item.name),
            _buildInfoTile("الوصف", widget.item.description),
            _buildInfoTile("الموقع", widget.item.location),
            _buildInfoTile("الضمان", "${widget.item.priceAssurance} ريال"),
            _buildInfoTile(
                "السعر بالساعة",
                widget.item.pricePerHour != null
                    ? "${widget.item.pricePerHour} ريال"
                    : "غير متاح"),
            _buildInfoTile("السعر باليوم", "${widget.item.pricePerDay} ريال"),
            _buildInfoTile("الكمية المتوفرة", "${widget.item.quantity}"),
            _buildInfoTile("الحالة", _getStatusText(widget.item.status)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Card(
        color: Colors.grey[200],
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(value, style: TextStyle(fontSize: 16)),
        ),
      ),
    );
  }

  /// ✅ استخراج الصور
  // List<dynamic> _getImageSource(String imagesJson) {
  //   try {
  //     return jsonDecode(imagesJson);
  //   } catch (e) {
  //     return ['assets/img/hints.png'];
  //   }
  // }
  List<dynamic> _getImageSource(dynamic imagesData) {
    if (imagesData is String) {
      try {
        return jsonDecode(imagesData); // تحويل النص إلى قائمة
      } catch (e) {
        return ['assets/img/hints.png']; // صورة افتراضية
      }
    } else if (imagesData is List) {
      return imagesData; // إذا كان بالفعل قائمة
    } else {
      return ['assets/img/hints.png'];
    }
  }

  /// ✅ بناء ويدجت الصورة
  // Widget _buildImageWidget(dynamic imageSource) {
  //   if (imageSource is String && imageSource.startsWith('http')) {
  //     return Image.network(imageSource,
  //         fit: BoxFit.cover, width: double.infinity);
  //   } else {
  //     return Image.asset('assets/img/hints.png',
  //         fit: BoxFit.cover, width: double.infinity);
  //   }
  // }

  Widget _buildImageWidget(dynamic imageSource) {
    if (imageSource is String) {
      if (imageSource.startsWith('http')) {
        // ✅ الصورة من الإنترنت
        return Image.network(
          imageSource,
          fit: BoxFit.cover,
          width: double.infinity,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset('assets/img/hints.png', fit: BoxFit.cover);
          },
        );
      } else {
        try {
          // ✅ الصورة بصيغة Base64
          Uint8List bytes = base64Decode(imageSource);
          return Image.memory(
            bytes,
            fit: BoxFit.cover,
            width: double.infinity,
          );
        } catch (e) {
          return Image.asset('assets/img/hints.png', fit: BoxFit.cover);
        }
      }
    } else {
      return Image.asset('assets/img/hints.png', fit: BoxFit.cover);
    }
  }

  /// ✅ تحويل الحالة إلى نص عربي
  String _getStatusText(String status) {
    switch (status) {
      case 'excellent':
        return 'ممتاز';
      case 'good':
        return 'جيد';
      case 'acceptable':
        return 'مقبول';
      case 'barely used':
        return 'مستعمل بالكاد';
      default:
        return 'غير محدد';
    }
  }
}
