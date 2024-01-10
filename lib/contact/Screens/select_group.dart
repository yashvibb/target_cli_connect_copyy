import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import '../Constants/color_const.dart';
import '../HelperFunctions/my_text_style.dart';
import 'Components/leading_icon.dart';

class SelectGroup extends StatefulWidget {
  final List<String> list;

  const SelectGroup({Key? key, required this.list}) : super(key: key);

  @override
  State<SelectGroup> createState() => _SelectGroupState();
}

class _SelectGroupState extends State<SelectGroup> {
  final List<String> original = [
    "Income",
    "Expense",
  ];

  List<String> selected = [];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    selected = widget.list;
    super.initState();
  }

  Future<void> _updateSelectedGroups() async {
    // Get the current user
    User? user = _auth.currentUser;
    if (user != null) {
      // Update the selected groups in Firestore
      await _firestore.collection('users').doc(user.uid).set({
        'selectedGroups': selected,
      }, SetOptions(merge: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffB5C0FF),
        title: Text(
          "Select Group",
          style: TextStyle(color: Colors.indigo.shade900),
        ),
        leading: leadingIcon(context, result: selected),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 13,
        ),
        child: ListView.builder(
          itemCount: original.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
              dense: true,
              title: Text(
                original.elementAt(index),
                style: MyTextStyle.semiBold.copyWith(
                  color: Colors.indigo.shade900,
                ),
              ),
              value: selected.contains(
                original.elementAt(index),
              ),
              onChanged: (update) {
                setState(() {
                  if (selected.contains(original.elementAt(index))) {
                    selected.remove(original.elementAt(index));
                  } else {
                    selected.add(original.elementAt(index));
                  }

                  // Call the method to update selected groups in Firestore
                  _updateSelectedGroups();
                });
              },
            );
          },
        ),
      ),
    );
  }
}