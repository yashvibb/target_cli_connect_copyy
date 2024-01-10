// import 'dart:convert';
// import 'package:flutter/material.dart';
// import '../HelperFunctions/shered_pref.dart';
//
// class ContactProvider extends ChangeNotifier {
//   List<Map<String, dynamic>> get contactList => readFromList();
//   List<Map<String, dynamic>> get contactList2 => readFromList2();
//
//   List<Map<String, dynamic>> readFromList() {
//     final original = sheredPref.contact;
//     return List<Map<String, dynamic>>.from(
//         original.map((e) => jsonDecode(e)).toList());
//   }
//
//   List<Map<String, dynamic>> readFromList2() {
//     final original = sheredPref.contact2;
//     return List<Map<String, dynamic>>.from(
//         original.map((e) => jsonDecode(e)).toList());
//   }
//   void createContact({required Map<String, dynamic> contact}) {
//     debugPrint('CreateNew : $contact');
//     final original = sheredPref.contact; // realList
//     original.add(jsonEncode(contact));
//     sheredPref.contact = original; // newList stored in SF.
//     notifyListeners();
//   }
//
//   void createContact2({required Map<String, dynamic> contact}) {
//     debugPrint('CreateNew : $contact');
//     final original = sheredPref.contact2; // realList
//     original.add(jsonEncode(contact));
//     sheredPref.contact2 = original; // newList stored in SF.
//     notifyListeners();
//   }
//
//   void deleteContact({required Map<String, dynamic> contact}) {
//     final original = sheredPref.contact;
//     original.remove(jsonEncode(contact));
//     sheredPref.contact = original;
//     notifyListeners();
//   }
//
//   void deleteContact2({required Map<String, dynamic> contact}) {
//     final original = sheredPref.contact2;
//     original.remove(jsonEncode(contact));
//     sheredPref.contact2 = original;
//     notifyListeners();
//   }
//
//   // updateContact
//   void updateContact({
//     required int index,
//     required Map<String, dynamic> contact,
//   }) {
//     final original = sheredPref.contact;
//     original[index] = jsonEncode(contact);
//     sheredPref.contact = original;
//     notifyListeners();
//   }
//   void updateContactTwo({
//     required int index,
//     required Map<String, dynamic> contact,
//   }) {
//     final original = sheredPref.contact2;
//     original[index] = jsonEncode(contact);
//     sheredPref.contact2 = original;
//     notifyListeners();
//   }
// }
