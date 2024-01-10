import 'package:flutter/material.dart';

Widget leadingIcon<T>(BuildContext context,{T? result}){
  return InkWell(
    onTap: (){
      if(Navigator.canPop(context)) {
        Navigator.pop(context,result);
      }
    },
    child: Icon(
      Icons.arrow_back_ios_new,
      size: 18,
      color: Colors.indigo.shade900,
    ),
  );
}