import 'package:flutter/material.dart';
import 'package:movie/mainPage.dart';
import 'package:movie/pages/account/about.dart';
import 'package:movie/pages/account/cinema.dart';
import 'package:movie/pages/account/contact.dart';
import 'package:movie/pages/account/detailAccount.dart';
import 'package:movie/pages/login_signup/login_screen.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key});

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
            title: 'Lịch sử Giao dịch',
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
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8.0),
      ),
      margin: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          const CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(
                'assets/images/avata.png'), // Add your avatar image in assets folder
          ),
          const SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Nguyen Kiet',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4.0),
              Row(
                children: const <Widget>[
                  Icon(Icons.camera_alt, size: 16.0, color: Colors.lightBlue),
                  SizedBox(width: 4.0),
                  Text(
                    'MEMBER',
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
