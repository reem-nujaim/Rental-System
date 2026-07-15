// // import 'package:flutter/material.dart';
// // import 'dart:io';
// // import 'package:image_picker/image_picker.dart';

// // import 'ReviewScreen.dart';
// // // استدعاء الشاشة التالية

// // class ImageUploadScreen extends StatefulWidget {
// // static String routeName = "/ImagePickerScreen";
// //   final String categoryId;
// //   final String itemName;
// //   final String itemDescription;
// //   final String price;
// //   final String status;
// //   final String deliveryMethod;

// //   const ImageUploadScreen({
// //     Key? key,
// //     required this.categoryId,
// //     required this.itemName,
// //     required this.itemDescription,
// //     required this.price,
// //     required this.status,
// //     required this.deliveryMethod,
// //   }) : super(key: key);

// //   @override
// //   _ImageUploadScreenState createState() => _ImageUploadScreenState();
// // }

// // class _ImageUploadScreenState extends State<ImageUploadScreen> {
// //   final ImagePicker _picker = ImagePicker();
// //   List<File> _images = [];

// //   Future<void> _pickImage() async {
// //     if (_images.length >= 5) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("يمكنك إضافة 5 صور فقط")),
// //       );
// //       return;
// //     }

// //     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
// //     if (pickedFile != null) {
// //       setState(() {
// //         _images.add(File(pickedFile.path));
// //       });
// //     }
// //   }

// //   void _removeImage(int index) {
// //     setState(() {
// //       _images.removeAt(index);
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text("رفع الصور")),
// //       body: Padding(
// //         padding: EdgeInsets.all(16),
// //         child: Column(
// //           children: [
// //             ElevatedButton(
// //               onPressed: _pickImage,
// //               child: Text("اختر صورة"),
// //             ),
// //             SizedBox(height: 16),
// //             _images.isEmpty
// //                 ? Text("لم يتم إضافة صور بعد")
// //                 : Expanded(
// //                     child: GridView.builder(
// //                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //                         crossAxisCount: 3,
// //                         crossAxisSpacing: 8,
// //                         mainAxisSpacing: 8,
// //                       ),
// //                       itemCount: _images.length,
// //                       itemBuilder: (context, index) {
// //                         return Stack(
// //                           children: [
// //                             Image.file(_images[index], fit: BoxFit.cover),
// //                             Positioned(
// //                               right: 0,
// //                               top: 0,
// //                               child: IconButton(
// //                                 onPressed: () => _removeImage(index),
// //                                 icon: Icon(Icons.cancel, color: Colors.red),
// //                               ),
// //                             ),
// //                           ],
// //                         );
// //                       },
// //                     ),
// //                   ),
// //             SizedBox(height: 16),
// //             ElevatedButton(
// //               onPressed: () {
// //                 Navigator.push(
// //                   context,
// //                   MaterialPageRoute(
// //                     builder: (context) => ReviewScreen(
// //                       categoryId: widget.categoryId,
// //                       itemName: widget.itemName,
// //                       itemDescription: widget.itemDescription,
// //                       price: widget.price,
// //                       status: widget.status,
// //                       deliveryMethod: widget.deliveryMethod,
// //                       images: _images,
// //                     ),
// //                   ),
// //                 );
// //               },
// //               child: Text("التالي"),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'ReviewScreen.dart';

// class ImageUploadScreen extends StatefulWidget {
//   static String routeName = "/imageUpload_screen";
//   final String categoryId;
//   final String itemName;
//   final String itemDescription;
//   final String quantity;
//   final String priceAssurance;
//   final String pricePerHour;
//   final String pricePerDay;
//   final String status;
//   final String deliveryMethod;
//   final String location;
//   final String minRentalDuration;
//   final String maxRentalDuration;
//   final String availabilityHours;
//   final int userId;

//   const ImageUploadScreen({
//     Key? key,
//     required this.categoryId,
//     required this.itemName,
//     required this.itemDescription,
//     required this.quantity,
//     required this.priceAssurance,
//     required this.pricePerHour,
//     required this.pricePerDay,
//     required this.status,
//     required this.deliveryMethod,
//     required this.location,
//     required this.minRentalDuration,
//     required this.maxRentalDuration,
//     required this.availabilityHours,
//     required this.userId,
//   }) : super(key: key);

