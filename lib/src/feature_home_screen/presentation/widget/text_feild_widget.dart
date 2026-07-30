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

  TextFieldWidget({super.key, required this.type, required this.controller,required this.hint,required this.icon, this.inputFormatters, required this.tooltip,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 7.w),
      margin: EdgeInsetsDirectional.symmetric(vertical: 5.h),
      width: 320.w,
      height: 40.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(12),
        border: Border.all(color: Colors.purple,width: 2),
      ),
      child: TextField(
        inputFormatters: inputFormatters,
        keyboardType: type,
        controller: controller,
        style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,),
        decoration: InputDecoration(
          border: InputBorder.none,
          suffixIcon: IconButton(icon: Icon(icon), onPressed: onTap,splashColor: Colors.red,tooltip: tooltip,),
          hintText: hint,
          focusedBorder: InputBorder.none,
          fillColor: Colors.black54,
        ),),
    );
  }
}
