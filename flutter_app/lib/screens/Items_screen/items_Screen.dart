import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_signin/constants.dart';
import '../../models/item_Model/itemApi.dart';
import '../../models/item_Model/item_model.dart';
import 'item_details_screen.dart';

class ItemsScreen extends StatefulWidget {
  static String routeNeme = "/items_Screen";
  final String categoryName;
  final int categoryId;

  const ItemsScreen({
    Key? key,
    required this.categoryName,
    required this.categoryId,
  }) : super(key: key);

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  late Future<List<Item>> items;
  final ItemAPI itemAPI = ItemAPI(baseUrl: baseUrl);

  @override
  void initState() {
    super.initState();
    items = widget.categoryId == 0
        ? itemAPI.getItems()
        : itemAPI.getItemsByCategoryId(widget.categoryId);
  }

  // استخراج الصورة من JSON
  dynamic _getImageSource(String imagesJson) {
    try {
      List<dynamic> imageList = jsonDecode(imagesJson);
      if (imageList.isNotEmpty) {
        String imagePath = imageList.first.toString().trim();

        if (imagePath.startsWith('http')) {
          return imagePath; // صورة من الإنترنت
        } else if (imagePath.startsWith('/data') ||
            imagePath.startsWith('/storage')) {
          return File(imagePath); // صورة من الهاتف
        } else {
          try {
            return base64Decode(imagePath); // صورة Base64
          } catch (_) {}
        }
      }
    } catch (_) {}
    return 'assets/img/hints.png'; // صورة افتراضية عند الفشل
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: kSecondaryColor),
          backgroundColor: kPrimaryColor,
          title: Text(
            widget.categoryName,
            style: const TextStyle(color: kSecondaryColor),
          ),
        ),
        body: FutureBuilder<List<Item>>(
          future: items,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('خطأ: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('لا توجد عناصر لهذه الفئة'));
            }

            final itemsList = snapshot.data!;

            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.75,
              ),
              itemCount: itemsList.length,
              itemBuilder: (context, index) {
                final item = itemsList[index];
                final imageSource = _getImageSource(item.images);

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ItemDetailScreen(
                            item: item), // الانتقال إلى شاشة التفاصيل
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.grey[100],
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(15)),
                            child: imageSource is String &&
                                    imageSource.startsWith('http')
                                ? Image.network(imageSource,
                                    fit: BoxFit.cover, width: double.infinity)
                                : imageSource is File
                                    ? Image.file(imageSource,
                                        fit: BoxFit.cover,
                                        width: double.infinity)
                                    : imageSource is Uint8List
                                        ? Image.memory(imageSource,
                                            fit: BoxFit.cover,
                                            width: double.infinity)
                                        : Image.asset(imageSource,
                                            fit: BoxFit.cover,
                                            width: double.infinity),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            item.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            '${item.pricePerDay} ريال/يوم',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
