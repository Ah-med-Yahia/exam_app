import 'package:exam_app/core/resources/color_managar.dart';
import 'package:exam_app/core/resources/font_managar.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/resources/values_managar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
  final String? label;
  final bool obscureText;
  final String hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final TextInputType keyboardType;
  final int maxLines;
  final Color labelColor;

  final Widget? prefixIcon;
  final double? radius;

  const CustomTextFormField({
    super.key,
    this.label,
    this.obscureText = false,
    required this.hintText,
    this.validator,
    this.controller,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.labelColor = ColorManager.darkGrey,
    this.prefixIcon,
    this.radius,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool hasError = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        final result = widget.validator?.call(widget.controller?.text);
        setState(() {
          hasError = result != null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: TextFormField(
        focusNode: _focusNode,
        obscureText: widget.obscureText,
        maxLines: widget.maxLines,
        keyboardType: widget.keyboardType,
        validator: (value) {
          final result = widget.validator?.call(value);
          return result;
        },
        onChanged: widget.onChanged,
        controller: widget.controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          labelText: widget.label,
          labelStyle: getRegularStyle(
            color: hasError ? ColorManager.red : ColorManager.darkGrey,
          ),
          errorMaxLines: 2,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          floatingLabelStyle: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeightManager.regular,
            color: hasError ? ColorManager.red : ColorManager.darkGrey,
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: FontSize.s12.sp,
            fontWeight: FontWeightManager.regular,
            color: ColorManager.lightGrey,
          ),
          contentPadding: EdgeInsets.only(
            left: Insets.s16.sp,
            top: Insets.s16.sp,
            bottom: Insets.s16.sp,
          ),
          border: _buildBorder(color: ColorManager.black),
          enabledBorder: _buildBorder(color: ColorManager.black),
          errorBorder: _buildBorder(color: ColorManager.red),
          focusedErrorBorder: _buildBorder(color: ColorManager.red, width: 2),
          focusedBorder: _buildBorder(
            color: hasError ? ColorManager.red : ColorManager.black,
            width: 2,
          ),
        ),
        cursorColor: ColorManager.black,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
      ),
    );
  }

  OutlineInputBorder _buildBorder({required Color color, double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.radius ?? 4.r),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
