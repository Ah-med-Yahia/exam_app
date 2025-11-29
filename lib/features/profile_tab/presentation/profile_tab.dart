import 'dart:io';

import 'package:exam_app/core/constants/ui_constants.dart';
import 'package:exam_app/core/resources/color_managar.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final userNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                UiConstants.profile,
                style: getMediumStyle(
                  color: ColorManager.black,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Spacer(),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 40.r,
                        backgroundImage: _image != null
                            ? FileImage(_image!)
                            : AssetImage('assets/images/person.jpg'),
                      ),
                      InkWell(
                        onTap: pickImage,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            PathsConstants.profileImage,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                ],
              ),
              SizedBox(height: 25.h),
              CustomTextFormField(
                label: UiConstants.userName,
                hintText: userNameController.text,
              ),
              SizedBox(height: 5.h),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      label: UiConstants.firstName,
                      hintText: userNameController.text,
                    ),
                  ),
                  SizedBox(width: 17.h),
                  Expanded(
                    child: CustomTextFormField(
                      label: UiConstants.lastName,
                      hintText: lastNameController.text,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h),
              CustomTextFormField(
                label: UiConstants.email,
                hintText: emailController.text,
              ),
              SizedBox(height: 5.h),
              CustomTextFormField(
                label: UiConstants.password,
                hintText: passwordController.text,
              ),
              SizedBox(height: 5.h),
              CustomTextFormField(
                label: UiConstants.phoneNumber,
                hintText: phoneController.text,
              ),
              SizedBox(height: 40.h),
              CustomElevatedButton(
                label: UiConstants.updata,
                backgroundColor: ColorManager.blue,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}