//   @override
//   _ImageUploadScreenState createState() => _ImageUploadScreenState();
// }

// class _ImageUploadScreenState extends State<ImageUploadScreen> {
//   final ImagePicker _picker = ImagePicker();
//   List<File> imageFiles = []; // تخزين الصور كملفات محلية
//   List<String> imagePaths = []; // قائمة للمسارات النصية للصور

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         imageFiles.add(File(pickedFile.path));
//         imagePaths.add(pickedFile.path); // حفظ المسار النصي للرفع لاحقًا
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("رفع الصور")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: const Text("اختر صورة من المعرض"),
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 8,
//                   mainAxisSpacing: 8,
//                 ),
//                 itemCount: imageFiles.length,
//                 itemBuilder: (context, index) {
//                   return Stack(
//                     children: [
//                       Image.file(
//                         imageFiles[index],
//                         fit: BoxFit.cover,
//                         width: double.infinity,
//                         height: double.infinity,
//                       ),
//                       Positioned(
//                         top: 4,
//                         right: 4,
//                         child: GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               imageFiles.removeAt(index);
//                               imagePaths.removeAt(index);
//                             });
//                           },
//                           child: const CircleAvatar(
//                             backgroundColor: Colors.red,
//                             radius: 12,
//                             child: Icon(Icons.close,
//                                 size: 16, color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: () {
//                 if (imagePaths.isEmpty) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                         content: Text("يرجى رفع صورة واحدة على الأقل!")),
//                   );
//                   return;
//                 }

//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ReviewScreen(
//                       categoryId: widget.categoryId,
//                       itemName: widget.itemName,
//                       itemDescription: widget.itemDescription,
//                       quantity: widget.quantity,
//                       priceAssurance: widget.priceAssurance,
//                       pricePerHour: widget.pricePerHour,
//                       pricePerDay: widget.pricePerDay,
//                       status: widget.status,
//                       deliveryMethod: widget.deliveryMethod,
//                       location: widget.location,
//                       minRentalDuration: widget.minRentalDuration,
//                       maxRentalDuration: widget.maxRentalDuration,
//                       availabilityHours: widget.availabilityHours,
//                       userId: widget.userId,
//                       images: imagePaths, // ✅ تمرير المسارات إلى شاشة المراجعة
//                     ),
//                   ),
//                 );
//               },
//               child: const Text("التالي"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_signin/screens/addItem_Screens/ReviewScreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../../provider/item_provider.dart';

class AddImagesScreen extends StatefulWidget {
  static String routeName = "/ImagePickerScreen";
  @override
  _AddImagesScreenState createState() => _AddImagesScreenState();
}

class _AddImagesScreenState extends State<AddImagesScreen> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      final itemProvider = Provider.of<ItemProvider>(context, listen: false);
      for (var image in images) {
        if (itemProvider.imagePaths.length < 10) {
          itemProvider.addImagePath(image.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("يمكنك اختيار 10 صور كحد أقصى")),
          );
          break;
        }
      }
    }
  }

  Future<void> _captureImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      final itemProvider = Provider.of<ItemProvider>(context, listen: false);
      if (itemProvider.imagePaths.length < 10) {
        itemProvider.addImagePath(image.path);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("يمكنك اختيار 10 صور كحد أقصى")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("أضف الصور"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "الرجاء اختيار 10 صور كحد أقصى",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _pickImages,
                child: Row(
                  children: [
                    Icon(Icons.photo_library),
                    SizedBox(width: 10),
                    Text("اختر من المعرض"),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _captureImage,
                child: Row(
                  children: [
                    Icon(Icons.camera_alt),
                    SizedBox(width: 10),
                    Text("التقط صورة"),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: itemProvider.imagePaths.length,
              itemBuilder: (context, index) {
                return Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.file(
                      File(itemProvider.imagePaths[index]),
                      fit: BoxFit.cover,
                    ),
                    IconButton(
                      icon: Icon(Icons.cancel, color: Colors.red),
                      onPressed: () {
                        itemProvider.imagePaths.removeAt(index);
                        itemProvider.notifyListeners();
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (itemProvider.imagePaths.length < 4) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("الرجاء إضافة 4 صور على الأقل")),
                );
              } else {
                Navigator.pushNamed(context, ReviewScreen.routeName);
              }
            },
            child: Text("التالي"),
          ),
        ],
      ),
    );
  }
}
