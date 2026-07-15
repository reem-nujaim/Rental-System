// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_signin/constants.dart';
import 'package:provider/provider.dart';

import '../../core/SharedPreferences/SharedPreferencesHelper.dart';
import '../../provider/reportProvider.dart';

class ReportScreen extends StatefulWidget {
  static const routeName = "/reports_Screen";
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  void initState() {
    super.initState();
    _loadReport();
  }

  Future<void> _loadReport() async {
    final reportProvider = Provider.of<ReportProvider>(context, listen: false);

    // جلب التوكن من SharedPreferences
    String? token = await SharedPrefsHelper().getToken();

    if (token != null) {
      reportProvider.fetchReport(token);
    } else {
      print("⚠️ لم يتم العثور على توكن في SharedPreferences");
    }
  }

  @override
  Widget build(BuildContext context) {
    final reportProvider = Provider.of<ReportProvider>(context);
    final report = reportProvider.report;

    // تعريف خريطة الألوان لكل أيقونة
    final Map<IconData, Color> iconColors = {
      Icons.category: Colors.blue,
      Icons.receipt: Colors.orange,
      Icons.check_circle: Colors.green,
      Icons.cancel: Colors.red,
      Icons.hourglass_empty: Colors.amber,
      Icons.thumb_up: Colors.lightGreen,
      Icons.thumb_down: Colors.purple,
      Icons.timer: Colors.deepOrange,
      Icons.money_off: Colors.brown,
      Icons.attach_money: Colors.teal,
    };

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: kSecondaryColor),
          title: Text('التقارير',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: kSecondaryColor)),
          backgroundColor: kPrimaryColor,
        ),
        body: reportProvider.isLoading
            ? Center(child: CircularProgressIndicator())
            : report == null
                ? Center(child: Text("لا توجد بيانات متاحة"))
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView(
                      children: [
                        buildReportCard(Icons.category, "عدد الأغراض",
                            report.itemsCount.toString(), iconColors),
                        buildReportCard(
                            Icons.receipt,
                            "طلبات الإيجار المستلمة",
                            report.rentalRequestsReceivedCount.toString(),
                            iconColors),
                        buildReportCard(
                            Icons.check_circle,
                            "طلبات الموافقة",
                            report.approvedRequestsCount.toString(),
                            iconColors),
                        buildReportCard(
                            Icons.cancel,
                            "طلبات الرفض",
                            report.rejectedRequestsCount.toString(),
                            iconColors),
                        buildReportCard(Icons.hourglass_empty, "طلبات الانتظار",
                            report.pendingRequestsCount.toString(), iconColors),
                        buildReportCard(
                            Icons.thumb_up,
                            "الإيجارات المقبولة",
                            report.approvedRentalRequestsCount.toString(),
                            iconColors),
                        buildReportCard(
                            Icons.thumb_down,
                            "الإيجارات المرفوضة",
                            report.rejectedRentalRequestsCount.toString(),
                            iconColors),
                        buildReportCard(
                            Icons.timer,
                            "الإيجارات المعلقة",
                            report.pendingRentalRequestsCount.toString(),
                            iconColors),
                        buildReportCard(Icons.money_off, "عدد المتأخرات",
                            report.lateFeesCount.toString(), iconColors),
                        buildReportCard(
                            Icons.attach_money,
                            "إجمالي المتأخرات",
                            "\$${report.totalLateFeesAmount.toStringAsFixed(2)}",
                            iconColors),
                      ],
                    ),
                  ),
      ),
    );
  }

  Widget buildReportCard(IconData icon, String title, String value,
      Map<IconData, Color> iconColors) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon, color: iconColors[icon] ?? kPrimaryColor, size: 30),
        title: Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        trailing:
            Text(value, style: TextStyle(fontSize: 16, color: Colors.black54)),
      ),
    );
  }
}
