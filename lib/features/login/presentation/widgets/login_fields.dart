import 'package:flutter/material.dart';
import 'package:online_plants_app/core/utils/app_color.dart';
import 'package:online_plants_app/core/utils/form_field.dart';
import 'package:online_plants_app/core/utils/size.dart';
import 'package:online_plants_app/core/utils/validation.dart';

class MobileNumberField extends StatelessWidget {
  const MobileNumberField({
    super.key,
    required this.mobileNoController,
  });

  final TextEditingController mobileNoController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: mobileNoController,
      cursorColor: AppColor.skGreenColor,
      cursorErrorColor: AppColor.skGreenColor,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.start,
      keyboardType: TextInputType.number,
      maxLength: 10,
      validator: (value) => mobileNumberValidator(value),
      decoration: formFieldDecoration(
        hintText: 'Enter your mobile nu',
        prefixIcon: Padding(
          padding: const EdgeInsets.only(right: 5.0, left: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.phone,
                size: getHeight(25),
              ),
              Text(
                '+91 ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Container(
                height: getHeight(25),
                color: AppColor.skGreenColor,
                width: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.passController,
    required bool passVisible,
    required this.onChange,
  }) : _passVisible = passVisible;

  final TextEditingController passController;
  final bool _passVisible;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passController,
      cursorColor: AppColor.skGreenColor,
      cursorErrorColor: AppColor.skGreenColor,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.start,
      keyboardType: TextInputType.visiblePassword,
      validator: (value) => passwordValidator(value),
      obscureText: _passVisible,
      obscuringCharacter: '*',
      decoration: formFieldDecoration(
        hintText: 'Password',
        prefixIcon: Icon(
          Icons.lock,
          size: getHeight(25),
        ),
        suffixIcon: GestureDetector(
          onTap: onChange,
          child: Icon(
            _passVisible ? Icons.visibility_off : Icons.visibility,
            size: getHeight(25),
            color: AppColor.skGreenColor,
          ),
        ),
      ),
    );
  }
}

class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
    required this.emailController,
  });

  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      cursorColor: AppColor.skGreenColor,
      cursorErrorColor: AppColor.skGreenColor,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.start,
      keyboardType: TextInputType.emailAddress,
      validator: (value) => emailValidator(value),
      decoration: formFieldDecoration(
        hintText: 'Enter your email',
        prefixIcon: Icon(
          Icons.email,
          size: getHeight(25),
        ),
      ),
    );
  }
}

class UserNameField extends StatelessWidget {
  const UserNameField({
    super.key,
    required this.userNameController,
  });

  final TextEditingController userNameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: userNameController,
      cursorColor: AppColor.skGreenColor,
      cursorErrorColor: AppColor.skGreenColor,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.start,
      keyboardType: TextInputType.emailAddress,
      validator: (value) => usernameValidator(value),
      decoration: formFieldDecoration(
        hintText: 'Enter full name',
        prefixIcon: Icon(
          Icons.person,
          size: getHeight(25),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String? labelText;
  final Widget? label;
  final bool isEdit;
  final String? hintText;
  final String? suffixText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? prefixText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Function()? onEditingComplete;
  final Function()? onTap;
  final Function(PointerDownEvent)? onTapOutside;
  final bool readOnly;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    super.key,
    required this.textController,
    this.labelText,
    this.label,
    this.isEdit = true,
    this.hintText,
    this.suffixText,
    this.suffixIcon,
    this.prefixIcon,
    this.prefixText,
    this.keyboardType,
    this.onChanged,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.onTap,
    this.onTapOutside,
    this.readOnly = false,
    this.validator,
  });

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      cursorColor: AppColor.skGreenColor,
      cursorErrorColor: AppColor.skGreenColor,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.start,
      keyboardType: keyboardType ?? TextInputType.name,
      onChanged: (value) {
        onChanged?.call(value);
      },
      onFieldSubmitted: (value) => onFieldSubmitted?.call(value),
      onEditingComplete: () => onEditingComplete?.call(),
      onTap: () => onTap?.call(),
      onTapOutside: (event) => onTapOutside?.call(event),
      readOnly: readOnly,
      validator: validator,
      decoration: formFieldDecoration(
        labelText: labelText,
        label: label,
        isEdit: isEdit,
        hintText: hintText,
        suffixText: suffixText,
        suffixIcon: suffixIcon,
        prefixText: prefixText,
      ),
    );
  }
}
