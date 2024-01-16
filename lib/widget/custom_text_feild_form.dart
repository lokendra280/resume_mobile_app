import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resume_app/common/theme.dart';
import 'package:resume_app/common/utils/size_utils.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.width = double.infinity,
    this.height,
    this.fontSize = 14,
    this.labelText,
    this.isObscureText = false,
    this.initialValue,
    this.textInputType,
    this.controller,
    this.validator,
    this.color = CustomTheme.primaryColor,
    this.prefixIcon,
    this.maxLength,
    this.onTap,
    this.onChanged,
    this.suffixIcon,
    this.isReadOnly = false,
    this.isRequired = false,
    this.maxLines = 1,
    this.helperText,
    this.textInputFormatterList,
    this.bottomMargin,
    this.textInputAction,
    this.hintText,
    TextStyle? helperStyle,
  }) : super(key: key);

  final double? width;
  final double? height;
  final double fontSize;
  final String? labelText;
  final bool isObscureText;
  final bool isReadOnly;
  final Color color;
  final String? initialValue;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLength;
  final Function()? onTap;
  final void Function(String)? onChanged;
  final bool isRequired;
  final int maxLines;
  final String? helperText;
  final List<TextInputFormatter>? textInputFormatterList;
  final double? bottomMargin;
  final TextInputAction? textInputAction;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: bottomMargin ?? 20),
      width: width,
      height: height,
      child: TextFormField(
        textAlign: maxLength != null ? TextAlign.center : TextAlign.left,
        controller: controller,
        keyboardType: textInputType,
        obscureText: isObscureText,
        cursorColor: color,
        initialValue: initialValue,
        validator: validator,
        maxLength: maxLength,
        onChanged: onChanged,
        onTap: onTap,
        readOnly: isReadOnly,
        maxLines: maxLines,
        textInputAction: textInputAction,
        inputFormatters: textInputFormatterList,
        style: maxLength == 1
            ? TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w400)
            : TextStyle(
                color: CustomTheme.black,
                fontSize: fontSize,
                fontWeight: FontWeight.w400),
        decoration: InputDecoration(
            hintText: hintText,
            contentPadding:
                EdgeInsets.symmetric(vertical: 16.hp, horizontal: 20.wp),
            counterText: "",
            helperText: helperText,
            helperStyle: const TextStyle(
              inherit: true,
              color: CustomTheme.primaryColor,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: color,
                ),
                borderRadius: BorderRadius.circular(6)),
            labelText: labelText != null
                ? isRequired
                    ? "$labelText * "
                    : labelText
                : null,
            alignLabelWithHint: true,
            labelStyle: const TextStyle(
              color: CustomTheme.black,
              fontSize: 12,
            )),
      ),
    );
  }
}
