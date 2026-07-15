import 'package:flutter/material.dart';
import '../../core/APIService.dart';
import '../../models/item_Model/item_model.dart';

import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';

import '../Items_screen/item_details_screen.dart';

class SearchResultsScreen extends StatefulWidget {
  static String routeNeme = "/search_screen";

  final String query;

  const SearchResultsScreen({Key? key, required this.query}) : super(key: key);

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  late Future<List<Item>> _searchResults;

  @override
  void initState() {
    super.initState();
    _searchResults = APIService().searchItems(widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text("نتائج البحث")),
        body: FutureBuilder<List<Item>>(
          future: _searchResults,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('خطأ في جلب نتائج البحث: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('لا توجد نتائج مطابقة'));
            }

            final items = snapshot.data!;
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return _ProductItem(
                  imagesJson: item.images,
                  title: item.name,
                  price: '${item.pricePerDay} ريال/يوم',
                  item: item,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

dynamic _getImageSource(String imagesJson) {
  try {
    List<dynamic> imageList = jsonDecode(imagesJson);
    if (imageList.isNotEmpty) {
      String imagePath = imageList.first.toString().trim();
      if (imagePath.startsWith('http')) {
        return imagePath;
      } else if (imagePath.startsWith('/data') ||
          imagePath.startsWith('/storage')) {
        return File(imagePath);
      } else {
        try {
          return base64Decode(imagePath);
        } catch (e) {
          print('❌ خطأ في فك تشفير Base64: $e');
        }
      }
    }
  } catch (e) {
    print('❌ خطأ في تحليل JSON: $e');
  }
  return 'assets/img/hints.png';
}

class _ProductItem extends StatelessWidget {
  final String imagesJson;
  final String title;
  final String price;
  final Item item;

  const _ProductItem({
    required this.imagesJson,
    required this.title,
    required this.price,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    dynamic imageSource = _getImageSource(imagesJson);

    Widget imageWidget;
    if (imageSource is String && imageSource.startsWith('http')) {
      imageWidget = Image.network(imageSource, fit: BoxFit.cover);
    } else if (imageSource is File) {
      imageWidget = Image.file(imageSource, fit: BoxFit.cover);
    } else if (imageSource is Uint8List) {
      imageWidget = Image.memory(imageSource, fit: BoxFit.cover);
    } else {
      imageWidget = Image.asset('assets/img/hints.png', fit: BoxFit.cover);
    }

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            ItemDetailScreen.routeNeme,
            arguments: item,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 120,
                height: 100,
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: imageWidget,
              ),
            ),
            SizedBox(height: 8),
            Text(title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            Text(price, style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
