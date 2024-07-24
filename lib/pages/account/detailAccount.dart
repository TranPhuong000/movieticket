import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AccountDetailPage extends StatefulWidget {
  const AccountDetailPage({super.key});

  @override
  State<AccountDetailPage> createState() => _AccountDetailPageState();
}

class _AccountDetailPageState extends State<AccountDetailPage> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final data = await getUserData();
    print(data);
    setState(() {
      userData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Màu nền của trang
      appBar: AppBar(
        title: const Text('Tài khoản'),
        elevation: 0, // Bỏ đổ bóng của AppBar
        backgroundColor: Colors.grey[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/ava.png'),
            ),
            const SizedBox(height: 16),
            userData != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userData!['hoTen'],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Màu chữ của tên người dùng
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        userData!['email'],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey, // Màu chữ của email
                        ),
                      ),
                    ],
                  )
                : const Center(
                    child:
                        CircularProgressIndicator()), // Hiển thị vòng tròn tải khi chưa có dữ liệu
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.white),
              title: const Text('Số điện thoại',
                  style: TextStyle(color: Colors.white)),
              subtitle: Text(userData?['soDT'] ?? '0,123,456,789',
                  style: const TextStyle(color: Colors.grey)),
              tileColor: Colors.grey[800], // Màu nền của ListTile
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListTile(
              leading: const Icon(Icons.email, color: Colors.white),
              title: const Text('Email', style: TextStyle(color: Colors.white)),
              subtitle: Text(userData?['email'] ?? 'a@gmail.com',
                  style: const TextStyle(color: Colors.grey)),
              tileColor: Colors.grey[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const Divider(color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'Thông tin tài khoản',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text('Thành viên vào: Tháng 1 2024',
                style: TextStyle(color: Colors.grey)),
            const Text('Đăng ký: Premium',
                style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

Future<Map<String, dynamic>?> getUserData() async {
  final prefs = await SharedPreferences.getInstance();
  final userDataString = prefs.getString('userData');
  if (userDataString != null) {
    return jsonDecode(userDataString);
  }
  return null;
}
