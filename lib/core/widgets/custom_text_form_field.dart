import 'package:exam_app/core/resources/color_managar.dart';
import 'package:exam_app/core/resources/font_managar.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/resources/values_managar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
  final String label;
  final bool obscureText;
  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final TextInputType keyboardType;
  final int maxLines;
  final Color labelColor;
  final Color borderColor;

  const CustomTextFormField({
    super.key,
    required this.label,
    this.obscureText = false,
    required this.hintText,
    this.validator,
    this.controller,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.labelColor=ColorManager.darkGrey,
    this.borderColor=ColorManager.black
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool hasError = false;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 70.h,
      child: TextFormField(
        obscureText: widget.obscureText,
        maxLines: widget.maxLines,
        keyboardType: widget.keyboardType,
        validator: (value) {
          final result = widget.validator?.call(value);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && hasError != (result != null)) {
              setState(() => hasError = result != null);
            }
          });
          return result;
        },
        onChanged: widget.onChanged,
        controller: widget.controller,
        autovalidateMode: AutovalidateMode.onUnfocus,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: getRegularStyle(color: widget.labelColor,),
          
          floatingLabelBehavior: FloatingLabelBehavior.always,
          floatingLabelStyle: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeightManager.regular,
            color: hasError ? ColorManager.red : ColorManager.darkGrey,
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: FontSize.s14,
            fontWeight: FontWeightManager.regular,
            color: ColorManager.lightGrey,
          ),
          contentPadding: EdgeInsets.only(
            left: Insets.s16.sp,
            top: Insets.s16.sp,
            bottom: Insets.s16.sp,
          ),
           border: _buildBorder(color: widget.borderColor),
              enabledBorder: _buildBorder(color: widget.borderColor),
          errorBorder: _buildBorder(color: ColorManager.red),
          focusedErrorBorder: _buildBorder(color: ColorManager.red, width: 2),
          focusedBorder: _buildBorder(color: widget.borderColor, width: 2),
          
        ),
        cursorColor: ColorManager.black,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
      ),
    );
  }

  OutlineInputBorder _buildBorder({required Color color, double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}