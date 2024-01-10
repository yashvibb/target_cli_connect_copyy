import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Constants/color_const.dart';
import '../../HelperFunctions/my_text_style.dart';

class SelectGroupBtn extends StatelessWidget {
  final void Function(List<String> selectedGroups) onGroupsSelected;

  const SelectGroupBtn({
    Key? key,
    required this.onGroupsSelected, required Future<Null> Function() onTap,
  }) : super(key: key);

  Future<void> _selectGroups(BuildContext context) async {
    try {
      // Access your Firebase Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Fetch groups from Firestore
      QuerySnapshot querySnapshot = await firestore.collection('groups').get();

      // Extract group names from the query result
      List<String> groups = querySnapshot.docs.map((doc) => doc['name'].toString()).toList();

      // Show a dialog or navigate to another page for group selection
      // For simplicity, let's just print the groups here
      print('Available groups: $groups');

      // Call the callback with the selected groups
      onGroupsSelected(groups);
    } catch (e) {
      print("Error fetching groups: $e");
      // Handle error, show a message, etc.
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectGroups(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Select Group",
              style: MyTextStyle.semiBold.copyWith(
                fontSize: 15,
                color: Colors.indigo.shade900,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: Colors.indigo.shade900,
            ),
          ],
        ),
      ),
    );
  }
}
