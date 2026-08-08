import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class TextFieldWidget extends StatelessWidget {
  TextEditingController controller;
  String hint;
  TextInputType type;
  IconData icon;
  String tooltip = '';
  List<TextInputFormatter>? inputFormatters;
  VoidCallback onTap;
  VoidCallback onTextFieldTAp;

  TextFieldWidget({super.key, required this.type, required this.controller,required this.hint,required this.icon, this.inputFormatters, required this.tooltip,required this.onTap,required this.onTextFieldTAp});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 7.w),
      margin: EdgeInsetsDirectional.symmetric(vertical: 5.h),
      width: 320.w,
      height: 40.h,
      child: TextField(
        onTap: onTextFieldTAp,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        inputFormatters: inputFormatters,
        keyboardType: type,
        controller: controller,
        style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: RotatedBox(quarterTurns: 3,
          child: IconButton(icon: Icon(icon), onPressed: onTap,splashColor: Colors.red,tooltip: tooltip,)),
          hintText: hint,
          focusedBorder: InputBorder.none,
          fillColor: Colors.black54,
        ),),
    );
  }
}
