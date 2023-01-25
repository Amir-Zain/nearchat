import 'package:flutter/material.dart';
import 'package:nearchat/ui/theme/appcolors.dart';

class TextFieldCustom extends StatelessWidget {
  final String hint;
  IconData? icon;
  bool onlyRead = false;
  TextEditingController? controller;
  final int maxLine;
  TextFieldCustom(
      {Key? key,
      this.hint = "",
      this.maxLine = 1,
      this.icon,
      this.controller,
      this.onlyRead = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: onlyRead,
      maxLines: maxLine,
      decoration: InputDecoration(
          suffixIcon: icon != null
              ? Icon(
                  icon,
                  size: 27,
                  color: AppColor.primaryColor,
                )
              : null,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(
                width: 0,
                color: AppColor.primaryColor,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(
                width: 0,
                color: Color.fromRGBO(117, 117, 117, 1),
                // color: Color.fromARGB(0, 194, 106, 34),
                style: BorderStyle.solid,
              )),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(
                width: 0,
                color: Color.fromRGBO(117, 117, 117, 1),
                // color: Color.fromARGB(0, 194, 106, 34),
                style: BorderStyle.solid,
              )),
          filled: true,
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey[500],
          ),
          fillColor: Colors.white),
    );
  }
}
