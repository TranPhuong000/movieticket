import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/components/button.dart';
import 'package:movie/components/input_field.dart';
import 'package:movie/components/custom_background.dart';
import 'package:movie/mainPage.dart';
import 'package:movie/pages/login_signup/singup_screen.dart';
import 'package:movie/provider/setting_provoder.dart';
import '../../components/snack_bar.dart';
import 'package:provider/provider.dart';
import 'package:movie/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final provider = SettingProvider();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  String response = '';
  final ApiService apiService =
      ApiService(baseUrl: 'https://movienew.cybersoft.edu.vn');

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    final prefs = await SharedPreferences.getInstance();
    bool isSaved = await prefs.setString('userData', jsonEncode(userData));
    if (isSaved) {
      print('Lưu dữ liệu thành công');
    } else {
      print('Lưu dữ liệu thất bại');
    }
  }

  Future<void> login() async {
    setState(() {
      isLoading = true;
    });
    try {
      final result = await apiService.postRequest(
        '/api/QuanLyNguoiDung/DangNhap',
        {
          'Content-Type': 'application/json',
          'TokenCybersoft':
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZW5Mb3AiOiJCb290Y2FtcCA2NCIsIkhldEhhblN0cmluZyI6IjA4LzA5LzIwMjQiLCJIZXRIYW5UaW1lIjoiMTcyNTc1MzYwMDAwMCIsIm5iZiI6MTY5NTkyMDQwMCwiZXhwIjoxNzI1OTAxMjAwfQ.fWIHiHRVx9B7UlCgFCwvvXAlcVc-I-RB603rEDsM_wI',
        },
        {
          'taiKhoan': usernameController.text,
          'matKhau': passwordController.text,
        },
      );

      print('Kết quả đăng nhập: $result');

      if (result != null && result['statusCode'] == 200) {
        setState(() {
          response = "Đăng nhập thành công";
          showSnackBar(context, response);
        });

        print('Dữ liệu: ${result['content']}  from dang nhapppp');

        if (result['content'] != null &&
            result['content'] is Map<String, dynamic>) {
          // Lưu trữ dữ liệu trả về
          await saveUserData(result['content']);
        } else {
          print('Dữ liệu trả về không hợp lệ');
        }

        // Xử lý đăng nhập thành công (chuyển hướng tới màn hình khác)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Mainpage()),
        );
      } else {
        setState(() {
          response = "Đăng nhập thất bại";
          showSnackBar(context, response);
        });
      }
    } catch (e) {
      setState(() {
        response = 'Lỗi đăng nhập: ${e.toString()}';
        showSnackBar(context, response);
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus(); // hide keyboard
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            const CustomBackground(),
            Padding(
              padding: const EdgeInsets.only(top: 80, left: 25),
              child: Column(
                children: [
                  Text(
                    'Chào mừng bạn đã trở lại',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontFamily: GoogleFonts.montserrat().fontFamily),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Text(
                    'Đăng nhập',
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: GoogleFonts.montserrat().fontFamily),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 280.0),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(48),
                    topRight: Radius.circular(48),
                  ),
                  color: Colors.white,
                ),
                height: double.infinity,
                width: double.infinity,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 22.0),
                      ),
                      //Email
                      InputField(
                        icon: Icons.email,
                        label: "Tên tài khoản",
                        controller: usernameController,
                        inputType: TextInputType.name,
                        validator: (value) => provider.emailValidator(value),
                      ),

                      const SizedBox(
                        height: 18,
                      ),

                      //Password
                      Consumer<SettingProvider>(
                        builder: (context, notifier, child) {
                          return InputField(
                            icon: Icons.lock,
                            label: "Mật khẩu",
                            controller: passwordController,
                            isVisible: !notifier.isPasswordVisible,
                            trailing: IconButton(
                              onPressed: () => notifier.showHidePassword(),
                              icon: Icon(!notifier.isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                            validator: (value) =>
                                provider.passwordValidator(value),
                          );
                        },
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Quên mật khẩu?',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MyButton(
                        onTap: login,
                        text: isLoading ? 'Đang xử lý...' : 'Đăng Nhập',
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 80, horizontal: 15),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Bạn chưa có tài khoản?',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 17,
                                        fontFamily: GoogleFonts.montserrat()
                                            .fontFamily),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpScreeen()),
                                  );
                                },
                                child: Text(
                                  'Đăng ký',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      fontFamily:
                                          GoogleFonts.montserrat().fontFamily),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
