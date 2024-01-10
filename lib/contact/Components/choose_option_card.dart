import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Constants/color_const.dart';
import '../HelperFunctions/my_text_style.dart';

class ChooseOptionCard extends StatelessWidget {
  final String assetPath;
  final String title;
  final void Function() onTap;

  const ChooseOptionCard({
    Key? key,
    required this.assetPath,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Call the sign-out method when the card is tapped
        _signOut();
        onTap();
      },
      splashColor: Color(0xffB5C0FF),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            height: 30,
            child: Image.asset(
              assetPath,
              color: Colors.indigo.shade900,
            ),
          ),
          const SizedBox(width: 15),
          Text(
            title,
            style: MyTextStyle.medium.copyWith(
              color: Colors.indigo.shade900,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}