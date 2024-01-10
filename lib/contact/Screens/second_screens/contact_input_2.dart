// // import 'dart:developer';
// // import 'dart:io';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:provider/provider.dart';
// // import '../../Components/choose_options_bottom_sheet.dart';
// // import '../../Components/custom_btn.dart';
// // import '../../Components/my_text_form_field.dart';
// // import '../../Providers/contact_provider.dart';
// // import '../Components/select_group_btn.dart';
// // import '../Components/user_details.dart';
// // import '../select_group.dart';
// //
// // class Contact {
// //   String name;
// //   Contact({
// //     required this.name,
// //   });
// // }
// //
// // class Contact_Input_2 extends StatefulWidget {
// //   final Map<String, dynamic>? contact2;
// //   final int? index;
// //
// //   Contact_Input_2({Key? key, this.contact2, this.index}) : super(key: key);
// //
// //   @override
// //   State<Contact_Input_2> createState() => _Contact_Input_2State();
// // }
// //
// // class _Contact_Input_2State extends State<Contact_Input_2> {
// //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   final FirebaseStorage _storage = FirebaseStorage.instance;
// //   File? imageFile;
// //   XFile? cameraPhoto;
// //   DateTime date = DateTime.now();
// //   TextEditingController nameController = TextEditingController();
// //   TextEditingController bilnumberController = TextEditingController();
// //   TextEditingController itemController = TextEditingController();
// //   TextEditingController aavelahiravajanController = TextEditingController();
// //   TextEditingController damageController = TextEditingController();
// //   TextEditingController kachahiraController = TextEditingController();
// //   TextEditingController diamondController = TextEditingController();
// //   TextEditingController jamaController = TextEditingController();
// //   TextEditingController amountController = TextEditingController();
// //   TextEditingController totalController = TextEditingController();
// //   final formKey = GlobalKey<FormState>();
// //   String? selctedItem;
// //   String? selctedItemi;
// //   List<String> mySelectedGroup = [];
// //   List<Map<String, dynamic>> itemList = [];
// //
// //   Future<void> _uploadImage(String userId) async {
// //     if (imageFile != null) {
// //       String filePath = 'profile_images/$userId.jpg';
// //       UploadTask uploadTask = _storage.ref().child(filePath).putFile(imageFile!);
// //       await uploadTask.whenComplete(() => null);
// //
// //       String downloadURL = await _storage.ref(filePath).getDownloadURL();
// //       setState(() {
// //         imageFile = null;
// //       });
// //     }
// //   }
// //
// //   Future<void> _saveContact(String userId) async {
// //     Map<String, dynamic> userInfo2 = {
// //       'name': nameController.text.trim(),
// //       'damageHira': damageController.text.trim(),
// //       'bilNumber': bilnumberController.text.trim(),
// //       'diamondType': diamondController.text.trim(),
// //       'aavelaHira': aavelahiravajanController.text.trim(),
// //       'kachaHira': kachahiraController.text.trim(),
// //       'items': itemController.text.trim(),
// //       'jamaHira': jamaController.text.trim(),
// //       'amount': amountController.text.trim(),
// //       'total': totalController.text.trim(),
// //       'group': mySelectedGroup,
// //       'profile':
// //       imageFile != null ? imageFile!.path : null,
// //     };
// //
// //     await _firestore.collection('contacts').doc(userId).set(userInfo2);
// //   }
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Color(0xffB5C0FF),
// //         automaticallyImplyLeading: false,
// //         title: Center(
// //             child: Text(
// //           widget.contact2 != null ? "Update Contact" : "Add Contact",
// //           style: TextStyle(
// //               color: Colors.indigo.shade900, fontWeight: FontWeight.w700),
// //         )),
// //       ),
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: const EdgeInsets.all(17),
// //           child: Form(
// //             key: formKey,
// //             child: Column(
// //               children: [
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     ElevatedButton(
// //                       style: ElevatedButton.styleFrom(
// //                         elevation: 0.0,
// //                         backgroundColor: Colors.white,
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(5.0),
// //                         ),
// //                       ),
// //                       onPressed: () {
// //                         Navigator.pop(context);
// //                       },
// //                       child: Icon(Icons.close,
// //                           size: 23, color: Colors.indigo.shade900),
// //                     ),
// //                     Align(
// //                       alignment: Alignment.bottomRight,
// //                       child: CustomBtn(
// //                         onPressed: () async {
// //                           if (formKey.currentState!.validate()) {
// //                             Map<String, dynamic> userInfo2 = {
// //                               'name': nameController.text.trim(),
// //                               'damageHira': damageController.text.trim(),
// //                               'bilNumber': bilnumberController.text.trim(),
// //                               'diamondType' : diamondController.text.trim(),
// //                               'aavelaHira': aavelahiravajanController.text.trim(),
// //                               'kachaHira': kachahiraController.text.trim(),
// //                               'items': itemController.text.trim(),
// //                               'jamaHira': jamaController.text.trim(),
// //                               'amount': amountController.text.trim(),
// //                               'total': totalController.text.trim(),
// //                               'group': mySelectedGroup,
// //                               'profile':
// //                                   imageFile != null ? imageFile!.path : null,
// //                             };
// //
// //                             Navigator.pushReplacement(
// //                               context,
// //                               MaterialPageRoute(
// //                                 builder: (context) => UserDetails(contact: userInfo2, index: widget.index!),
// //                               ),
// //                             );
// //                           }
// //                         },
// //                         icon: widget.contact2 != null
// //                             ? Icon(
// //                                 Icons.done,
// //                                 color: Colors.indigo.shade900,
// //                               )
// //                             : Icon(
// //                                 Icons.done,
// //                                 color: Colors.indigo.shade900,
// //                               ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 Padding(
// //                   padding: const EdgeInsets.only(top: 15),
// //                   child: InkWell(
// //                     onTap: () async {
// //                       File? file = await showModalBottomSheet(
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(8.0),
// //                         ),
// //                         context: context,
// //                         builder: (context) {
// //                           return ChooseOptionsBottomSheet();
// //                         },
// //                       );
// //                       if (file != null) {
// //                         file;
// //                         if (file != null) {
// //                           setState(() {
// //                             imageFile = file;
// //                           });
// //                         }
// //                       }
// //                       FocusManager.instance.primaryFocus?.unfocus();
// //                     },
// //                     child: ClipOval(
// //                       child: Container(
// //                         width: 90,
// //                         height: 90,
// //                         decoration: BoxDecoration(
// //                           borderRadius: BorderRadius.circular(80),
// //                           color: Colors.indigo.shade900,
// //                         ),
// //                         child: ClipOval(
// //                           child: imageFile != null
// //                               ? Image.file(
// //                                   imageFile!,
// //                                   fit: BoxFit.cover,
// //                                 )
// //                               : Padding(
// //                                   padding: const EdgeInsets.all(15.0),
// //                                   child: Icon(
// //                                     Icons.person,
// //                                     size: 40,
// //                                     color: Color(0xffB5C0FF),
// //                                   )),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //                 Center(
// //                   child: TextButton(
// //                     onPressed: () async {
// //                       DateTime? newDate = await showDatePicker(
// //                         context: context,
// //                         initialDate: date,
// //                         firstDate: DateTime(2020),
// //                         lastDate: DateTime(2100),
// //                       );
// //                       if (newDate == null) return;
// //                       setState(() {
// //                         date = newDate;
// //                       });
// //                     },
// //                     child: Text(
// //                       'Date: ${date.year} / ${date.day} / ${date.month}',
// //                       style: TextStyle(
// //                           fontSize: 15, color: Colors.indigo.shade900),
// //                     ),
// //                   ),
// //                 ),
// //                 SizedBox(height: 20),
// //                 MyTextFormField(
// //                   controller: bilnumberController,
// //                   label: "Bil Number (બિલ નંબર)",
// //                   keyboardType: TextInputType.number,
// //                   validator: (bilnumber) {
// //                     if (bilnumber == null || bilnumber.trim().isEmpty) {
// //                       return "Please enter bil number";
// //                     } else {
// //                       return null;
// //                     }
// //                   },
// //                 ),
// //                 SizedBox(height: 20),
// //                 MyTextFormField(
// //                   controller: nameController,
// //                   label: "Company Name (કંપની નામ)",
// //                   validator: (name) {
// //                     if (name == null || name.trim().isEmpty) {
// //                       return "Please enter name";
// //                     } else {
// //                       return null;
// //                     }
// //                   },
// //                 ),
// //                 SizedBox(height: 20),
// //                 MyTextFormField(
// //                   controller: aavelahiravajanController,
// //                   label: "Aavela Hira Vajan  (આવેલા હીરા વજન)",
// //                   validator: (aavelahiravajan) {
// //                     if (aavelahiravajan == null ||
// //                         aavelahiravajan.trim().isEmpty) {
// //                       return "Please enter aavela hira vajan";
// //                     } else {
// //                       return null;
// //                     }
// //                   },
// //                 ),
// //                 SizedBox(height: 20),
// //                 MyTextFormField(
// //                   controller: diamondController,
// //                   label: "Diamond Type (ડાઇમંડ પ્રકાર)",
// //                   validator: (diamondtype) {
// //                     if (diamondtype == null || diamondtype.trim().isEmpty) {
// //                       return "Please enter diamond type";
// //                     } else {
// //                       return null;
// //                     }
// //                   },
// //                 ),
// //                 SizedBox(height: 20),
// //                 MyTextFormField(
// //                   controller: jamaController,
// //                   label: "Jama Diamond (જમા ડાઇમંડ)",
// //                   validator: (jamadiamond) {
// //                     if (jamadiamond == null || jamadiamond.trim().isEmpty) {
// //                       return "Please enter damage diamond";
// //                     } else {
// //                       return null;
// //                     }
// //                   },
// //                 ),
// //                 SizedBox(height: 20),
// //                 MyTextFormField(
// //                   controller: kachahiraController,
// //                   label: "Raw Diamond (કાચા ડાઇમંડ)",
// //                   validator: (kachahira) {
// //                     if (kachahira == null || kachahira.trim().isEmpty) {
// //                       return "Please enter raw diamond";
// //                     } else {
// //                       return null;
// //                     }
// //                   },
// //                 ),
// //                 SizedBox(height: 20),
// //                 MyTextFormField(
// //                   controller: damageController,
// //                   label: "Damage Diamond (ડેમેજ ડાઇમંડ)",
// //                   validator: (damagediamond) {
// //                     if (damagediamond == null || damagediamond.trim().isEmpty) {
// //                       return "Please enter damage diamond";
// //                     } else {
// //                       return null;
// //                     }
// //                   },
// //                 ),
// //                 SelectGroupBtn(
// //                   onTap: () async {
// //                     final selected = await Navigator.push(
// //                       context,
// //                       CupertinoPageRoute(
// //                         builder: (context) {
// //                           return SelectGroup(list: mySelectedGroup);
// //                         },
// //                       ),
// //                     );
// //                     mySelectedGroup = selected;
// //                     setState(() {});
// //                   }, onGroupsSelected: (List<String> selectedGroups) {mySelectedGroup;},
// //                 ),
// //                 SizedBox(height: 10),
// //                 MyTextFormField(
// //                   controller: itemController,
// //                   label: "Items (નંગ)",
// //                   keyboardType: TextInputType.number,
// //                   inputFormatters: [
// //                     FilteringTextInputFormatter.allow(RegExp('[0-9]')),
// //                   ],
// //                   validator: (items) {
// //                     if (items == null || items.trim().isEmpty) {
// //                       return null;
// //                     } else {
// //                       Pattern pattern = r'^\d+\.?\d{0,9}';
// //                       RegExp regexp = RegExp(pattern.toString());
// //                       if (regexp.hasMatch(items.trim())) {
// //                         return null;
// //                       } else {
// //                         return "Please enter valid items";
// //                       }
// //                     }
// //                   },
// //                 ),
// //                 SizedBox(height: 20),
// //                 MyTextFormField(
// //                   controller: amountController,
// //                   label: "Amount (ભાવ)",
// //                   keyboardType: TextInputType.number,
// //                   inputFormatters: [
// //                     FilteringTextInputFormatter.allow(RegExp('[0-9]')),
// //                   ],
// //                   validator: (amount) {
// //                     if (amount == null || amount.trim().isEmpty) {
// //                       return null;
// //                     } else {
// //                       Pattern pattern = r'^\d+\.?\d{0,9}';
// //                       RegExp regexp = RegExp(pattern.toString());
// //                       if (regexp.hasMatch(amount.trim())) {
// //                         return null;
// //                       } else {
// //                         return "Please enter valid amount";
// //                       }
// //                     }
// //                   },
// //                 ),
// //                 SizedBox(height: 20),
// //                 Align(
// //                   alignment: Alignment.bottomRight,
// //                   child: ElevatedButton(
// //                     onPressed: () {
// //                       if (formKey.currentState!.validate()) {
// //                         double item = double.parse(itemController.text);
// //                         double amount = double.parse(amountController.text);
// //                         double total = item * amount;
// //
// //                         setState(() {
// //                           itemList.add({
// //                             'item': item,
// //                             'amount': amount,
// //                             'total': total,
// //                           });
// //                         });
// //                         totalController.text = itemList
// //                             .map((item) => item['total'])
// //                             .reduce((value, element) => value + element)
// //                             .toString();
// //                       }
// //                     },
// //                     style: ButtonStyle(
// //                         backgroundColor: MaterialStateProperty.all(
// //                       Color(0xffB5C0FF),
// //                     )),
// //                     child: Text(
// //                       "Total",
// //                       style: TextStyle(
// //                         color: Colors.indigo.shade900,
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //                 SizedBox(height: 20),
// //                 ListView.builder(
// //                   shrinkWrap: true,
// //                   itemCount: itemList.length,
// //                   itemBuilder: (BuildContext context, int index) {
// //                     return ListTile(
// //                       title: Text("Item: ${itemList[index]['item']}"),
// //                       subtitle: Text("Amount: ${itemList[index]['amount']}"),
// //                       trailing: Text("Total: ${itemList[index]['total']}"),
// //                     );
// //                   },
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:target_cli_connect/contact/Screens/Components/user_details.dart';
//
// import '../../Components/choose_options_bottom_sheet.dart';
// import '../../Components/custom_btn.dart';
// import '../../Components/my_text_form_field.dart';
//
// class Contact_Input_2 extends StatefulWidget {
//   final Map<String, dynamic>? contact2;
//   final int? index2;
//
//   Contact_Input_2({Key? key, this.contact2, this.index2}) : super(key: key);
//
//   @override
//   State<Contact_Input_2> createState() => _Contact_Input_2State();
// }
//
// class _Contact_Input_2State extends State<Contact_Input_2> {
//   File? imageFile;
//   XFile? cameraPhoto;
//   DateTime date = DateTime.now();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController bilnumberController = TextEditingController();
//   TextEditingController itemController = TextEditingController();
//   TextEditingController aavelahiravajanController = TextEditingController();
//   TextEditingController damageController = TextEditingController();
//   TextEditingController kachahiraController = TextEditingController();
//   TextEditingController diamondController = TextEditingController();
//   TextEditingController jamaController = TextEditingController();
//   TextEditingController amountController = TextEditingController();
//   TextEditingController totalController = TextEditingController();
//   final formKey2 = GlobalKey<FormState>();
//   List<Map<String, dynamic>> itemList2 = [];
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//
//   @override
//   void initState() {
//     debugPrint('contact2 -> ${widget.contact2}');
//     if (widget.contact2 != null) {
//       nameController.text = widget.contact2!['name'];
//       bilnumberController.text = widget.contact2!['bilNumber'];
//       itemController.text = widget.contact2!['items'];
//       aavelahiravajanController.text = widget.contact2!['aavelaHira'];
//       damageController.text = widget.contact2!['damageHira'];
//       kachahiraController.text = widget.contact2!['kachaHira'];
//       diamondController.text = widget.contact2!['diamondType'];
//       jamaController.text = widget.contact2!['jamaHira'];
//       amountController.text = widget.contact2!['amount'];
//       totalController.text = widget.contact2!['total'];
//     }
//     super.initState();
//   }
//
//   void _saveContactToFirebase2() async {
//     final databaseReference = FirebaseDatabase.instance.reference();
//     String? contactKey = databaseReference.child('contacts').push().key;
//
//     Map<String, dynamic> contactData2 = {
//       'name': nameController.text.trim(),
//       'damageHira': damageController.text.trim(),
//       'bilNumber': bilnumberController.text.trim(),
//       'diamondType': diamondController.text.trim(),
//       'aavelaHira': aavelahiravajanController.text.trim(),
//       'kachaHira': kachahiraController.text.trim(),
//       'items': itemController.text.trim(),
//       'jamaHira': jamaController.text.trim(),
//       'amount': amountController.text.trim(),
//       'total': totalController.text.trim(),
//       'profile': imageFile != null ? imageFile!.path : null,
//     };
//
//     if (widget.contact2 != null) {
//       contactKey = widget.contact2!['key'];
//     }
//
//     await databaseReference
//         .child('contacts')
//         .child(contactKey!)
//         .set(contactData2);
//   }
//
//   Stream<DocumentSnapshot<Map<String, dynamic>>>? contactStream() {
//     final firestore = FirebaseFirestore.instance;
//     String? contactKey =
//         widget.contact2 != null ? widget.contact2!['key'] : null;
//     return contactKey != null
//         ? firestore.collection('contacts').doc(contactKey).snapshots()
//         : null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xffB5C0FF),
//         automaticallyImplyLeading: false,
//         title: Center(
//             child: Text(
//           widget.contact2 != null ? "Update Contact" : "Add Contact",
//           style: TextStyle(
//               color: Colors.indigo.shade900, fontWeight: FontWeight.w700),
//         )),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(17),
//           child: Form(
//             key: formKey2,
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         elevation: 0.0,
//                         backgroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5.0),
//                         ),
//                       ),
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     UserDetails(contact: {})));
//                       },
//                       child: Icon(Icons.close,
//                           size: 23, color: Colors.indigo.shade900),
//                     ),
//                     // Align(
//                     //   alignment: Alignment.bottomRight,
//                     //   child: CustomBtn(
//                     //     onPressed: () async {
//                     //       if (formKey2.currentState!.validate()) {
//                     //         Map<String, dynamic> userInfo2 = {
//                     //           'name': nameController.text.trim(),
//                     //           'damageHira': damageController.text.trim(),
//                     //           'bilNumber': bilnumberController.text.trim(),
//                     //           'diamondType': diamondController.text.trim(),
//                     //           'aavelaHira': aavelahiravajanController.text.trim(),
//                     //           'kachaHira': kachahiraController.text.trim(),
//                     //           'items': itemController.text.trim(),
//                     //           'jamaHira': jamaController.text.trim(),
//                     //           'amount': amountController.text.trim(),
//                     //           'total': totalController.text.trim(),
//                     //           'profile': imageFile != null ? imageFile!.path : null,
//                     //         };
//                     //         try {
//                     //           final user = FirebaseAuth.instance.currentUser;
//                     //           if (user == null) {
//                     //           }
//                     //
//                     //           final firestore = FirebaseFirestore.instance;
//                     //           if (widget.contact2 != null) {
//                     //           } else {
//                     //             await firestore.collection('contacts').add(userInfo2);
//                     //           }
//                     //           Navigator.pushReplacement(
//                     //             context,
//                     //             MaterialPageRoute(
//                     //               builder: (context) => UserDetails(contact: {}),
//                     //             ),
//                     //           );
//                     //         } catch (error) {
//                     //           print("Error: $error");
//                     //         }
//                     //       }
//                     //     },
//                     //     icon: Icon(
//                     //       Icons.done,
//                     //       color: Colors.indigo.shade900,
//                     //     ),
//                     //   ),
//                     // ),
//                     Align(
//                       alignment: Alignment.bottomRight,
//                       child: CustomBtn(
//                         onPressed: () async {
//                           if (formKey2.currentState!.validate()) {
//                             Map<String, dynamic> userInfo2 = {
//                               'name': nameController.text.trim(),
//                               'damageHira': damageController.text.trim(),
//                               'bilNumber': bilnumberController.text.trim(),
//                               'diamondType': diamondController.text.trim(),
//                               'aavelaHira':
//                                   aavelahiravajanController.text.trim(),
//                               'kachaHira': kachahiraController.text.trim(),
//                               'items': itemController.text.trim(),
//                               'jamaHira': jamaController.text.trim(),
//                               'amount': amountController.text.trim(),
//                               'total': totalController.text.trim(),
//                               'profile':
//                                   imageFile != null ? imageFile!.path : null,
//                             };
//                             await _firestore
//                                 .collection('your_collection_name')
//                                 .add(userInfo2);
//
//                             Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => UserDetails(
//                                     contact: {},
//                                     index: widget.index2),
//                               ),
//                             );
//                           }
//                         },
//                         icon: widget.contact2 != null
//                             ? Icon(
//                                 Icons.done,
//                                 color: Colors.indigo.shade900,
//                               )
//                             : Icon(
//                                 Icons.done,
//                                 color: Colors.indigo.shade900,
//                               ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 15),
//                   child: InkWell(
//                     onTap: () async {
//                       File? file = await showModalBottomSheet(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         context: context,
//                         builder: (context) {
//                           return ChooseOptionsBottomSheet();
//                         },
//                       );
//                       if (file != null) {
//                         file;
//                         if (file != null) {
//                           setState(() {
//                             imageFile = file;
//                           });
//                         }
//                       }
//                       FocusManager.instance.primaryFocus?.unfocus();
//                     },
//                     child: ClipOval(
//                       child: Container(
//                         width: 90,
//                         height: 90,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(80),
//                           color: Colors.indigo.shade900,
//                         ),
//                         child: ClipOval(
//                           child: imageFile != null
//                               ? Image.file(
//                                   imageFile!,
//                                   fit: BoxFit.cover,
//                                 )
//                               : Padding(
//                                   padding: const EdgeInsets.all(15.0),
//                                   child: Icon(
//                                     Icons.person,
//                                     size: 40,
//                                     color: Color(0xffB5C0FF),
//                                   )),
//                         ),
//                       ),
//                     ),
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
//                 SizedBox(height: 20),
//                 MyTextFormField(
//                   controller: nameController,
//                   label: "Company Name (કંપની નામ)",
//                   validator: (name) {
//                     if (name == null || name.trim().isEmpty) {
//                       return "Please enter name";
//                     } else {
//                       return null;
//                     }
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 MyTextFormField(
//                   controller: aavelahiravajanController,
//                   label: "Aavela Hira Vajan  (આવેલા હીરા વજન)",
//                   validator: (aavelahiravajan) {
//                     if (aavelahiravajan == null ||
//                         aavelahiravajan.trim().isEmpty) {
//                       return "Please enter aavela hira vajan";
//                     } else {
//                       return null;
//                     }
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 MyTextFormField(
//                   controller: diamondController,
//                   label: "Diamond Type (ડાઇમંડ પ્રકાર)",
//                   validator: (diamondtype) {
//                     if (diamondtype == null || diamondtype.trim().isEmpty) {
//                       return "Please enter diamond type";
//                     } else {
//                       return null;
//                     }
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 MyTextFormField(
//                   controller: jamaController,
//                   label: "Jama Diamond (જમા ડાઇમંડ)",
//                   validator: (jamadiamond) {
//                     if (jamadiamond == null || jamadiamond.trim().isEmpty) {
//                       return "Please enter damage diamond";
//                     } else {
//                       return null;
//                     }
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 MyTextFormField(
//                   controller: kachahiraController,
//                   label: "Raw Diamond (કાચા ડાઇમંડ)",
//                   validator: (kachahira) {
//                     if (kachahira == null || kachahira.trim().isEmpty) {
//                       return "Please enter raw diamond";
//                     } else {
//                       return null;
//                     }
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 MyTextFormField(
//                   controller: damageController,
//                   label: "Damage Diamond (ડેમેજ ડાઇમંડ)",
//                   validator: (damagediamond) {
//                     if (damagediamond == null || damagediamond.trim().isEmpty) {
//                       return "Please enter damage diamond";
//                     } else {
//                       return null;
//                     }
//                   },
//                 ),
//                 SizedBox(height: 10),
//                 MyTextFormField(
//                   controller: itemController,
//                   label: "Items (નંગ)",
//                   keyboardType: TextInputType.number,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.allow(RegExp('[0-9]')),
//                   ],
//                   validator: (items) {
//                     if (items == null || items.trim().isEmpty) {
//                       return null;
//                     } else {
//                       Pattern pattern = r'^\d+\.?\d{0,9}';
//                       RegExp regexp = RegExp(pattern.toString());
//                       if (regexp.hasMatch(items.trim())) {
//                         return null;
//                       } else {
//                         return "Please enter valid items";
//                       }
//                     }
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 MyTextFormField(
//                   controller: amountController,
//                   label: "Amount (ભાવ)",
//                   keyboardType: TextInputType.number,
//                   inputFormatters: [
//                     FilteringTextInputFormatter.allow(RegExp('[0-9]')),
//                   ],
//                   validator: (amount) {
//                     if (amount == null || amount.trim().isEmpty) {
//                       return null;
//                     } else {
//                       Pattern pattern = r'^\d+\.?\d{0,9}';
//                       RegExp regexp = RegExp(pattern.toString());
//                       if (regexp.hasMatch(amount.trim())) {
//                         return null;
//                       } else {
//                         return "Please enter valid amount";
//                       }
//                     }
//                   },
//                 ),
//                 SizedBox(height: 20),
//                 Align(
//                   alignment: Alignment.bottomRight,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (formKey2.currentState!.validate()) {
//                         double item = double.parse(itemController.text);
//                         double amount = double.parse(amountController.text);
//                         double total = item * amount;
//
//                         setState(() {
//                           itemList2.add({
//                             'item': item,
//                             'amount': amount,
//                             'total': total,
//                           });
//                         });
//                         totalController.text = itemList2
//                             .map((item) => item['total'])
//                             .reduce((value, element) => value + element)
//                             .toString();
//                       }
//                     },
//                     style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all(
//                       Color(0xffB5C0FF),
//                     )),
//                     child: Text(
//                       "Total",
//                       style: TextStyle(
//                         color: Colors.indigo.shade900,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: itemList2.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return ListTile(
//                       title: Text("Item: ${itemList2[index]['item']}"),
//                       subtitle: Text("Amount: ${itemList2[index]['amount']}"),
//                       trailing: Text("Total: ${itemList2[index]['total']}"),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../Components/choose_options_bottom_sheet.dart';
import '../../Components/custom_btn.dart';
import '../../Components/my_text_form_field.dart';
import '../Components/select_group_btn.dart';
import '../Components/user_details.dart';
import '../select_group.dart';

class Contact {
  String name;
  Contact({
    required this.name,
  });
}

class Contact_Input_2 extends StatefulWidget {
  final Map<String, dynamic>? contact2;
  final int? index;

  Contact_Input_2({Key? key, this.contact2, this.index}) : super(key: key);

  @override
  State<Contact_Input_2> createState() => _Contact_Input_2State();
}

class _Contact_Input_2State extends State<Contact_Input_2> {
  File? imageFile;
  XFile? cameraPhoto;
  DateTime date = DateTime.now();
  TextEditingController nameController = TextEditingController();
  TextEditingController bilnumberController = TextEditingController();
  TextEditingController itemController = TextEditingController();
  TextEditingController aavelahiravajanController = TextEditingController();
  TextEditingController damageController = TextEditingController();
  TextEditingController kachahiraController = TextEditingController();
  TextEditingController diamondController = TextEditingController();
  TextEditingController jamaController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? selctedItem;
  String? selctedItemi;
  List<String> mySelectedGroup = [];
  List<Map<String, dynamic>> itemList = [];

  @override
  void initState() {
    debugPrint('contact -> ${widget.contact2}');
    if (widget.contact2 != null) {
      nameController.text = widget.contact2!['name'];
      diamondController.text = widget.contact2!['diamondType'];
      bilnumberController.text = widget.contact2!['bilNumber'];
      aavelahiravajanController.text = widget.contact2!['aavelaHira'];
      kachahiraController.text = widget.contact2!['kachaHira'];
      damageController.text = "${widget.contact2!['damageHira']}";
      mySelectedGroup = List<String>.from(widget.contact2!['group']);
      itemController.text = "${widget.contact2!['items']}";
      jamaController.text = "${widget.contact2!['jamaHira']}";
      amountController.text = "${widget.contact2!['amount']}";
      totalController.text = "${widget.contact2!['total']}";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List newCompanyDetail = [];
    final contactList = []; // Replace with the appropriate way to get your contactList

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffB5C0FF),
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            widget.contact2 != null ? "Update Contact" : "Add Contact",
            style: TextStyle(
              color: Colors.indigo.shade900,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close,
                          size: 23, color: Colors.indigo.shade900),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CustomBtn(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            Map<String, dynamic> userInfo2 = {
                              'name': nameController.text.trim(),
                              'damageHira': damageController.text.trim(),
                              'bilNumber': bilnumberController.text.trim(),
                              'diamondType': diamondController.text.trim(),
                              'aavelaHira': aavelahiravajanController.text.trim(),
                              'kachaHira': kachahiraController.text.trim(),
                              'items': itemController.text.trim(),
                              'jamaHira': jamaController.text.trim(),
                              'amount': amountController.text.trim(),
                              'total': totalController.text.trim(),
                              'group': mySelectedGroup,
                              'profile':

                              imageFile != null ? imageFile!.path : null,
                            };
                            if (widget.contact2 != null) {
                            } else {
                              Map<String, dynamic> companyDetail =
                              contactList[widget.index!];
                              companyDetail["companyDetail"].add(userInfo2);
                              setState(() {
                                newCompanyDetail =
                                companyDetail["companyDetail"];
                                userInfo2 = userInfo2;
                              });
                            }
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserDetails(
                                  contact: {},
                                  index: widget.index!,
                                ),
                              ),
                            );
                          }
                        },
                        icon: Icon(
                          Icons.done,
                          color: Colors.indigo.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: InkWell(
                    onTap: () async {
                      File? file = await showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        context: context,
                        builder: (context) {
                          return ChooseOptionsBottomSheet();
                        },
                      );
                      if (file != null) {
                        file;
                        if (file != null) {
                          setState(() {
                            imageFile = file;
                          });
                        }
                      }
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: ClipOval(
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          color: Colors.indigo.shade900,
                        ),
                        child: ClipOval(
                          child: imageFile != null
                              ? Image.file(
                            imageFile!,
                            fit: BoxFit.cover,
                          )
                              : Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Icon(
                                Icons.person,
                                size: 40,
                                color: Color(0xffB5C0FF),
                              )),
                        ),
                      ),
                    ),
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
                          fontSize: 15, color: Colors.indigo.shade900),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                MyTextFormField(
                  controller: bilnumberController,
                  label: "Bil Number (બિલ નંબર)",
                  keyboardType: TextInputType.number,
                  validator: (bilnumber) {
                    if (bilnumber == null || bilnumber.trim().isEmpty) {
                      return "Please enter bil number";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                MyTextFormField(
                  controller: nameController,
                  label: "Company Name (કંપની નામ)",
                  validator: (name) {
                    if (name == null || name.trim().isEmpty) {
                      return "Please enter name";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                MyTextFormField(
                  controller: aavelahiravajanController,
                  label: "Aavela Hira Vajan  (આવેલા હીરા વજન)",
                  validator: (aavelahiravajan) {
                    if (aavelahiravajan == null ||
                        aavelahiravajan.trim().isEmpty) {
                      return "Please enter aavela hira vajan";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                MyTextFormField(
                  controller: diamondController,
                  label: "Diamond Type (ડાઇમંડ પ્રકાર)",
                  validator: (diamondtype) {
                    if (diamondtype == null || diamondtype.trim().isEmpty) {
                      return "Please enter diamond type";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                MyTextFormField(
                  controller: jamaController,
                  label: "Jama Diamond (જમા ડાઇમંડ)",
                  validator: (jamadiamond) {
                    if (jamadiamond == null || jamadiamond.trim().isEmpty) {
                      return "Please enter damage diamond";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                MyTextFormField(
                  controller: kachahiraController,
                  label: "Raw Diamond (કાચા ડાઇમંડ)",
                  validator: (kachahira) {
                    if (kachahira == null || kachahira.trim().isEmpty) {
                      return "Please enter raw diamond";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20),
                MyTextFormField(
                  controller: damageController,
                  label: "Damage Diamond (ડેમેજ ડાઇમંડ)",
                  validator: (damagediamond) {
                    if (damagediamond == null || damagediamond.trim().isEmpty) {
                      return "Please enter damage diamond";
                    } else {
                      return null;
                    }
                  },
                ),
                SelectGroupBtn(
                  onTap: () async {
                    final selected = await Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) {
                          return SelectGroup(list: mySelectedGroup);
                        },
                      ),
                    );
                    mySelectedGroup = selected;
                    setState(() {});
                  }, onGroupsSelected: (List<String> selectedGroups) {  },
                ),
                SizedBox(height: 10),
                MyTextFormField(
                  controller: itemController,
                  label: "Items (નંગ)",
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  ],
                  validator: (items) {
                    if (items == null || items.trim().isEmpty) {
                      return null;
                    } else {
                      Pattern pattern = r'^\d+\.?\d{0,9}';
                      RegExp regexp = RegExp(pattern.toString());
                      if (regexp.hasMatch(items.trim())) {
                        return null;
                      } else {
                        return "Please enter valid items";
                      }
                    }
                  },
                ),
                SizedBox(height: 20),
                MyTextFormField(
                  controller: amountController,
                  label: "Amount (ભાવ)",
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  ],
                  validator: (amount) {
                    if (amount == null || amount.trim().isEmpty) {
                      return null;
                    } else {
                      Pattern pattern = r'^\d+\.?\d{0,9}';
                      RegExp regexp = RegExp(pattern.toString());
                      if (regexp.hasMatch(amount.trim())) {
                        return null;
                      } else {
                        return "Please enter valid amount";
                      }
                    }
                  },
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        double item = double.parse(itemController.text);
                        double amount = double.parse(amountController.text);
                        double total = item * amount;

                        setState(() {
                          itemList.add({
                            'item': item,
                            'amount': amount,
                            'total': total,
                          });
                        });
                        totalController.text = itemList
                            .map((item) => item['total'])
                            .reduce((value, element) => value + element)
                            .toString();
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color(0xffB5C0FF),
                        )),
                    child: Text(
                      "Total",
                      style: TextStyle(
                        color: Colors.indigo.shade900,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: itemList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text("Item: ${itemList[index]['item']}"),
                      subtitle: Text("Amount: ${itemList[index]['amount']}"),
                      trailing: Text("Total: ${itemList[index]['total']}"),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}