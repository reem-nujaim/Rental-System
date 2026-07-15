// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_signin/componenets/defualt_button.dart';
import 'package:flutter_signin/screens/login_screens/signin_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import '../../constants.dart';
import '../../core/SharedPreferences/SharedPreferencesHelper.dart';
import '../../models/item_Model/item_model.dart';
import '../addItem_Screens/components/defualthelpContainer.dart';

class RentalRequestScreen extends StatefulWidget {
  static const routeName = "/rental_request_screen";

  const RentalRequestScreen({super.key});

  @override
  _RentalRequestScreenState createState() => _RentalRequestScreenState();
}

class _RentalRequestScreenState extends State<RentalRequestScreen> {
  late DateTime _startDate;
  late DateTime _endDate;
  String? _paymentMethod;
  String? _deliveryMethod;
  final TextEditingController _transactionNumberController =
      TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  int? userId;
  bool isLoading = true;
  bool isItemLoaded = false;
  List<DateTimeRange> reservedDates = [];
  late Item item;

  @override
  void initState() {
    super.initState();
    _startDate = DateTime.now();
    _endDate = DateTime.now().add(const Duration(days: 1));
    _loadUserId();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isItemLoaded) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null && args is Item) {
        setState(() {
          item = args;
          isItemLoaded = true;
        });
        Future.delayed(const Duration(milliseconds: 100), () {
          if (item.id != null) {
            _fetchReservedDates(item.id!);
          }
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("❌ لم يتم تمرير بيانات الغرض بشكل صحيح")),
        );
        Navigator.pop(context);
      }
    }
  }

  Future<void> _loadUserId() async {
    // إجراء العمل غير المتزامن أولاً
    final userId = await SharedPrefsHelper.getUserId();

    // بعد ذلك، قم بتحديث الحالة باستخدام setState()
    if (userId == null) {
      // في حال كان المستخدم غير مسجل الدخول، اعرض رسالة
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('❌ يرجى تسجيل الدخول أولاً')),
      // );
      // إعادة التوجيه إلى صفحة تسجيل الدخول
      Navigator.of(context).pushReplacementNamed(
        SigninPage.routeNeme,
        arguments: {
          'message': "لا يمكنك استئجار غرض ما ! يجب عليك تسجيل الدخول أولا",
        },
      );
    } else {
      // إذا كان المستخدم مسجلاً الدخول، قم بتحديث الحالة
      setState(() {
        this.userId = userId;
      });
    }
  }

  Future<void> _fetchReservedDates(int itemId) async {
    if (!mounted) return;
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/items/$itemId/reserved-dates'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        if (mounted) {
          setState(() {
            reservedDates = data.map((e) {
              return DateTimeRange(
                start: DateTime.parse(e['start_date']),
                end: DateTime.parse(e['end_date']),
              );
            }).toList();
            isLoading = false;
          });
        }
      } else {
        throw Exception('Failed to load reserved dates');
      }
    } catch (e) {
      print("❌ خطأ في جلب التواريخ المحجوزة: $e");
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> _selectDate(
      BuildContext context, bool isStartDate, int maxRentalDays) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate,
      firstDate: isStartDate
          ? DateTime.now()
          : _startDate.add(const Duration(days: 1)),
      lastDate: isStartDate
          ? DateTime(2101)
          : _startDate.add(Duration(days: maxRentalDays)),
    );

    if (pickedDate != null) {
      // التحقق مما إذا كان التاريخ متداخلًا مع تواريخ محجوزة
      bool isOverlapping = reservedDates.any((range) =>
          pickedDate.isAfter(range.start.subtract(const Duration(days: 1))) &&
          pickedDate.isBefore(range.end.add(const Duration(days: 1))));

      if (isOverlapping) {
        _showErrorDialog(context,
            "⚠️ التاريخ الذي اخترته محجوز مسبقًا، يرجى اختيار تاريخ آخر.");
        return; // إيقاف التحديث
      }

      setState(() {
        if (isStartDate) {
          _startDate = pickedDate;
          if (_endDate.isBefore(_startDate.add(const Duration(days: 1)))) {
            _endDate = _startDate.add(const Duration(days: 1));
          }
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title:
            const Text("تنبيه", style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.warning, color: Colors.red, size: 50),
            const SizedBox(height: 10),
            Text(message, textAlign: TextAlign.center),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("حسناً"),
          ),
        ],
      ),
    );
  }

  double _calculateAmount(double pricePerDay) {
    final duration = _endDate.difference(_startDate).inDays + 1;
    double amount = pricePerDay * duration.toDouble();

    return (duration > 0) ? amount : pricePerDay;
  }

  Future<void> _sendRentalRequest() async {
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('❌ خطأ: لم يتم العثور على معرف المستخدم!')),
      );
      return;
    }

    if (_paymentMethod == null || _deliveryMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('⚠️ يرجى اختيار طريقة الدفع والتوصيل')),
      );
      return;
    }

    if (_deliveryMethod == 'courier' && _locationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('⚠️ يرجى إدخال الموقع عند اختيار التوصيل عبر مندوب')),
      );
      return;
    }

    if (_paymentMethod == 'bank_transfer' &&
        _transactionNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('⚠️ يرجى إدخال رقم الحوالة عند الدفع بالتحويل البنكي')),
      );
      return;
    }

    // التحقق مما إذا كانت الفترة الزمنية متداخلة مع فترة محجوزة مسبقًا
    bool isOverlapping = reservedDates.any((range) =>
        _startDate.isBefore(range.end) && _endDate.isAfter(range.start));

    if (isOverlapping) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                '❌ لا يمكن إرسال الطلب لأن التواريخ متداخلة مع حجز سابق!')),
      );
      return;
    }

    const url = '$baseUrl/rental-requests';
    final headers = {"Content-Type": "application/json"};

    final requestBody = jsonEncode({
      "start_date": DateFormat('yyyy-MM-dd HH:mm:ss').format(_startDate),
      "end_date": DateFormat('yyyy-MM-dd HH:mm:ss').format(_endDate),
      "amount": _calculateAmount(item.pricePerDay),
      "payment_method": _paymentMethod,
      "transaction_number": _paymentMethod == 'bank_transfer'
          ? _transactionNumberController.text
          : null,
      "delivery_method": _deliveryMethod,
      "location":
          _deliveryMethod == 'courier' ? _locationController.text : null,
      "user_id": userId,
      "item_id": item.id,
    });

    try {
      final response =
          await http.post(Uri.parse(url), headers: headers, body: requestBody);

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ تم إرسال طلب الاستئجار بنجاح!')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❌ فشل في إرسال الطلب!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ حدث خطأ أثناء إرسال الطلب!')),
      );
    }
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("تأكيد الطلب"),
          content: const Text(
              "هل أنت متأكد أنك تريد إرسال طلبك؟ لا يمكنك التراجع لاحقًا."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // إغلاق الديالوج
              },
              child: const Text("إلغاء"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // إغلاق الديالوج
                _sendRentalRequest(); // إرسال الطلب بعد التأكيد
              },
              child: const Text("إرسال"),
            ),
          ],
        );
      },
    );
  }

  // دالة لعرض الفاتورة في الديالوج
  void _showInvoiceDialog() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        double rentalAmount = _calculateAmount(item.pricePerDay);
        double insuranceAmount = item.priceAssurance ?? 0;
        double totalAmount = rentalAmount + insuranceAmount;

        return Padding(
          padding: EdgeInsets.all(16.0),
          child: SizedBox(
            height: 250,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("الفاتورة", style: headTextStyle()),
                SizedBox(height: 8),
                Text("المبلغ الأساسي: ${rentalAmount.toStringAsFixed(2)}"),
                Text("مبلغ التأمين: ${insuranceAmount.toStringAsFixed(2)}"),
                Divider(),
                Text("الإجمالي: ${totalAmount.toStringAsFixed(2)}",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                    "طريقة الدفع: ${_paymentMethod == 'bank_transfer' ? "تحويل بنكي" : "نقداً"}"),
                Text(
                    "طريقة التوصيل: ${_deliveryMethod == 'courier' ? "مندوب" : "التسليم اليدوي"}"),
                if (_deliveryMethod == 'courier')
                  Text("الموقع: ${_locationController.text}"),
                Center(
                  child: Text(
                      "ملاحظة:\nسيتم إرجاع مبلغ التأمين حين يتم استرجاع الغرض بحالته الأصلية."),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

// تتبع ما إذا كانت القيم قد تم ملؤها
  bool _isInvoiceReady() {
    return _startDate != null &&
        _endDate != null &&
        _paymentMethod != null &&
        _deliveryMethod != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: kSecondaryColor),
        backgroundColor: kPrimaryColor,
        title: Text(
          isItemLoaded ? "طلب استئجار لـ ${item.name}" : "تحميل...",
          style: TextStyle(color: kSecondaryColor),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    defualthelpContainer(
                      tips: [
                        "سيتم إرجاع مبلغ التأمين حين يتم إرجاع الغرض بحالته الأصلية",
                        "نرجو منك المحافظة على الغرض وعدم اتلافه",
                        "نرجو منك الالتزام بمواعيد استلام وارجاع الغرض طبقا للتواريخ التي قمت بإختيارها",
                      ],
                      imagePath: 'assets/img/hints.png',
                      icons: [
                        Icons.check,
                        Icons.check,
                        Icons.check,
                      ],
                      title: 'نصائح بسيطة    ',
                    ),
                    SizedBox(height: 20),
                    // Card for Item details
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "تفاصيل الغرض: ${item.name} ",
                                    textAlign: TextAlign.right,
                                  )),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    " السعر في اليوم : ${item.pricePerDay}",
                                    textAlign: TextAlign.right,
                                  )),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "   مبلغ التأمين : ${item.priceAssurance}",
                                    textAlign: TextAlign.right,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Card for Date Selections
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildDateSelection("تاريخ البداية", _startDate,
                                  true, item.maxRentalDuration),
                              _buildDateSelection("تاريخ النهاية", _endDate,
                                  false, item.maxRentalDuration),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Card for Payment Method
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: _buildDropdown(
                                    "طريقة الدفع",
                                    _paymentMethod,
                                    ['bank_transfer', 'cash'],
                                    (value) =>
                                        setState(() => _paymentMethod = value)),
                              ),
                              if (_paymentMethod == 'bank_transfer')
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: _buildTextField("رقم الحوالة",
                                      _transactionNumberController),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Card for Delivery Method
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: _buildDropdown(
                                  "طريقة التوصيل",
                                  _deliveryMethod,
                                  ['courier', 'self'], // ✅ القائمة الصحيحة
                                  (value) =>
                                      setState(() => _deliveryMethod = value),
                                ),
                              ),
                              if (_deliveryMethod == 'courier')
                                _buildTextField("الموقع", _locationController),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Card for Invoice Preview Button
                    Center(
                      child: SizedBox(
                        width: 160,
                        height: 50,
                        child: Visibility(
                          visible: _isInvoiceReady(),
                          child: Card(
                            color: kPrimaryColor,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: GestureDetector(
                              onTap: _showInvoiceDialog,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 7.0),
                                child: Center(
                                  child: Text(
                                    'عرض الفاتورة',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: kSecondaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    // Card for Submit Button
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: DefualtBotton(
                        text: 'إرسال الطلب',
                        press: _showConfirmationDialog,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildDropdown(String label, String? value, List<String> options,
      Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        DropdownButton<String>(
          value: value,
          hint: Text("اختر $label"),
          onChanged: onChanged,
          items: options
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e == 'bank_transfer'
                          ? "تحويل بنكي"
                          : e == 'cash'
                              ? "نقداً"
                              : e == 'courier'
                                  ? "مندوب"
                                  : "تسليم ذاتي",
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
    );
  }

  Widget _buildDateSelection(
      String label, DateTime date, bool isStartDate, int maxRentalDays) {
    return Row(
      children: [
        Text("$label: ${DateFormat('yyyy-MM-dd').format(date)}"),
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () => _selectDate(context, isStartDate, maxRentalDays),
        ),
      ],
    );
  }
}
