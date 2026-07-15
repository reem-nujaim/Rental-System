// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_signin/componenets/DefualtTopContainer.dart';
import '../../componenets/categoryItem.dart';
import '../../componenets/customBottomAppBar.dart';
import '../../componenets/searchbox.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io';
import '../../constants.dart';
import '../../core/APIService.dart';
import '../../models/category_Model/category_model.dart';
import '../../models/item_Model/item_model.dart';

import '../Items_screen/item_details_screen.dart';
import '../Items_screen/items_Screen.dart';
import 'search_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static String routeNeme = "/homepage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  Future<List<Item>>? _searchResults;
  bool _isSearching = false;

  void _onSearchSubmitted(String query) {
    if (query.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultsScreen(query: query),
        ),
      );
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefualtTopAppBar(),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              DefualtTopContainer(text: "مرحبا بك"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    searchbox(
                      hintText: "ابحث عن الغرض",
                      controller: _searchController,
                      onSubmitted: _onSearchSubmitted,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: FutureBuilder<List<Category>>(
                        future: APIService().fetchCategories(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text(
                                    'خطأ في جلب الفئات: ${snapshot.error}'));
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Center(child: Text('لا توجد فئات متاحة'));
                          }
                          final categories = snapshot.data!;
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: categories.map((category) {
                                return Container(
                                  margin: EdgeInsets.all(8),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ItemsScreen(
                                            categoryId: category.id,
                                            categoryName: category.arName,
                                          ),
                                        ),
                                      );
                                    },
                                    child: CategoryItem(
                                      icon: categoryIcons[category.id] ??
                                          Icons.category,
                                      label: category.arName,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    _SectionTitle(
                      title: 'جميع الأغراض',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemsScreen(
                              categoryId: 0,
                              categoryName: 'جميع الأغراض',
                            ),
                          ),
                        );
                      },
                    ),
                    _HorizontalList(categoryId: 0),
                    FutureBuilder<List<Category>>(
                      future: APIService().fetchCategories(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child:
                                  Text('خطأ في جلب الفئات: ${snapshot.error}'));
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(child: Text('لا توجد فئات متاحة'));
                        }
                        final categories = snapshot.data!;
                        return Column(
                          children: categories.map((category) {
                            return Column(
                              children: [
                                _SectionTitle(
                                  title: category.arName,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ItemsScreen(
                                          categoryId: category.id,
                                          categoryName: category.arName,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                _HorizontalList(categoryId: category.id),
                              ],
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              if (_isSearching)
                Container(
                  color: Colors.white.withOpacity(0.9), // خلفية شفافة قليلاً
                  child: _buildSearchResults(),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: customBottomAppBar(currentIndex: 0),
      floatingActionButton: defaultFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildSearchResults() {
    return FutureBuilder<List<Item>>(
      future: _searchResults,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text('خطأ في جلب نتائج البحث: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('لا توجد نتائج بحث متاحة'));
        }

        final items = snapshot.data!;
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
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
    );
  }
}

class _HorizontalList extends StatelessWidget {
  final int categoryId;

  const _HorizontalList({required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: FutureBuilder<List<Item>>(
        future: categoryId == 0
            ? APIService().getItems()
            : APIService().getItemsByCategoryId(categoryId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('خطأ في جلب البيانات: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('لا توجد عناصر متاحة'));
          }
          final items = snapshot.data!;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return _ProductItem(
                imagesJson: item.images, // تمرير النص الذي يحتوي على المسار
                title: item.name,
                price: '${item.pricePerDay} ريال/يوم',
                item: item, // تمرير الـ item هنا
              );
            },
          );
        },
      ),
    );
  }
}

dynamic _getImageSource(String imagesJson) {
  try {
    List<dynamic> imageList = jsonDecode(imagesJson);
    if (imageList.isNotEmpty) {
      String imagePath = imageList.first.toString().trim();
      print("📸 مسار الصورة: $imagePath");

      if (imagePath.startsWith('http')) {
        return imagePath; // الصورة من الإنترنت
      } else if (imagePath.startsWith('/data') ||
          imagePath.startsWith('/storage')) {
        return File(imagePath); // الصورة مسار محلي في الجهاز
      } else {
        try {
          return base64Decode(imagePath); // الصورة Base64
        } catch (e) {
          print('❌ خطأ في فك تشفير Base64: $e');
        }
      }
    }
  } catch (e) {
    print('❌ خطأ في تحليل JSON: $e');
  }
  return 'assets/img/hints.png'; // صورة افتراضية عند الفشل
}

final Map<int, IconData> categoryIcons = {
  1: Icons.videogame_asset, // الإلكترونيات
  2: Icons.checkroom, // السيارات
  3: Icons.chair, // الرياضة
  4: Icons.kitchen, // الأدوات المنزلية
  5: Icons.devices, // الكتب
  6: Icons.directions_car, // الدراجات
  // 7: Icons.videogame_asset, // الألعاب
  // 8: Icons.brush, // الفنون
};

class _ProductItem extends StatelessWidget {
  final String imagesJson;
  final String title;
  final String price;
  final Item item; // إضافة المتغير item

  const _ProductItem({
    required this.imagesJson,
    required this.title,
    required this.price,
    required this.item, // تمرير Item هنا
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
        // إضافة GestureDetector لالتقاط الضغط على الصورة
        onTap: () {
          Navigator.pushNamed(
            context,
            ItemDetailScreen.routeNeme, // الانتقال إلى صفحة تفاصيل الغرض
            arguments: item, // تمرير العنصر إلى شاشة التفاصيل
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

class _SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _SectionTitle({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: titleTextStyle()),
          GestureDetector(
            onTap: onTap,
            child: Text(
              "عرض الكل",
              style: TextStyle(color: kPrimaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
