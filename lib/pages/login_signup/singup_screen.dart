import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie/components/button.dart';
import 'package:movie/components/input_field.dart';
import 'package:movie/components/snack_bar.dart';
import 'package:movie/pages/login_signup/login_screen.dart';
import 'package:movie/provider/setting_provoder.dart';
import 'package:provider/provider.dart';
import 'package:movie/components/custom_background.dart';
import 'package:flutter/services.dart';
import 'package:movie/api_service.dart';

class SignUpScreeen extends StatefulWidget {
  const SignUpScreeen({super.key});

  @override
  State<SignUpScreeen> createState() => _SignUpScreeenState();
}

class _SignUpScreeenState extends State<SignUpScreeen> {
  final accountNameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final groupCodeController = TextEditingController();
  final fullNameController = TextEditingController();

  final provider = SettingProvider();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  String response = '';
  final ApiService apiService =
      ApiService(baseUrl: 'https://movienew.cybersoft.edu.vn');

  Future<void> SignUp() async {
    setState(() {
      isLoading = true;
    });
    try {
      final result = await apiService.postRequest(
        '/api/QuanLyNguoiDung/DangKy',
        {
          'Content-Type': 'application/json',
          'TokenCybersoft':
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZW5Mb3AiOiJCb290Y2FtcCA2NCIsIkhldEhhblN0cmluZyI6IjA4LzA5LzIwMjQiLCJIZXRIYW5UaW1lIjoiMTcyNTc1MzYwMDAwMCIsIm5iZiI6MTY5NTkyMDQwMCwiZXhwIjoxNzI1OTAxMjAwfQ.fWIHiHRVx9B7UlCgFCwvvXAlcVc-I-RB603rEDsM_wI',
        },
        {
          'taiKhoan': accountNameController.text,
          'matKhau': passwordController.text,
          'email': emailController.text,
          'soDt': phoneController.text,
          'maNhom': groupCodeController.text,
          'hoTen': fullNameController.text,
        },
      );

      if (result != null && result['statusCode'] == 200) {
        setState(() {
          response = "Đăng ký thành công";
          showSnackBar(context, response);
        });

        // Xử lý đăng nhập thành công (chuyển hướng tới màn hình khác)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      } else {
        setState(() {
          response = "Lỗi đăng ký: ${result['message'] ?? 'Không xác định'}";
          showSnackBar(context, response);
        });
      }
    } catch (e) {
      setState(() {
        response = 'Lỗi đăng ký: ${e.toString()}';
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
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    groupCodeController.dispose();
    accountNameController.dispose();
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
            Positioned(
              top: 30,
              left: 2,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 130),
              child: Column(
                children: [
                  Text(
                    'Đăng Ký',
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
              padding: const EdgeInsets.only(top: 100.0),
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
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                      ),
                      //full name
                      InputField(
                        icon: Icons.account_circle_rounded,
                        label: "Tài khoản",
                        controller: accountNameController,
                        validator: (value) =>
                            provider.validator(value, "Nhập tên tài khoản"),
                      ),
                      const SizedBox(
                        height: 1,
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
                      }),
                      const SizedBox(
                        height: 1,
                      ),
                      //Email
                      InputField(
                        icon: Icons.email,
                        label: "Email",
                        controller: emailController,
                        inputType: TextInputType.emailAddress,
                        validator: (value) => provider.emailValidator(value),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      //Phone number
                      InputField(
                        icon: Icons.phone,
                        label: "Số điện thoại",
                        controller: phoneController,
                        inputType: TextInputType.phone,
                        inputFormat: [FilteringTextInputFormatter.digitsOnly],
                        validator: (value) => provider.phoneValidator(value),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      //Phone number
                      InputField(
                        icon: Icons.code,
                        label: "Mã nhóm",
                        controller: groupCodeController,
                        inputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      InputField(
                        icon: Icons.person,
                        label: "Họ tên",
                        controller: fullNameController,
                        inputType: TextInputType.visiblePassword,
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      const Text(
                        'Bằng việc nhấn nút đăng ký bên dưới, bạn đã đồng ý với các điều khoản của Ticket Trove',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      MyButton(onTap: SignUp, text: 'Đăng Ký'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
