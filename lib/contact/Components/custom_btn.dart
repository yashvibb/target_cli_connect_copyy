import 'package:flutter/material.dart';
import '../Constants/color_const.dart';
import '../HelperFunctions/my_text_style.dart';

// class CustomBtn extends StatelessWidget {
//   final String title;
//   final void Function() onPressed;
//   final TextStyle? textStyle;
//
//   const CustomBtn({
//     Key? key,
//     this.title = "Save",
//     required this.onPressed,
//     this.textStyle,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         elevation: 0.0,
//         backgroundColor: Colors.indigo.shade900,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(5.0),
//         ),
//       ),
//       onPressed: onPressed,
//       child: Text(
//         title,
//         style: textStyle ?? MyTextStyle.medium.copyWith(
//           fontSize: 15,
//           color: Color(0xffB5C0FF),
//         ),
//       ),
//     );
//   }
// }

class CustomBtn extends StatelessWidget {
  final Icon icon;
  final void Function() onPressed;
  final TextStyle? textStyle;

  const CustomBtn({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      onPressed: onPressed,
      child: icon,
    );
  }
}
