import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nearchat/ui/theme/appcolors.dart';

class TextFieldCustom extends StatelessWidget {
  final String hint;
  IconData? icon;
  TextInputType inputType;
  bool onlyRead;
  bool obscured;
  TextEditingController? controller;
  AutovalidateMode validation;
  bool onClick;
  Function()? notifyParentIconCLicl;
  final int maxLine;
  TextFieldCustom({
    Key? key,
    this.hint = "",
    this.maxLine = 1,
    this.icon,
    this.controller,
    this.validation = AutovalidateMode.disabled,
    this.inputType = TextInputType.text,
    this.onClick = false,
    this.obscured = false,
    this.onlyRead = false,
    this.notifyParentIconCLicl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: onClick ? validation : AutovalidateMode.disabled,
      controller: controller,
      readOnly: onlyRead,
      obscureText: obscured,
      maxLines: maxLine,
      keyboardType: inputType,
      validator: (value) =>
          EmailValidator.validate(value!) ? null : "Please enter a valid email",
      decoration: InputDecoration(
          isDense: true,
          suffixIcon: icon != null
              ? InkWell(
                  onTap: notifyParentIconCLicl,
                  child: Icon(
                    icon,
                    size: 27,
                    color: AppColor.primaryColor,
                  ),
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
