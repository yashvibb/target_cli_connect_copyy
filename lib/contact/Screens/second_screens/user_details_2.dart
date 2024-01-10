// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:screenshot/screenshot.dart';
// import '../../Components/custom_icon_btn.dart';
// import '../../Components/leading_icon_btn.dart';
// import '../../Constants/color_const.dart';
// import '../../HelperFunctions/launcher_functions.dart';
// import '../../HelperFunctions/my_text_style.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:share/share.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
//
// class User_Details_2 extends StatefulWidget {
//   final Map<String, dynamic> contact2;
//
//   User_Details_2({
//     super.key,
//     required this.contact2,
//   });
//
//   @override
//   State<User_Details_2> createState() => _User_Details_2State();
// }
//
// class _User_Details_2State extends State<User_Details_2> {
//   late ScreenshotController screenshotController;
//   DateTime date = DateTime.now();
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//
//   @override
//   void initState() {
//     super.initState();
//     screenshotController = ScreenshotController();
//   }
//
//   Future<void> _takeScreenshot() async {
//     Uint8List? imageBytes = await screenshotController.capture();
//     if (imageBytes != null) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             content: Image.memory(imageBytes),
//             actions: [
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text('Close'),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   String path = await _saveImage(imageBytes);
//                   Share.shareFiles([path], text: '');
//                 },
//                 child: Text('Share'),
//               ),
//             ],
//           );
//         },
//       );
//
//       // Save image data to Firestore
//       await _firestore.collection('your_firestore_collection_name').add({
//         'timestamp': FieldValue.serverTimestamp(),
//       }).then((documentReference) async {
//         // Upload image to Firebase Storage
//         await _storage
//             .ref('screenshots/${documentReference.id}.png')
//             .putData(imageBytes);
//       });
//     }
//   }
//
//   Future<String> _saveImage(Uint8List imageBytes) async {
//     final directory = await getTemporaryDirectory();
//     final path = '${directory.path}/screenshot.png';
//     File(path).writeAsBytesSync(imageBytes);
//
//     // Save image to gallery
//     await ImageGallerySaver.saveImage(imageBytes, name: 'screenshot');
//
//     return path;
//   }
//
//   Widget keyValue({
//     required String key,
//     required String value,
//     void Function()? onTap,
//   }) =>
//       Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text.rich(
//             TextSpan(
//               children: [
//                 TextSpan(
//                   text: "\u2739 ",
//                   style: MyTextStyle.bold.copyWith(
//                     color: Colors.indigo.shade900,
//                   ),
//                 ),
//                 TextSpan(
//                   text: key,
//                   style: MyTextStyle.medium.copyWith(
//                     color: Color(0xffB5C0FF),
//                     fontSize: 15,
//                   ),
//                 )
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 15.5),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   value,
//                   style: MyTextStyle.bold.copyWith(
//                     color: Colors.indigo.shade900,
//                     fontSize: 15.5,
//                   ),
//                 ),
//                 if (onTap != null)
//                   Padding(
//                     padding: const EdgeInsets.only(right: 20),
//                     child: InkWell(
//                       onTap: onTap,
//                       child: const Padding(
//                         padding: EdgeInsets.all(3),
//                         child: Icon(
//                           Icons.copy,
//                           size: 20,
//                           color: ColorConst.grey400,
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xffB5C0FF),
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.indigo.shade900,
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.screenshot),
//             onPressed: _takeScreenshot,
//           ),
//         ],
//         title: Text("${widget.contact2["name"]}'s details",
//             style: TextStyle(color: Colors.indigo.shade900)),
//       ),
//       body: Screenshot(
//         controller: screenshotController,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 15,
//             vertical: 13,
//           ),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 20),
//                 Center(
//                   child: SizedBox(
//                     width: 80,
//                     height: 80,
//                     child: widget.contact2["profile"] != null
//                         ? Container(
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(50),
//                               border: Border.all(
//                                 color: ColorConst.appPrimary,
//                                 width: 0.75,
//                               ),
//                             ),
//                             child: ClipOval(
//                               child: Image.file(
//                                 File(widget.contact2["profile"]),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           )
//                         : CircleAvatar(
//                             backgroundColor: Color(0xffB5C0FF),
//                             child: Icon(
//                               Icons.person,
//                               size: 40,
//                               color: Colors.indigo.shade900,
//                             ),
//                           ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Center(
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       CustomIconBtn(
//                         iconColor: Colors.orange,
//                         background: Colors.orange.withOpacity(0.2),
//                         size: 35,
//                         onTap: () {
//                           callerLauncher(widget.contact2['mobile']);
//                         },
//                         icon: Icon(
//                           Icons.call,
//                           size: 19,
//                           color: Colors.yellow.shade900,
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       CustomIconBtn(
//                         size: 35,
//                         onTap: () async {
//                           whatsappLaunch(widget.contact2['mobile']);
//                         },
//                         icon: Icon(
//                           Icons.maps_ugc,
//                           size: 17,
//                           color: Colors.green.shade900,
//                         ),
//                         background: Colors.teal.withOpacity(0.2),
//                         colorFilter: const ColorFilter.mode(
//                           Colors.transparent,
//                           BlendMode.difference,
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       CustomIconBtn(
//                         size: 35,
//                         iconColor: Colors.purple,
//                         background: Colors.purple.withOpacity(0.2),
//                         onTap: () {
//                           smsLauncher(widget.contact2['mobile']);
//                         },
//                         icon: Icon(
//                           Icons.sms,
//                           size: 17,
//                           color: Colors.pink.shade900,
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                     ],
//                   ),
//                 ),
//                 Center(
//                   child: TextButton(
//                     onPressed: () async {
//                       DateTime? newDate = await showDatePicker(
//                         context: context,
//                         initialDate: date,
//                         firstDate: DateTime(2020),
//                         lastDate: DateTime(2100),
//                       );
//                       if (newDate == null) return;
//                       setState(() {
//                         date = newDate;
//                       });
//                     },
//                     child: Text(
//                       'Date: ${date.year} / ${date.day} / ${date.month}',
//                       style: TextStyle(
//                           fontSize: 15, color: Colors.indigo.shade900),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 15),
//                 keyValue(
//                   key: "Name (નામ)",
//                   value: widget.contact2['name'],
//                 ),
//                 const SizedBox(height: 15),
//                 keyValue(
//                   key: "Bil Number (બિલ નંબર)",
//                   value: widget.contact2['bilNumber'],
//                 ),
//                 const SizedBox(height: 15),
//                 keyValue(
//                   key: "Diamond Type (હિરા પ્રકાર)",
//                   value: widget.contact2['diamondType'],
//                 ),
//                 const SizedBox(height: 15),
//                 keyValue(
//                   key: "Aavela Hira (આવેલા હિરા)",
//                   value: widget.contact2['aavelaHira'],
//                 ),
//                 const SizedBox(height: 15),
//                 keyValue(
//                   key: "Kacha Hira (કાચા હિરા)",
//                   value: widget.contact2['kachaHira'],
//                 ),
//                 const SizedBox(height: 15),
//                 keyValue(
//                   key: "Jama Hira (જમા હિરા)",
//                   value: widget.contact2['jamaHira'],
//                 ),
//                 const SizedBox(height: 15),
//                 keyValue(
//                   key: "Damege Hira (ડેમેજ હિરા)",
//                   value: widget.contact2['damageHira'],
//                 ),
//                 const SizedBox(height: 15),
//                 keyValue(
//                   key: "Item (નંગ)",
//                   value: "${widget.contact2['items']}",
//                 ),
//                 const SizedBox(height: 10),
//                 keyValue(
//                   key: "Amount (ભાવ)",
//                   value: "${widget.contact2['amount']}",
//                 ),
//                 const SizedBox(height: 10),
//                 keyValue(
//                   key: "Total (ટોટલ)",
//                   value: "${widget.contact2['total']}",
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:screenshot/screenshot.dart';
import '../../Components/custom_icon_btn.dart';
import '../../Components/leading_icon_btn.dart';
import '../../Constants/color_const.dart';
import '../../HelperFunctions/launcher_functions.dart';
import '../../HelperFunctions/my_text_style.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class User_Details_2 extends StatefulWidget {
  final Map<String, dynamic> contact;

  User_Details_2({
    super.key,
    required this.contact,
  });

  @override
  State<User_Details_2> createState() => _User_Details_2State();
}

class _User_Details_2State extends State<User_Details_2> {
  late ScreenshotController screenshotController;
  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
    screenshotController = ScreenshotController();
  }

  Future<void> _takeScreenshot() async {
    Uint8List? imageBytes = await screenshotController.capture();
    if (imageBytes != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Image.memory(imageBytes),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
              ElevatedButton(
                onPressed: () async {
                  String path = await _saveImage(imageBytes);
                  Share.shareFiles([path], text: '');
                },
                child: Text('Share'),
              ),
            ],
          );
        },
      );
    }
  }
  Future<String> _saveImage(Uint8List imageBytes) async {
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/screenshot.png';
    File(path).writeAsBytesSync(imageBytes);

    // Save image to gallery
    await ImageGallerySaver.saveImage(imageBytes, name: 'screenshot');

    return path;
  }

  Widget keyValue({
    required String key,
    required String value,
    void Function()? onTap,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "\u2739 ",
                  style: MyTextStyle.bold.copyWith(
                    color: Colors.indigo.shade900,
                  ),
                ),
                TextSpan(
                  text: key,
                  style: MyTextStyle.medium.copyWith(
                    color:  Color(0xffB5C0FF),
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: MyTextStyle.bold.copyWith(
                    color: Colors.indigo.shade900,
                    fontSize: 15.5,
                  ),
                ),
                if (onTap != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      onTap: onTap,
                      child: const Padding(
                        padding: EdgeInsets.all(3),
                        child: Icon(
                          Icons.copy,
                          size: 20,
                          color: ColorConst.grey400,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Color(0xffB5C0FF),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.indigo.shade900,),
          onPressed:(){ Navigator.pop(context);},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.screenshot),
            onPressed: _takeScreenshot,
          ),
        ],
        title: Text("${widget.contact["name"]}'s details",
            style: TextStyle(color: Colors.indigo.shade900)),
      ),
      body: Screenshot(
        controller: screenshotController,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 13,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: widget.contact["profile"] != null
                        ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: ColorConst.appPrimary,
                          width: 0.75,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.file(
                          File(widget.contact["profile"]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                        : CircleAvatar(
                      backgroundColor:   Color(0xffB5C0FF),
                      child:Icon(Icons.person,size: 40,color:Colors.indigo.shade900,),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconBtn(
                        iconColor: Colors.orange,
                        background: Colors.orange.withOpacity(0.2),
                        size: 35,
                        onTap: () {
                          callerLauncher(widget.contact['mobile']);
                        },
                        icon: Icon(Icons.call,size: 19,color: Colors.yellow.shade900,),
                      ),
                      const SizedBox(width: 10),
                      CustomIconBtn(
                        size: 35,
                        onTap: () async {
                          whatsappLaunch(widget.contact['mobile']);
                        },
                        icon: Icon(Icons.maps_ugc,size: 17,color: Colors.green.shade900,),
                        background: Colors.teal.withOpacity(0.2),
                        colorFilter: const ColorFilter.mode(
                          Colors.transparent,
                          BlendMode.difference,
                        ),
                      ),
                      const SizedBox(width: 10),
                      CustomIconBtn(
                        size: 35,
                        iconColor: Colors.purple,
                        background: Colors.purple.withOpacity(0.2),
                        onTap: () {
                          smsLauncher(widget.contact['mobile']);
                        }, icon: Icon(Icons.sms,size: 17,color: Colors.pink.shade900,),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: date,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );
                      if (newDate == null) return;
                      setState(() {
                        date = newDate;
                      });
                    },
                    child: Text(
                      'Date: ${date.year} / ${date.day} / ${date.month}',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.indigo.shade900
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                keyValue(
                  key: "Name (નામ)",
                  value: widget.contact['name'],
                ),
                const SizedBox(height: 15),
                keyValue(
                  key: "Bil Number (બિલ નંબર)",
                  value: widget.contact['bilNumber'],
                ),
                const SizedBox(height: 15),
                keyValue(
                  key: "Diamond Type (હિરા પ્રકાર)",
                  value: widget.contact['diamondType'],
                ),
                const SizedBox(height: 15),
                keyValue(
                  key: "Aavela Hira (આવેલા હિરા)",
                  value: widget.contact['aavelaHira'],
                ),
                const SizedBox(height: 15),
                keyValue(
                  key: "Kacha Hira (કાચા હિરા)",
                  value: widget.contact['kachaHira'],
                ),
                const SizedBox(height: 15),
                keyValue(
                  key: "Jama Hira (જમા હિરા)",
                  value: widget.contact['jamaHira'],
                ),
                const SizedBox(height: 15),
                keyValue(
                  key: "Damege Hira (ડેમેજ હિરા)",
                  value: widget.contact['damageHira'],
                ),
                const SizedBox(height: 15),
                keyValue(
                  key: "Item (નંગ)",
                  value: "${widget.contact['items']}",
                ),
                const SizedBox(height: 10),
                keyValue(
                  key: "Amount (ભાવ)",
                  value: "${widget.contact['amount']}",
                ),
                const SizedBox(height: 10),
                keyValue(
                  key: "Total (ટોટલ)",
                  value: "${widget.contact['total']}",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}