import 'package:flutter/material.dart';

class NoContactPage extends StatelessWidget {
  const NoContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.connect_without_contact,size: 100,color: Colors.indigo.shade900,),
          SizedBox(height: 15),
          Text(
            "Your Contact list is empty",
            style: TextStyle(
              color: Color(0xffB5C0FF),
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "Enter user data",
            style: TextStyle(
              color: Color(0xffB5C0FF),
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
