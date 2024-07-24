import 'package:flutter/material.dart';
import 'package:movie/api_service.dart';
import 'package:movie/mainPage.dart';
import 'package:movie/pages/account/about.dart';
import 'package:movie/pages/account/cinema.dart';
import 'package:movie/pages/account/contact.dart';
import 'package:movie/pages/account/detailAccount.dart';
import 'package:movie/pages/login_signup/login_screen.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
    fetchUserDataAndLichSuDatVe();
  }

  Map<String, dynamic>? userData1;
  List<dynamic>? danhSachDatVe; // Danh sách thông tin đặt vé từ API
  final ApiService apiService =
      ApiService(baseUrl: 'https://movienew.cybersoft.edu.vn');

  Future<void> fetchUserDataAndLichSuDatVe() async {
    try {
      final data = await getUserData();
      if (data != null) {
        setState(() {
          userData1 = data;
        });

        final result = await apiService.postRequest(
          '/api/QuanLyNguoiDung/ThongTinTaiKhoan',
          {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${data['accessToken']}',
            'TokenCybersoft':
                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZW5Mb3AiOiJCb290Y2FtcCA2NCIsIkhldEhhblN0cmluZyI6IjA4LzA5LzIwMjQiLCJIZXRIYW5UaW1lIjoiMTcyNTc1MzYwMDAwMCIsIm5iZiI6MTY5NTkyMDQwMCwiZXhwIjoxNzI1OTAxMjAwfQ.fWIHiHRVx9B7UlCgFCwvvXAlcVc-I-RB603rEDsM_wI',
          },
          {},
        );

        if (result['content'] is List) {
          setState(() {
            danhSachDatVe = result['content'];
          });
        } else {
          print('Error: Unexpected data type for danhSachDatVe');
        }
      } else {
        print('No user data found');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: <Widget>[
          _buildProfileHeader(),
          _buildMenuItem(
            icon: Icons.account_circle,
            title: 'Thông tin Tài khoản',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AccountDetailPage();
              }));
            },
          ),
          _buildMenuItem(
            icon: Icons.lock,
            title: 'Đổi mật khẩu',
            onTap: () {
              _showChangePasswordDialog(context);
            },
          ),
          _buildMenuItem(
            icon: Icons.contact_emergency,
            title: 'Liên Hệ',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const ContactPage();
              }));
            },
          ),
          _buildMenuItem(
            icon: Icons.account_balance,
            title: 'Các Rạp Chiếu',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const CinemaPage();
              }));
            },
          ),
          _buildMenuItem(
            icon: Icons.contact_page,
            title: 'Về Chúng Tôi',
            onTap: () {
              print('Về chúng tôi');
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AboutUsPage();
              }));
            },
          ),
          _buildMenuItem(
            icon: Icons.history,
            title: 'Lịch sử Đặt Vé',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const Mainpage(
                  initialIndex: 2,
                );
              }));
            },
          ),
          _buildMenuItem(
            icon: Icons.logout,
            title: 'Đăng Xuất',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const LoginScreen();
              }));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(
                'assets/images/ava.png'), // Add your avatar image in assets folder
          ),
          const SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                userData1 != null
                    ? userData1!['hoTen'] ?? 'User Name'
                    : 'User Name',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4.0),
              const Row(
                children: <Widget>[
                  Icon(Icons.camera_alt, size: 16.0, color: Colors.lightBlue),
                  SizedBox(width: 4.0),
                  Text(
                    'Thành viên',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.lightBlue),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.white),
      onTap: onTap,
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newPassword = '';

        return AlertDialog(
          backgroundColor: Colors.grey[850],
          title:
              const Text('Đổi mật khẩu', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Nhập mật khẩu cũ',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent),
                  ),
                ),
                onChanged: (value) {
                  newPassword = value;
                },
              ),
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Nhập mật khẩu mới',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.redAccent),
                  ),
                ),
                onChanged: (value) {
                  newPassword = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Hủy', style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Đổi mật khẩu',
                  style: TextStyle(color: Colors.redAccent)),
              onPressed: () {
                print('New Password: $newPassword');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
