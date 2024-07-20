import 'package:flutter/material.dart';

class SettingProvider extends ChangeNotifier {
  // bool _isVisible = false;
  // bool get isVisible => _isVisible;

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

  //Strong password requirement
  // RegExp strongPassword =
  //     RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  // RegExp emailRequirements = RegExp(
  //     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  //General Validator
  validator(String value, String message) {
    if (value.isEmpty) {
      return message;
    } else {
      return null;
    }
  }

  // Phone number validate
  phoneValidator(String value) {
    if (value.isEmpty) {
      return "Nhập số điện thoại";
    } else if (value.length > 10 || value.length <= 9) {
      return "Số điện thoại không hơp lệ";
    } else {
      return null;
    }
  }

  //Password number validator
  //Strong Password requirements
  /*
  1. must have a small letter
  2. must have a capital letter
  3. must have a digit or number
  4. contain a special chẩcter
  5. minimum 8 character long 
  */
  passwordValidator(String value) {
    if (value.isEmpty) {
      return "Nhập mật khẩu";
      // } else if (!strongPassword.hasMatch(value)) {
      //   return "Mật khẩu không đủ mạnh";
    } else {
      return null;
    }
  }

  //Confirm Password
  confirmPass(String value1, String value2) {
    if (value1.isEmpty) {
      return "Nhập mật khẩu";
    } else if (value1 != value2) {
      return "Mật khẩu không trùng khớp";
    } else {
      return null;
    }
  }

  //Email validator
  emailValidator(String value) {
    if (value.isEmpty) {
      return "Nhập tên tài khoản";
      // } else if (!emailRequirements.hasMatch(value)) {
      //   return "tên tài khoản không hợp lệ";
    } else {
      return null;
    }
  }

  // //Password show & hide
  // void showHidePassword() {
  //   _isVisible = !_isVisible;
  //   notifyListeners();
  // }

  // Password show & hide for Password
  void showHidePassword() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  // Password show & hide for Confirm Password
  void showHideConfirmPassword() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  //SnackBar Message
  showSnackBar(String message, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(message),
      ),
    );
  }
}
