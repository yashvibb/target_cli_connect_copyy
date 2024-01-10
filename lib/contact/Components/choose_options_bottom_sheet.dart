import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Constants/color_const.dart';
import '../HelperFunctions/choose_photo.dart';
import '../HelperFunctions/my_text_style.dart';
import 'choose_option_card.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChooseOptionsBottomSheet extends StatelessWidget {
  const ChooseOptionsBottomSheet({
    Key? key,
  }) : super(key: key);

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Choose Option",
            style: TextStyle(
              color: Color(0xffB5C0FF),
              fontSize: 20,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 25),
            child: Divider(
              color: Colors.indigo.shade900,
              thickness: 1,
              height: 0.0,
            ),
          ),
          ChooseOptionCard(
            assetPath: "assets/image-gallery.png",
            title: "Gallery",
            onTap: () async {
              File? file = await gallery();
              // You can add Firebase-related functionality here if needed
              // For example, upload the selected image to Firebase Storage
              if (file != null) {
                // Implement your Firebase Storage upload code here
              }
              Navigator.pop(context, file);
            },
          ),
          const SizedBox(height: 10),
          ChooseOptionCard(
            assetPath: "assets/camera.png",
            title: "Camera",
            onTap: () async {
              File? file = await gallery(
                imageSource: ImageSource.camera,
              );
              // You can add Firebase-related functionality here if needed
              // For example, upload the selected image to Firebase Storage
              if (file != null) {
                // Implement your Firebase Storage upload code here
              }
              Navigator.pop(context, file);
            },
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: _signOut,
            child: Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
