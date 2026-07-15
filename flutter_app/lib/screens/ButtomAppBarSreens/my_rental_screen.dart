// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_signin/componenets/defualt_button.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../componenets/customBottomAppBar.dart';
import '../../constants.dart';
import '../../models/RentalRequest_model.dart';
import 'package:intl/intl.dart'; // استيراد المكتبة

class MyRentalScreen extends StatefulWidget {
  const MyRentalScreen({super.key});
  static String routeName = "/MyRentalScreen";

  @override
  State<MyRentalScreen> createState() => _MyRentalScreenState();
}

class _MyRentalScreenState extends State<MyRentalScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<RentalRequest> rentalRequests = [];

  int userId = 0; // استبدل بـ ID المستخدم الفعلي

  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadUserId(); // جلب userId الحقيقي
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('user_id') ?? 0; // تعيين معرف المستخدم الفعلي
    });
    fetchRentalRequests(); // جلب طلبات الإيجار بعد الحصول على userId
  }

  // جلب طلبات الإيجار من API
  Future<void> fetchRentalRequests() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/rental-requests'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['data'] is List) {
          List<dynamic> requestsList = responseData['data'];
          List<RentalRequest> tempRequests = [];

          List<Future<RentalRequest>> itemFutures =
              requestsList.map((jsonRequest) async {
            RentalRequest request = RentalRequest.fromJson(jsonRequest);

            try {
              final itemResponse =
                  await http.get(Uri.parse('$baseUrl/items/${request.itemId}'));

              if (itemResponse.statusCode == 200) {
                final itemData = json.decode(itemResponse.body);
                request = request.copyWith(
                  itemName: itemData['name'],
                  ownerId: itemData[
                      'user_id'], // 🔹 استخدام `user_id` كمعرف لصاحب الغرض
                );
              }
            } catch (e) {
              print("خطأ في جلب تفاصيل الغرض: $e");
            }

            return request;
          }).toList();

          tempRequests = await Future.wait(itemFutures);

          setState(() {
            rentalRequests = tempRequests;
          });
        }
      } else {
        print("فشل في تحميل طلبات الإيجار، الحالة: ${response.statusCode}");
      }
    } catch (e) {
      print("خطأ أثناء جلب طلبات الإيجار: $e");
    }
  }

  // تحديث حالة الطلب
  Future<void> updateRequestStatus(int requestId, String status) async {
    final url = "$baseUrl/rental-requests/$requestId";
    final response = await http.put(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"status": status}),
    );

    if (response.statusCode == 200) {
      setState(() {
        rentalRequests = rentalRequests.map((request) {
          if (request.id == requestId) {
            // استخدم copyWith لتحديث الحالة
            return request.copyWith(status: status);
          }
          return request;
        }).toList();
      });
    } else {
      print("فشل تحديث الحالة");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            "إيجاراتي",
            style: TextStyle(color: kSecondaryColor),
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // 🔹 TabBar
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: kPrimaryColor,
              tabs: const [
                Tab(text: "أنا مستأجر"),
                Tab(text: "أنا مؤجر"),
              ],
            ),
          ),
          // 🔹 TabBarView
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // ✅ تبويب "أنا مستأجر"
                _buildRentalRequestsList(
                  rentalRequests.where((req) => req.userId == userId).toList(),
                ),
                // ✅ تبويب "أنا مؤجر"
                _buildLessorRequests(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: customBottomAppBar(currentIndex: 1),
      floatingActionButton: defaultFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  // 🔹 بناء قائمة طلبات المستخدم كمستأجر

// 🔹 عرض تفاصيل الطلب في نافذة من الأسفل
  void _showRequestDetails(RentalRequest request) {
    double totalAmount =
        (_tabController.index == 1) ? request.amount - 500 : request.amount;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: 500,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "تفاصيل الطلب",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor),
              ),
              SizedBox(height: 10),
              Text(
                "الغرض: ${request.itemName}",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Text(
                "الحالة: ${_getStatusText(request.status)}",
                style: TextStyle(fontSize: 18, color: kPrimaryColor),
              ),
              SizedBox(height: 10),
              Text(
                "تاريخ البداية: ${DateFormat('d MMM yyyy').format(request.startDate)}",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              if (request.endDate != null)
                Text(
                  "تاريخ النهاية: ${DateFormat('d MMM yyyy').format(request.endDate!)}",
                  style: TextStyle(fontSize: 18),
                ),
              SizedBox(height: 20),
              Text(
                "المبلغ الإجمالي: ${totalAmount.toStringAsFixed(2)} ريال",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              DefualtBotton(
                text: "إغلاق",
                press: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        );
      },
    );
  }

  // 🔹 بناء قائمة الطلبات التي استلمها المستخدم كمؤجر
  // 🔹 بناء قائمة طلبات المستخدم كمستأجر
  Widget _buildRentalRequestsList(List<RentalRequest> requests) {
    if (requests.isEmpty) {
      return Center(
        child: Text("لا يوجد طلبات إيجار حاليًا",
            style: TextStyle(color: Colors.grey)),
      );
    }

    return ListView.builder(
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final request = requests.reversed.toList()[index]; // عكس الترتيب

        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: Card(
            color: Colors.grey[100],
            elevation: 2,
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "الغرض: ${request.itemName}",
                    textAlign: TextAlign.right,
                  )),
              subtitle: Row(
                children: [
                  _getStatusIcon(
                      request.status), // استدعاء الأيقونة مع اللون المناسب
                  SizedBox(width: 5),
                  Text(
                    "الحالة: ${_getStatusText(request.status)}",
                    style: TextStyle(color: kPrimaryColor, fontSize: 20),
                  ),
                ],
              ),
              onTap: () => _showRequestDetails(
                  request), // عند الضغط على الطلب يعرض التفاصيل
            ),
          ),
        );
      },
    );
  }

