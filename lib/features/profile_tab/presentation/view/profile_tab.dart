import 'dart:io';
import 'package:exam_app/config/di/di.dart';
import 'package:exam_app/core/constants/ui_constants.dart';
import 'package:exam_app/core/resources/color_managar.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/utils/ui_utils.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/core/widgets/custom_text_form_field.dart';
import 'package:exam_app/features/profile_tab/presentation/cubit/edit_profile_cubit.dart';
import 'package:exam_app/features/profile_tab/presentation/cubit/edit_profile_intents.dart';
import 'package:exam_app/features/profile_tab/presentation/cubit/edit_profile_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  late TextEditingController _userNameController;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _phoneController;
  final _formKey = GlobalKey<FormState>();
  bool _controllersInitialized = false;
  String? _lastShownMessage;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
  }

  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      context.read<EditProfileCubit>().doIntent(
        ProfileImagePicked(pickedFile.path),
      );
    }
  }

  void _initializeControllers(EditProfileStates state) {
    if (!_controllersInitialized &&
        state.username.isNotEmpty &&
        state.isDataLoaded) {
      _userNameController.text = state.username;
      _firstNameController.text = state.firstName;
      _lastNameController.text = state.lastName;
      _emailController.text = state.email;
      _phoneController.text = state.phone;
      _controllersInitialized = true;
    }
  }

  void _updateControllers(EditProfileStates state) {
    if (_userNameController.text != state.username &&
        state.username.isNotEmpty) {
      _userNameController.text = state.username;
    }
    if (_firstNameController.text != state.firstName &&
        state.firstName.isNotEmpty) {
      _firstNameController.text = state.firstName;
    }
    if (_lastNameController.text != state.lastName &&
        state.lastName.isNotEmpty) {
      _lastNameController.text = state.lastName;
    }
    if (_emailController.text != state.email && state.email.isNotEmpty) {
      _emailController.text = state.email;
    }
    if (_phoneController.text != state.phone && state.phone.isNotEmpty) {
      _phoneController.text = state.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return getIt<EditProfileCubit>()..doIntent(LoadUserData());
      },
      child: SafeArea(
        child: BlocConsumer<EditProfileCubit, EditProfileStates>(
          listener: (context, state) {
            if (state.isUpdatedSuccessfully &&
                state.successMessage != null &&
                state.successMessage != _lastShownMessage) {
              _lastShownMessage = state.successMessage;
              UIUtils.showMessage(
                state.successMessage!,
                backGroundColor: ColorManager.green,
                textColor: ColorManager.white,
              );
              context.read<EditProfileCubit>().resetMessages();
              return;
            }

            if (state.successMessage != null &&
                state.successMessage!.contains(UiConstants.noChanesToUpdate) &&
                state.successMessage != _lastShownMessage) {
              _lastShownMessage = state.successMessage;
              UIUtils.showMessage(
                state.successMessage!,
                backGroundColor: Colors.orange,
                textColor: Colors.white,
              );
              context.read<EditProfileCubit>().resetMessages();
              return;
            }

            if (state.errorMessage != null &&
                state.errorMessage!.isNotEmpty &&
                state.errorMessage != _lastShownMessage) {
              _lastShownMessage = state.errorMessage;
              UIUtils.showMessage(
                state.errorMessage!,
                backGroundColor: ColorManager.red,
                textColor: ColorManager.white,
              );
              context.read<EditProfileCubit>().resetMessages();
            }

            if (state.errorMessage == null &&
                state.successMessage == null &&
                _lastShownMessage != null) {
              _lastShownMessage = null;
            }
          },
          builder: (context, state) {
            if (state.isDataLoaded && !_controllersInitialized) {
              _initializeControllers(state);
            }

            if (state.data != null) {
              _updateControllers(state);
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
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
                                  : (state.profileImagePath != null
                                            ? FileImage(
                                                File(state.profileImagePath!),
                                              )
                                            : AssetImage(
                                                PathsConstants.profileImage,
                                              ))
                                        as ImageProvider,
                            ),
                            InkWell(
                              onTap: pickImage,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  PathsConstants.cameraIcon,
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
                      hintText: UiConstants.enterUserName,
                      controller: _userNameController,
                      onChanged: (value) => context
                          .read<EditProfileCubit>()
                          .doIntent(UsernameChanged(value)),
                    ),
                    SizedBox(height: 5.h),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextFormField(
                            label: UiConstants.firstName,
                            hintText: UiConstants.enterFirstName,
                            controller: _firstNameController,
                            onChanged: (value) => context
                                .read<EditProfileCubit>()
                                .doIntent(FirstNameChanged(value)),
                          ),
                        ),
                        SizedBox(width: 17.w),
                        Expanded(
                          child: CustomTextFormField(
                            label: UiConstants.lastName,
                            controller: _lastNameController,
                            hintText: UiConstants.enterLastName,
                            onChanged: (value) => context
                                .read<EditProfileCubit>()
                                .doIntent(LastNameChanged(value)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    CustomTextFormField(
                      label: UiConstants.email,
                      controller: _emailController,
                      hintText: UiConstants.emailHintText,
                      onChanged: (value) => context
                          .read<EditProfileCubit>()
                          .doIntent(EmailChanged(value)),
                    ),
                    SizedBox(height: 5.h),
                    CustomTextFormField(
                      hintText: '',
                      label: UiConstants.password,
                      controller: _passwordController,
                      isPassworTextFormField: true,
                      enabled: false,
                    ),
                    SizedBox(height: 5.h),
                    CustomTextFormField(
                      hintText: UiConstants.enterPhoneNumber,
                      label: UiConstants.phoneNumber,
                      controller: _phoneController,
                      onChanged: (value) => context
                          .read<EditProfileCubit>()
                          .doIntent(PhoneChanged(value)),
                    ),
                    SizedBox(height: 40.h),
                    CustomElevatedButton(
                      label: UiConstants.updata,
                      backgroundColor: ColorManager.blue,
                      onTap: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<EditProfileCubit>().doIntent(
                            UpdateProfilePressed(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