// 🔹 بناء قائمة الطلبات التي استلمها المستخدم كمؤجر
  Widget _buildLessorRequests() {
    final lessorRequests = rentalRequests
        .where((req) => req.ownerId == userId)
        .toList(); // 🔹 التصفية بناءً على صاحب الغرض

    if (lessorRequests.isEmpty) {
      return Center(
        child: Text("لا يوجد طلبات من المستأجرين",
            style: TextStyle(color: Colors.grey)),
      );
    }

    return ListView.builder(
      itemCount: lessorRequests.length,
      itemBuilder: (context, index) {
        final request = lessorRequests.reversed.toList()[index]; // عكس الترتيب

        return Padding(
          padding: EdgeInsets.all(2.0),
          child: Card(
            color: Colors.grey[100],
            elevation: 2,
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "طلب إيجار: ${request.itemName}",
                    textAlign: TextAlign.right,
                  )),
              subtitle: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _getStatusIcon(
                        request.status), // استدعاء الأيقونة مع اللون المناسب
                    SizedBox(width: 5),
                    // Text(
                    //   "الحالة: ${_getStatusText(request.status)}",
                    //   style: TextStyle(color: kPrimaryColor, fontSize: 20),
                    // ),
                    // SizedBox(width: 5),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "لتاريخ: ${DateFormat('d MMM yyyy').format(request.startDate)} إلى : ${request.endDate != null ? DateFormat('d MMM yyyy').format(request.endDate!) : 'غير محدد'}",
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
              trailing: SizedBox(
                width: 100,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (request.status == 'pending') ...[
                      IconButton(
                        icon: Icon(Icons.check_circle,
                            color: Colors.green, size: 33),
                        onPressed: () =>
                            updateRequestStatus(request.id, 'approved'),
                      ),
                      IconButton(
                        icon: Icon(Icons.cancel, color: Colors.red, size: 33),
                        onPressed: () =>
                            updateRequestStatus(request.id, 'rejected'),
                      ),
                    ] else
                      Text(_getStatusText(request.status)),
                  ],
                ),
              ),
              onTap: () => _showRequestDetails(
                  request), // عند الضغط على الطلب يعرض التفاصيل
            ),
          ),
        );
      },
    );
  }

// 🔹 تحويل الحالة إلى نص
  String _getStatusText(String status) {
    switch (status) {
      case 'pending':
        return 'قيد الانتظار';
      case 'approved':
        return 'موافق عليه';
      case 'rejected':
        return 'مرفوض';
      default:
        return 'غير معروف';
    }
  }

// 🔹 تحويل الحالة إلى أيقونة
  // 🔹 تحويل الحالة إلى أيقونة مع اللون
  Icon _getStatusIcon(String status) {
    switch (status) {
      case 'pending':
        return Icon(
          Icons.hourglass_empty, // أيقونة الانتظار
          color: Colors.amber, // لون رمادي
          size: 20,
        );
      case 'approved':
        return Icon(
          Icons.check_circle, // أيقونة الموافقة
          color: Colors.green, // لون أخضر
          size: 20,
        );
      case 'rejected':
        return Icon(
          Icons.cancel, // أيقونة الرفض
          color: Colors.red, // لون أحمر
          size: 20,
        );
      default:
        return Icon(
          Icons.help_outline, // أيقونة الحالة غير المعروفة
          color: Colors.black, // لون أسود
          size: 20,
        );
    }
  }
}
